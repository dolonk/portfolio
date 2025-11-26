import 'package:flutter/foundation.dart';
import '../../../../core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:portfolio/core/config/supabase_config.dart';

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

      // Success - Save admin data
      _isAuthenticated = true;
      _currentAdmin = response;
      _errorMessage = null;

      _isLoading = false;
      notifyListeners();

      debugPrint('✅ Admin logged in: ${response['display_name']}');
      return true;
    } catch (e) {
      final failure = ExceptionHandler.parseToFailure(e, context: 'Admin login');
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
    _isAuthenticated = false;
    _currentAdmin = null;
    _errorMessage = null;

    notifyListeners();
    debugPrint('👋 Admin logged out');
  }

  // ==================== UTILITY ====================
  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Check if session is valid
  bool get hasValidSession => _isAuthenticated && _currentAdmin != null;
}
