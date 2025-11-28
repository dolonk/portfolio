import 'package:flutter/foundation.dart';
import '../../../../core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio/core/config/supabase_config.dart';

import '../../../../core/services/secure_storage_service.dart';

class AdminAuthProvider with ChangeNotifier {
  final SupabaseClient? supabase;
  AdminAuthProvider({this.supabase});

  // ==================== STATE ====================
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _currentAdmin;

  // ==================== GETTERS ====================
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get currentAdmin => _currentAdmin;
  String? get adminName => _currentAdmin?['displayName'];
  String? get adminId => _currentAdmin?['id'];

  // ==================== AUTO-LOGIN ON APP START ====================
  Future<void> checkAndRestoreSession() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Try to get saved session
      final session = await SecureStorageService.getSession();

      if (session == null) {
        _isLoading = false;
        notifyListeners();
        debugPrint('⚠️ No saved session found');
        return;
      }
      debugPrint('🔍 Checking saved session for: ${session['username']}');

      // Verify admin still exists and is active in Supabase
      final response = await supabase!
          .from(SupabaseConfig.adminsTable)
          .select()
          .eq('id', session['id']!)
          .eq('is_active', true)
          .maybeSingle();

      if (response == null) {
        await SecureStorageService.clearSession();
        debugPrint('❌ Admin not found or inactive - session cleared');
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Session valid - restore authentication state
      _isAuthenticated = true;
      _currentAdmin = response;
      _errorMessage = null;

      _isLoading = false;
      notifyListeners();

      final duration = await SecureStorageService.getSessionDuration();
      debugPrint('✅ Session restored - Admin: ${response['display_name']} (${duration}h ago)');
    } catch (e) {
      debugPrint('❌ Session restore failed: $e');
      await SecureStorageService.clearSession();
      _errorMessage = 'Session restore failed';
      _isLoading = false;
      notifyListeners();
    }
  }

  // ==================== LOGIN ====================
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Query Supabase for admin with username
      final response = await supabase!
          .from(SupabaseConfig.adminsTable)
          .select()
          .eq('username', username.trim().toLowerCase())
          .eq('is_active', true)
          .maybeSingle();

      // Check if admin found
      if (response == null) {
        _errorMessage = 'Invalid username or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Check password (compare hashed)
      if (response['password'] != password) {
        _errorMessage = 'Invalid username or password';
        _isLoading = false;
        notifyListeners();
        debugPrint('❌ Login failed: Password mismatch');
        return false;
      }

      // Success - Save session to secure storage
      await SecureStorageService.saveSession(
        adminId: response['id'],
        email: response['email'],
        username: response['username'],
        displayName: response['display_name'],
      );

      // Update authentication state
      _isAuthenticated = true;
      _currentAdmin = response;
      _errorMessage = null;

      _isLoading = false;
      notifyListeners();

      debugPrint('✅ Admin logged in & session saved: ${response['display_name']}');
      return true;
    } catch (e) {
      final failure = ExceptionHandler.parseToFailure(e, context: 'Admin login');
      _errorMessage = failure.message;
      _isLoading = false;
      notifyListeners();

      debugPrint('''❌ Login Error:
    Type: ${failure.runtimeType}
    Message: ${failure.message}
    Code: ${failure.code}''');

      return false;
    }
  }

  // ==================== LOGOUT ====================
  Future<void> logout() async {
    await SecureStorageService.clearSession();

    // Clear provider state
    _isAuthenticated = false;
    _currentAdmin = null;
    _errorMessage = null;

    notifyListeners();
    debugPrint('👋 Admin logged out & session cleared');
  }
}
