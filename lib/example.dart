import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Base exception class
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => '$runtimeType: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Server/API related errors
class _ServerException extends AppException {
  _ServerException(super.message, {super.code, super.originalError});
}

/// Database/Supabase errors
class _DatabaseException extends AppException {
  _DatabaseException(super.message, {super.code, super.originalError});
}

/// Authentication errors
class _AuthenticationException extends AppException {
  _AuthenticationException(super.message, {super.code, super.originalError});
}

/// Network connectivity errors
class _NetworkException extends AppException {
  _NetworkException(super.message, {super.code, super.originalError});
}

/// Cache/Local storage related errors
class _CacheException extends AppException {
  _CacheException(super.message, {super.code, super.originalError});
}

/// Validation errors
class _ValidationException extends AppException {
  _ValidationException(super.message, {super.code, super.originalError});
}

/// Permission/Authorization errors
class _PermissionException extends AppException {
  _PermissionException(super.message, {super.code, super.originalError});
}

/// Data not found errors
class _NotFoundException extends AppException {
  _NotFoundException(super.message, {super.code, super.originalError});
}

// ==================== EXCEPTION HANDLER ====================

class ExceptionHandler {
  /// Parse any exception and convert to user-friendly message with proper exception type
  static AppException parse(Object error, {String context = 'Operation'}) {
    final errorString = error.toString().toLowerCase();

    debugPrint("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    debugPrint("🧨 Exception Context: $context");
    debugPrint("🧨 Error Type: ${error.runtimeType}");
    debugPrint("🧨 Error Details: $error");
    debugPrint("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

    // ==================== SUPABASE AUTH EXCEPTION ====================
    if (error is AuthException) {
      return _handleAuthException(error, context);
    }

    // ==================== SUPABASE POSTGREST EXCEPTION ====================
    if (error is PostgrestException) {
      return _handlePostgrestException(error, context);
    }

    // ==================== CUSTOM APP EXCEPTIONS ====================
    if (error is AppException) {
      return error; // Already handled, return as-is
    }

    // ==================== CACHE/STORAGE ERRORS ====================
    if (errorString.contains('cache') ||
        errorString.contains('storage') ||
        errorString.contains('hive') ||
        errorString.contains('shared preferences') ||
        errorString.contains('local storage')) {
      return _CacheException(
        'Local storage error. Please clear app data and try again.',
        code: 'CACHE_ERROR',
        originalError: error,
      );
    }

    // ==================== FILE/STORAGE ERRORS ====================
    if (errorString.contains('filenotfound') ||
        errorString.contains('permission denied') ||
        errorString.contains('storage full')) {
      return _CacheException(
        'File storage error. Please check app permissions and storage space.',
        code: 'STORAGE_ERROR',
        originalError: error,
      );
    }

    // ==================== NETWORK ERRORS ====================
    if (errorString.contains('socketexception') ||
        errorString.contains('failed host lookup') ||
        errorString.contains('network')) {
      return _NetworkException(
        'No internet connection. Please check your network and try again.',
        code: 'NETWORK_ERROR',
        originalError: error,
      );
    }

    // ==================== TIMEOUT ERRORS ====================
    if (errorString.contains('timeout')) {
      return _NetworkException(
        'Request timeout. Please check your connection and try again.',
        code: 'TIMEOUT',
        originalError: error,
      );
    }

    // ==================== FORMAT ERRORS ====================
    if (errorString.contains('formatexception') ||
        errorString.contains('invalid format') ||
        errorString.contains('type')) {
      return _ValidationException(
        'Invalid data format received. Please try again.',
        code: 'FORMAT_ERROR',
        originalError: error,
      );
    }

    // ==================== UNKNOWN ERRORS ====================
    return _ServerException(
      'An unexpected error occurred during $context. Please try again later.',
      code: 'UNKNOWN_ERROR',
      originalError: error,
    );
  }

  // ==================== AUTH EXCEPTION HANDLER ====================
  static _AuthenticationException _handleAuthException(AuthException error, String context) {
    final message = error.message.toLowerCase();
    String userMessage;
    String? code;

    if (message.contains('invalid login credentials')) {
      userMessage = "Incorrect email or password. Please try again.";
      code = 'INVALID_CREDENTIALS';
    } else if (message.contains('email not confirmed')) {
      userMessage = "Your email is not confirmed yet. Please verify your email.";
      code = 'EMAIL_NOT_CONFIRMED';
    } else if (message.contains('user already registered')) {
      userMessage = "This email is already registered.";
      code = 'USER_EXISTS';
    } else if (message.contains('invalid email')) {
      userMessage = "The email address is invalid.";
      code = 'INVALID_EMAIL';
    } else if (message.contains('weak password')) {
      userMessage = "Password is too weak. Please use a stronger password.";
      code = 'WEAK_PASSWORD';
    } else if (message.contains('user not found')) {
      userMessage = "User account not found.";
      code = 'USER_NOT_FOUND';
    } else {
      userMessage = error.message;
      code = 'AUTH_ERROR';
    }

    return _AuthenticationException(userMessage, code: code, originalError: error);
  }

  // ==================== POSTGREST EXCEPTION HANDLER ====================
  static AppException _handlePostgrestException(PostgrestException error, String context) {
    final code = error.code;
    final message = error.message.toLowerCase();
    String userMessage;
    String? errorCode;

    // RLS Policy Violations
    if (code == '42501' || message.contains('rls') || message.contains('policy')) {
      userMessage = "Access denied. You don't have permission to perform this action.";
      errorCode = 'RLS_POLICY_VIOLATION';
      return _PermissionException(userMessage, code: errorCode, originalError: error);
    }

    // Duplicate Entry
    if (code == '23505' || message.contains('duplicate') || message.contains('unique constraint')) {
      userMessage = "This entry already exists. Please use a different value.";
      errorCode = 'DUPLICATE_ENTRY';
      return _DatabaseException(userMessage, code: errorCode, originalError: error);
    }

    // Foreign Key Violation
    if (code == '23503' || message.contains('foreign key')) {
      userMessage = "Cannot perform this action due to related data constraints.";
      errorCode = 'FOREIGN_KEY_VIOLATION';
      return _DatabaseException(userMessage, code: errorCode, originalError: error);
    }

    // Not Null Violation
    if (code == '23502' || message.contains('not null')) {
      userMessage = "Required field is missing. Please provide all required information.";
      errorCode = 'NOT_NULL_VIOLATION';
      return _ValidationException(userMessage, code: errorCode, originalError: error);
    }

    // Data Type Error
    if (code == '22P02' || message.contains('invalid input syntax')) {
      userMessage = "Invalid data type provided. Please check your input.";
      errorCode = 'INVALID_DATA_TYPE';
      return _ValidationException(userMessage, code: errorCode, originalError: error);
    }

    // Out of Range
    if (code == '22003' || message.contains('out of range')) {
      userMessage = "Data value is out of acceptable range.";
      errorCode = 'OUT_OF_RANGE';
      return _ValidationException(userMessage, code: errorCode, originalError: error);
    }

    // Not Found
    if (code == 'PGRST116' || message.contains('not found')) {
      userMessage = "Requested data not found.";
      errorCode = 'NOT_FOUND';
      return _NotFoundException(userMessage, code: errorCode, originalError: error);
    }

    // Connection Error
    if (message.contains('connection') || message.contains('could not connect')) {
      userMessage = "Database connection failed. Please try again.";
      errorCode = 'CONNECTION_ERROR';
      return _NetworkException(userMessage, code: errorCode, originalError: error);
    }

    // Generic Database Error
    return _DatabaseException(error.message, code: code ?? 'DB_ERROR', originalError: error);
  }

  /// Quick method to get user-friendly message only
  static String getMessage(Object error, {String context = 'Operation'}) {
    return parse(error, context: context).message;
  }

  /// Check if error is network related
  static bool isNetworkError(Object error) {
    return error is _NetworkException ||
        error.toString().toLowerCase().contains('network') ||
        error.toString().toLowerCase().contains('socket');
  }

  /// Check if error is permission related
  static bool isPermissionError(Object error) {
    return error is _PermissionException ||
        error.toString().toLowerCase().contains('rls') ||
        error.toString().toLowerCase().contains('permission');
  }

  /// Check if error is cache/storage related
  static bool isCacheError(Object error) {
    return error is _CacheException ||
        error.toString().toLowerCase().contains('cache') ||
        error.toString().toLowerCase().contains('storage');
  }

  /// Check if error is validation related
  static bool isValidationError(Object error) {
    return error is _ValidationException ||
        error.toString().toLowerCase().contains('validation') ||
        error.toString().toLowerCase().contains('invalid');
  }
}
