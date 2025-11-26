import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseErrorMapper {
  /// Map Supabase Auth error codes to user-friendly messages
  static final Map<String, String> _authErrorCodes = {
    // Signup errors
    'user_already_exists': 'User already exists with this email',
    'email_already_exists': 'Email already exists',
    'phone_already_exists': 'Phone number already exists',
    'identity_already_exists': 'Identity already exists',

    // Login errors
    'invalid_credentials': 'Invalid email or password',
    'invalid_phone': 'Invalid phone number',
    'invalid_email': 'Invalid email address',
    'invalid_password': 'Invalid password',
    'invalid_refresh_token': 'Invalid refresh token',
    'invalid_otp': 'Invalid OTP',

    // Session errors
    'session_expired': 'Session expired. Please sign in again',
    'session_not_found': 'Session not found',
    'session_retrieval_failed': 'Failed to retrieve session',

    // User errors
    'user_not_found': 'User not found',
    'user_disabled': 'This account has been disabled',
    'user_soft_deleted': 'This account has been deleted',

    // Verification errors
    'email_not_confirmed': 'Email not confirmed. Please check your inbox',
    'phone_not_confirmed': 'Phone number not confirmed',
    'confirmation_required': 'Confirmation required to complete this action',

    // OTP errors
    'otp_expired': 'OTP has expired. Please request a new one',
    'otp_mismatch': 'Invalid OTP code',
    'max_otp_retries': 'Too many OTP attempts. Please try again later',

    // Rate limiting
    'over_email_send_rate_limit': 'Too many emails sent. Please try again later',
    'over_sms_send_rate_limit': 'Too many SMS sent. Please try again later',
    'too_many_requests': 'Too many requests. Please slow down',

    // Provider errors
    'oauth_provider_not_supported': 'OAuth provider not supported',
    'oauth_provider_error': 'Error with OAuth provider',
    'oauth_account_not_linked': 'OAuth account not linked',

    // Security errors
    'weak_password': 'Password is too weak. Please use a stronger password',
    'password_mismatch': 'Passwords do not match',
    'password_too_short': 'Password is too short',
    'password_too_long': 'Password is too long',
    'password_no_uppercase': 'Password must contain uppercase letters',
    'password_no_lowercase': 'Password must contain lowercase letters',
    'password_no_digit': 'Password must contain numbers',

    // Network errors
    'network_failure': 'Network connection failed',
    'request_timeout': 'Request timed out. Please try again',

    // Server errors
    'internal_server_error': 'Server error. Please try again later',
    'service_unavailable': 'Service temporarily unavailable',
    'bad_gateway': 'Bad gateway error',
  };

  /// Map Postgrest error codes to user-friendly messages
  static final Map<String, String> _postgrestErrorCodes = {
    // PostgreSQL error codes
    '23502': 'Required field is missing', // not_null_violation
    '23503': 'Related record not found', // foreign_key_violation
    '23505': 'Record already exists', // unique_violation
    '23514': 'Check constraint violation', // check_violation
    '22P02': 'Invalid data format', // invalid_text_representation
    '22001': 'String data too long', // string_data_right_truncation
    '22003': 'Numeric value out of range', // numeric_value_out_of_range
    '22007': 'Invalid datetime format', // invalid_datetime_format
    '22008': 'Invalid time value', // datetime_field_overflow
    '22012': 'Division by zero', // division_by_zero
    '23000': 'Integrity constraint violation', // integrity_constraint_violation
    '25000': 'Invalid transaction state', // invalid_transaction_state
    '25001': 'Active SQL transaction', // active_sql_transaction
    '25006': 'Read-only SQL transaction', // read_only_sql_transaction
    '26000': 'Invalid SQL statement name', // invalid_sql_statement_name
    '28000': 'Invalid authorization specification', // invalid_authorization_specification
    '2F000': 'Transaction rollback', // transaction_rollback
    // Postgrest specific codes
    'PGRST000': 'Postgrest configuration error',
    'PGRST001': 'Route not found',
    'PGRST100': 'JSON object not found',
    'PGRST101': 'Column not found',
    'PGRST102': 'Relationship not found',
    'PGRST103': 'Schema not found',
    'PGRST104': 'Table not found',
    'PGRST105': 'Filtering error',
    'PGRST106': 'Embedding error',
    'PGRST107': 'Ordering error',
    'PGRST108': 'Pagination error',
    'PGRST109': 'Single row error',
    'PGRST110': 'Limiting error',
    'PGRST111': 'CSV error',
    'PGRST112': 'Insert error',
    'PGRST113': 'Update error',
    'PGRST114': 'Delete error',
    'PGRST115': 'Pre request error',
    'PGRST116': 'Resource not found',
    'PGRST201': 'Missing required parameter',
    'PGRST202': 'Invalid parameter value',
    'PGRST203': 'Parameter type mismatch',
    'PGRST204': 'Parameter format error',
    'PGRST205': 'Header error',
    'PGRST206': 'JWT error',
    'PGRST207': 'RLS policy violation',
    'PGRST208': 'Query timeout',
    'PGRST209': 'Response size too large',
    'PGRST210': 'Too many requests',
    'PGRST211': 'CORS error',
    'PGRST212': 'Service unavailable',
    'PGRST213': 'SSL required',
    'PGRST214': 'Invalid JWT',
    'PGRST215': 'JWT expired',
    'PGRST216': 'JWT missing',
    'PGRST217': 'JWT claim missing',
    'PGRST218': 'JWT claim invalid',
  };

  /// Map Storage error codes to user-friendly messages
  static final Map<String, String> _storageErrorCodes = {
    '400': 'Bad request',
    '401': 'Unauthorized access',
    '403': 'Forbidden - insufficient permissions',
    '404': 'File not found',
    '409': 'File already exists',
    '413': 'File too large',
    '422': 'Invalid file type',
    '500': 'Storage server error',
    '503': 'Storage service unavailable',
  };

  /// Get user-friendly message for AuthException
  static String getAuthErrorMessage(AuthException error) {
    final code = error.code?.toLowerCase();

    // Check exact code match first
    if (code != null && _authErrorCodes.containsKey(code)) {
      return _authErrorCodes[code]!;
    }

    // Check message content for partial matches
    final message = error.message.toLowerCase();

    if (message.contains('invalid credentials') || message.contains('invalid login')) {
      return 'Invalid email or password';
    } else if (message.contains('email not confirmed')) {
      return 'Please verify your email address before signing in';
    } else if (message.contains('user already registered') || message.contains('already exists')) {
      return 'An account with this email already exists';
    } else if (message.contains('weak password')) {
      return 'Password is too weak. Please use a stronger password';
    } else if (message.contains('too many requests')) {
      return 'Too many attempts. Please try again later';
    } else if (message.contains('network') || message.contains('connection')) {
      return 'Network connection failed. Please check your internet';
    }

    // Fallback to original message
    return error.message;
  }

  /// Get user-friendly message for PostgrestException
  static String getPostgrestErrorMessage(PostgrestException error) {
    final code = error.code;

    // Check exact code match first
    if (code != null && _postgrestErrorCodes.containsKey(code)) {
      return _postgrestErrorCodes[code]!;
    }

    // Check message content for partial matches
    final message = error.message.toLowerCase();

    if (code == '42501' || message.contains('rls') || message.contains('policy')) {
      return 'Access denied. You don\'t have permission to perform this action';
    } else if (message.contains('duplicate') || message.contains('unique')) {
      return 'This record already exists';
    } else if (message.contains('foreign key')) {
      return 'Related record not found';
    } else if (message.contains('not null')) {
      return 'Required field is missing';
    } else if (message.contains('invalid input') || message.contains('format')) {
      return 'Invalid data format provided';
    } else if (message.contains('not found')) {
      return 'Requested data not found';
    } else if (message.contains('connection') || message.contains('connect')) {
      return 'Database connection failed. Please try again';
    } else if (message.contains('timeout')) {
      return 'Request timeout. Please try again';
    }

    // Fallback to original message
    return error.message;
  }

  static String getStorageErrorMessage(StorageException error) {
    if (error.statusCode != null && _storageErrorCodes.containsKey(error.statusCode)) {
      return _storageErrorCodes[error.statusCode!]!;
    }

    if (error.statusCode != null) {
      final int? statusCodeInt = int.tryParse(error.statusCode!);
      if (statusCodeInt != null) {
        if (statusCodeInt >= 400 && statusCodeInt < 500) {
          return 'Client error: ${error.message}';
        } else if (statusCodeInt >= 500) {
          return 'Server error: Please try again later';
        }
      }
    }
    return error.message;
  }

  /// Get error category for analytics/monitoring
  static String getErrorCategory(dynamic error) {
    if (error is AuthException) return 'authentication';
    if (error is PostgrestException) return 'database';
    if (error is StorageException) return 'storage';
    if (error is SocketException) return 'realtime';
    if (error.toString().toLowerCase().contains('realtime')) return 'realtime';
    return 'unknown';
  }

  /// Check if error is recoverable (user can retry)
  static bool isRecoverableError(dynamic error) {
    if (error is AuthException) {
      final code = error.code?.toLowerCase();
      return !{'user_disabled', 'user_soft_deleted', 'identity_already_exists'}.contains(code);
    }

    if (error is PostgrestException) {
      final code = error.code;
      return !{
        '23502', // not_null_violation
        '23503', // foreign_key_violation
        '23505', // unique_violation
        '22P02', // invalid_text_representation
      }.contains(code);
    }

    return true;
  }

  /// Check if error is network related
  static bool isNetworkError(dynamic error) {
    final message = error.toString().toLowerCase();
    return message.contains('network') ||
        message.contains('connection') ||
        message.contains('socket') ||
        message.contains('timeout') ||
        message.contains('offline');
  }
}
