import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AdminAuthProvider with ChangeNotifier {
  final FirebaseFirestore? firestore;

  AdminAuthProvider({this.firestore});

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

  /// Login with username and password
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Check if Firebase is available
      if (firestore == null) {
        _errorMessage = 'Firebase not initialized. Please check configuration.';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Hash password (SHA256)
      final hashedPassword = _hashPassword(password);

      // Query Firestore for admin with username
      final querySnapshot = await firestore!
          .collection('admins')
          .where('username', isEqualTo: username.trim().toLowerCase())
          .where('isActive', isEqualTo: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        _errorMessage = 'Invalid username or password';
        _isLoading = false;
        notifyListeners();
        debugPrint('❌ Login failed: Username not found');
        return false;
      }

      final adminDoc = querySnapshot.docs.first;
      final adminData = adminDoc.data();

      // Check password (compare hashed)
      if (adminData['password'] != hashedPassword) {
        _errorMessage = 'Invalid username or password';
        _isLoading = false;
        notifyListeners();
        debugPrint('❌ Login failed: Password mismatch');
        return false;
      }

      // Success - Save admin data
      _isAuthenticated = true;
      _currentAdmin = {'id': adminDoc.id, ...adminData};
      _errorMessage = null;

      _isLoading = false;
      notifyListeners();

      debugPrint('✅ Admin logged in: ${adminData['displayName']}');
      return true;
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      debugPrint('❌ Login error: $e');
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

  // ==================== PASSWORD HASHING ====================

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
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
