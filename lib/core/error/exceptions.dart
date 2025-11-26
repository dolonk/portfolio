import 'failures.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => '$runtimeType: $message${code != null ? ' (Code: $code)' : ''}';
}

// ==================== PUBLIC EXCEPTIONS ====================
class ServerException extends AppException {
  ServerException(super.message, {super.code, super.originalError});
}

class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.originalError});
}

class NotFoundException extends AppException {
  NotFoundException(super.message, {super.code, super.originalError});
}

// ==================== PRIVATE EXCEPTIONS ====================
class _DatabaseException extends AppException {
  _DatabaseException(super.message, {super.code, super.originalError});
}

class _AuthenticationException extends AppException {
  _AuthenticationException(super.message, {super.code, super.originalError});
}

class _NetworkException extends AppException {
  _NetworkException(super.message, {super.code, super.originalError});
}

class _CacheException extends AppException {
  _CacheException(super.message, {super.code, super.originalError});
}

class _PermissionException extends AppException {
  _PermissionException(super.message, {super.code, super.originalError});
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
      return error;
    }

    // ==================== CACHE/STORAGE ERRORS ====================
    if (_isCacheError(errorString)) {
      return _CacheException(
        'Local storage error. Please clear app data and try again.',
        code: 'CACHE_ERROR',
        originalError: error,
      );
    }

    // ==================== NETWORK ERRORS ====================
    if (_isNetworkError(errorString)) {
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
    if (_isFormatError(errorString)) {
      return ValidationException(
        'Invalid data format received. Please try again.',
        code: 'FORMAT_ERROR',
        originalError: error,
      );
    }

    // ==================== UNKNOWN ERRORS ====================
    return ServerException(
      'An unexpected error occurred during $context. Please try again later.',
      code: 'UNKNOWN_ERROR',
      originalError: error,
    );
  }

  // ==================== PARSE TO FAILURE ====================
  static Failure parseToFailure(Object error, {String context = 'Operation'}) {
    final exception = parse(error, context: context);

    switch (exception.runtimeType) {
      case ServerException _:
        return ServerFailure(message: exception.message, code: exception.code);
      case _DatabaseException _:
        return DatabaseFailure(message: exception.message, code: exception.code);
      case _NetworkException _:
        return NetworkFailure(message: exception.message, code: exception.code);
      case _AuthenticationException _:
        return AuthFailure(message: exception.message, code: exception.code);
      case _PermissionException _:
        return PermissionFailure(message: exception.message, code: exception.code);
      case NotFoundException _:
        return NotFoundFailure(message: exception.message, code: exception.code);
      case ValidationException _:
        return ValidationFailure(message: exception.message, code: exception.code);
      case _CacheException _:
        return CacheFailure(message: exception.message, code: exception.code);
      default:
        return ServerFailure(message: exception.message, code: exception.code);
    }
  }

  // ==================== PRIVATE HELPER METHODS ====================
  static bool _isCacheError(String errorString) {
    return errorString.contains('cache') ||
        errorString.contains('storage') ||
        errorString.contains('hive') ||
        errorString.contains('shared preferences') ||
        errorString.contains('local storage') ||
        errorString.contains('filenotfound') ||
        errorString.contains('permission denied') ||
        errorString.contains('storage full');
  }

  static bool _isNetworkError(String errorString) {
    return errorString.contains('socketexception') ||
        errorString.contains('failed host lookup') ||
        errorString.contains('network') ||
        errorString.contains('connection');
  }

  static bool _isFormatError(String errorString) {
    return errorString.contains('formatexception') ||
        errorString.contains('invalid format') ||
        errorString.contains('type') ||
        errorString.contains('json');
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
      userMessage = "Authentication failed. Please try again.";
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
      return ValidationException(userMessage, code: errorCode, originalError: error);
    }

    // Data Type Error
    if (code == '22P02' || message.contains('invalid input syntax')) {
      userMessage = "Invalid data type provided. Please check your input.";
      errorCode = 'INVALID_DATA_TYPE';
      return ValidationException(userMessage, code: errorCode, originalError: error);
    }

    // Out of Range
    if (code == '22003' || message.contains('out of range')) {
      userMessage = "Data value is out of acceptable range.";
      errorCode = 'OUT_OF_RANGE';
      return ValidationException(userMessage, code: errorCode, originalError: error);
    }

    // Not Found
    if (code == 'PGRST116' || message.contains('not found')) {
      userMessage = "Requested data not found.";
      errorCode = 'NOT_FOUND';
      return NotFoundException(userMessage, code: errorCode, originalError: error);
    }

    // Connection Error
    if (message.contains('connection') || message.contains('could not connect')) {
      userMessage = "Database connection failed. Please try again.";
      errorCode = 'CONNECTION_ERROR';
      return _NetworkException(userMessage, code: errorCode, originalError: error);
    }

    // Generic Database Error
    return _DatabaseException(
      "Database operation failed. Please try again.",
      code: code ?? 'DB_ERROR',
      originalError: error,
    );
  }

  // ==================== PUBLIC HELPER METHODS ====================
  static String getMessage(Object error, {String context = 'Operation'}) {
    return parse(error, context: context).message;
  }

  static bool isNetworkError(Object error) {
    final parsed = error is AppException ? error : parse(error);
    return parsed is _NetworkException;
  }

  static bool isPermissionError(Object error) {
    final parsed = error is AppException ? error : parse(error);
    return parsed is _PermissionException;
  }

  static bool isCacheError(Object error) {
    final parsed = error is AppException ? error : parse(error);
    return parsed is _CacheException;
  }

  static bool isValidationError(Object error) {
    final parsed = error is AppException ? error : parse(error);
    return parsed is ValidationException;
  }

  static bool isAuthError(Object error) {
    final parsed = error is AppException ? error : parse(error);
    return parsed is _AuthenticationException;
  }
}
