import 'package:flutter/foundation.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/state/data_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio/core/config/supabase_config.dart';
import '../../../../core/services/secure_storage_service.dart';

class AdminAuthProvider with ChangeNotifier {
  final SupabaseClient? supabase;
  AdminAuthProvider({this.supabase});

  // ==================== STATE (Using DataState) ====================
  DataState<Map<String, dynamic>> _authState = DataState.initial();

  // ==================== GETTERS ====================
  bool get isLoading => _authState.isLoading;
  String? get errorMessage => _authState.errorMessage;
  Map<String, dynamic>? get currentAdmin => _authState.data;
  String? get adminName => currentAdmin?['display_name'];
  String? get adminId => currentAdmin?['id'];

  // ==================== STATE GETTERS  ====================
  DataState<Map<String, dynamic>> get authState => _authState;

  // ==================== LOGIN ====================
  Future<DataState<Map<String, dynamic>>> login(String username, String password) async {
    _authState = DataState.loading();
    notifyListeners();
    debugPrint('🔐 [AUTH] Login attempt for: ${username.trim().toLowerCase()}');

    try {
      final response = await supabase!
          .from(SupabaseConfig.adminsTable)
          .select()
          .eq('username', username.trim().toLowerCase())
          .eq('is_active', true)
          .maybeSingle();

      // Check if admin found
      if (response == null) {
        _authState = DataState.error('Invalid username or password', previousData: _authState.data);
        notifyListeners();
        debugPrint('❌ [AUTH] Login failed: User not found');
        return _authState;
      }

      // Check password (compare hashed)
      if (response['password'] != password) {
        _authState = DataState.error('Invalid username or password', previousData: _authState.data);
        notifyListeners();
        debugPrint('❌ [AUTH] Login failed: Password mismatch');
        return _authState;
      }

      // Success - Save session to secure storage
      await SecureStorageService.saveSession(
        adminId: response['id'],
        email: response['email'],
        username: response['username'],
        displayName: response['display_name'],
      );

      // Update authentication state
      _authState = DataState.success(response);
      notifyListeners();

      return _authState;
    } catch (e) {
      final failure = ExceptionHandler.parseToFailure(e, context: 'Admin login');
      _authState = DataState.error(failure.message);
      notifyListeners();
      return _authState;
    }
  }

  // ==================== CHECK SESSION ====================
  Future<bool> checkSession() async {
    try {
      final session = await SecureStorageService.hasValidSession();
      if (session) {
        debugPrint('✅ [AUTH] Session restored');
        return true;
      } else {
        debugPrint('❌ [AUTH] No valid session found in storage');
        return false;
      }
    } catch (e) {
      final failure = ExceptionHandler.parseToFailure(e, context: 'Check session');
      _authState = DataState.error(failure.message);
      debugPrint('❌ [AUTH] Session check failed: ${failure.message}');
      return false;
    }
  }

  // ==================== LOGOUT ====================
  Future<void> logout() async {
    debugPrint('🚪 [AUTH] Logging out...');
    await SecureStorageService.clearSession();

    // Reset to initial state
    _authState = DataState.initial();
    notifyListeners();

    debugPrint('✅ [AUTH] Logout successful');
    debugPrint('   └─ Session cleared from storage');
  }
}
