import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // ==================== SECURE STORAGE INSTANCE ====================
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true, resetOnError: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    webOptions: WebOptions(dbName: 'portfolio_admin_db', publicKey: 'portfolio_admin_key'),
  );

  // ==================== STORAGE KEYS ====================
  static const String _keyAdminId = 'admin_id';
  static const String _keyAdminEmail = 'admin_email';
  static const String _keyAdminUsername = 'admin_username';
  static const String _keyAdminDisplayName = 'admin_display_name';
  static const String _keyIsAuthenticated = 'is_authenticated';
  static const String _keyLoginTimestamp = 'login_timestamp';

  // ==================== SAVE SESSION ====================
  static Future<void> saveSession({
    required String adminId,
    required String email,
    required String username,
    required String displayName,
  }) async {
    try {
      // Write all session data in parallel for better performance
      await Future.wait([
        _storage.write(key: _keyAdminId, value: adminId),
        _storage.write(key: _keyAdminEmail, value: email),
        _storage.write(key: _keyAdminUsername, value: username),
        _storage.write(key: _keyAdminDisplayName, value: displayName),
        _storage.write(key: _keyIsAuthenticated, value: 'true'),
        _storage.write(key: _keyLoginTimestamp, value: DateTime.now().toIso8601String()),
      ]);
    } catch (e) {
      throw Exception('Failed to save session: $e');
    }
  }

  // ==================== GET SESSION ====================
  static Future<Map<String, String>?> getSession() async {
    try {
      // First check if authenticated flag is set
      final isAuthenticated = await _storage.read(key: _keyIsAuthenticated);

      if (isAuthenticated != 'true') {
        return null;
      }

      // Read all session data
      final adminId = await _storage.read(key: _keyAdminId);
      final email = await _storage.read(key: _keyAdminEmail);
      final username = await _storage.read(key: _keyAdminUsername);
      final displayName = await _storage.read(key: _keyAdminDisplayName);
      final loginTimestamp = await _storage.read(key: _keyLoginTimestamp);

      // Validate all required data exists
      if (adminId == null || email == null || username == null) {
        // Session data corrupted, clear everything
        await clearSession();
        return null;
      }

      return {
        'id': adminId,
        'email': email,
        'username': username,
        'display_name': displayName ?? '',
        'login_timestamp': loginTimestamp ?? '',
      };
    } catch (e) {
      // On any error, clear session to prevent issues
      await clearSession();
      return null;
    }
  }

  // ==================== CHECK SESSION ====================
  static Future<bool> hasValidSession() async {
    try {
      final session = await getSession();
      return session != null;
    } catch (e) {
      return false;
    }
  }

  // ==================== CLEAR SESSION ====================
  static Future<void> clearSession() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception('Failed to clear session: $e');
    }
  }

  // ==================== SESSION DURATION ====================
  static Future<int?> getSessionDuration() async {
    try {
      final timestamp = await _storage.read(key: _keyLoginTimestamp);

      if (timestamp == null) return null;

      final loginTime = DateTime.parse(timestamp);
      final duration = DateTime.now().difference(loginTime);

      return duration.inHours;
    } catch (e) {
      return null;
    }
  }

  // ==================== GET ADMIN ID ====================
  static Future<String?> getAdminId() async {
    try {
      return await _storage.read(key: _keyAdminId);
    } catch (e) {
      return null;
    }
  }
}
