import 'failures.dart';
import 'supabase_error_mapper.dart';
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
class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.originalError});
}

class NotFoundException extends AppException {
  NotFoundException(super.message, {super.code, super.originalError});
}

// ==================== PRIVATE EXCEPTIONS ====================
class _ServerException extends AppException {
  _ServerException(super.message, {super.code, super.originalError});
}

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

    // ==================== SUPABASE STORAGE EXCEPTION ====================
    if (error is StorageException) {
      return _handleStorageException(error, context);
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
    return _ServerException(
      'An unexpected error occurred during $context. Please try again later.',
      code: 'UNKNOWN_ERROR',
      originalError: error,
    );
  }

  // ==================== PARSE TO FAILURE ====================
  static Failure parseToFailure(Object error, {String context = 'Operation'}) {
    final exception = parse(error, context: context);

    switch (exception.runtimeType) {
      case _ServerException _:
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

  // ==================== SUPABASE EXCEPTION HANDLERS ====================

  /// Handle AuthException using SupabaseErrorMapper
  static _AuthenticationException _handleAuthException(AuthException error, String context) {
    final userMessage = SupabaseErrorMapper.getAuthErrorMessage(error);
    final code = error.code ?? 'AUTH_ERROR';

    return _AuthenticationException(userMessage, code: code, originalError: error);
  }

  /// Handle PostgrestException using SupabaseErrorMapper
  static AppException _handlePostgrestException(PostgrestException error, String context) {
    final userMessage = SupabaseErrorMapper.getPostgrestErrorMessage(error);
    final code = error.code ?? 'DB_ERROR';

    // Determine exception type based on error code using mapper logic
    if (code == '42501' ||
        error.message.toLowerCase().contains('rls') ||
        error.message.toLowerCase().contains('policy')) {
      return _PermissionException(userMessage, code: code, originalError: error);
    } else if (code == '23505' ||
        error.message.toLowerCase().contains('duplicate') ||
        error.message.toLowerCase().contains('unique')) {
      return _DatabaseException(userMessage, code: code, originalError: error);
    } else if (code == '23503' || error.message.toLowerCase().contains('foreign key')) {
      return _DatabaseException(userMessage, code: code, originalError: error);
    } else if (code == '23502' || error.message.toLowerCase().contains('not null')) {
      return ValidationException(userMessage, code: code, originalError: error);
    } else if (code == '22P02' || error.message.toLowerCase().contains('invalid input')) {
      return ValidationException(userMessage, code: code, originalError: error);
    } else if (code == 'PGRST116' || error.message.toLowerCase().contains('not found')) {
      return NotFoundException(userMessage, code: code, originalError: error);
    } else if (SupabaseErrorMapper.isNetworkError(error)) {
      return _NetworkException(userMessage, code: code, originalError: error);
    }

    return _DatabaseException(userMessage, code: code, originalError: error);
  }

  /// Handle StorageException using SupabaseErrorMapper
  static AppException _handleStorageException(StorageException error, String context) {
    final userMessage = SupabaseErrorMapper.getStorageErrorMessage(error);
    final code = error.statusCode?.toString() ?? 'STORAGE_ERROR';

    final int? statusCodeInt = int.tryParse(error.statusCode!);
    if (statusCodeInt == 403 || statusCodeInt == 401) {
      return _PermissionException(userMessage, code: code, originalError: error);
    } else if (statusCodeInt == 404) {
      return NotFoundException(userMessage, code: code, originalError: error);
    } else if (statusCodeInt != null && statusCodeInt >= 500) {
      return _ServerException(userMessage, code: code, originalError: error);
    }

    return _ServerException(userMessage, code: code, originalError: error);
  }

  // ==================== PUBLIC HELPER METHODS ====================
  static String getMessage(Object error, {String context = 'Operation'}) {
    return parse(error, context: context).message;
  }

  static String? getErrorCode(Object error, {String context = 'Operation'}) {
    return parse(error, context: context).code;
  }

  static bool isNetworkError(Object error) {
    final parsed = error is AppException ? error : parse(error);
    return parsed is _NetworkException || SupabaseErrorMapper.isNetworkError(error);
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

  /// Check if error is recoverable using SupabaseErrorMapper
  static bool isRecoverableError(Object error) {
    if (error is AuthException || error is PostgrestException) {
      return SupabaseErrorMapper.isRecoverableError(error);
    }
    return true;
  }
}
