import 'package:equatable/equatable.dart';
import '../../utility/enum/enum.dart';

/// ============================================================
/// Generic DataState - Project-Wide Reusable State Wrapper
/// ============================================================
///
/// Usage Example:
/// ```dart
/// final DataState<List<BlogPost>> postsState = DataState.initial();
/// postsState = DataState.loading();
/// postsState = DataState.success(posts);
/// postsState = DataState.error('Failed to load');
/// postsState = DataState.empty();
/// ```
///
/// In Widget:
/// ```dart
/// if (state.isLoading) return LoadingWidget();
/// if (state.hasError) return ErrorWidget(state.errorMessage);
/// if (state.isEmpty) return EmptyWidget();
/// return SuccessWidget(state.data);
/// ```

class DataState<T> extends Equatable {
  final GettingStatus status;
  final T? data;
  final String? errorMessage;
  final DateTime? lastUpdated;

  const DataState._({required this.status, this.data, this.errorMessage, this.lastUpdated});

  // ==================== FACTORY CONSTRUCTORS ====================

  /// Initial state - no data loaded yet
  factory DataState.initial() => const DataState._(status: GettingStatus.initial);

  /// Loading state - data being fetched
  factory DataState.loading({T? previousData}) => DataState._(
    status: GettingStatus.loading,
    data: previousData, // Keep previous data while loading (optional)
  );

  /// Success state - data loaded successfully
  factory DataState.success(T data) =>
      DataState._(status: GettingStatus.success, data: data, lastUpdated: DateTime.now());

  /// Error state - something went wrong
  factory DataState.error(String message, {T? previousData}) => DataState._(
    status: GettingStatus.error,
    errorMessage: message,
    data: previousData, // Keep previous data on error (optional)
  );

  /// Empty state - no data available
  factory DataState.empty() => const DataState._(status: GettingStatus.empty);

  // ==================== STATUS GETTERS (Boolean) ====================

  bool get isInitial => status == GettingStatus.initial;
  bool get isLoading => status == GettingStatus.loading;
  bool get isSuccess => status == GettingStatus.success;
  bool get hasError => status == GettingStatus.error;
  bool get isEmpty => status == GettingStatus.empty;

  /// Check if data is available (regardless of status)
  bool get hasData => data != null;

  /// Check if currently fetching (loading or initial)
  bool get isFetching => isInitial || isLoading;

  // ==================== UTILITY METHODS ====================

  /// Get data or default value
  T dataOrElse(T defaultValue) => data ?? defaultValue;

  /// Transform data if success
  DataState<R> map<R>(R Function(T data) mapper) {
    if (isSuccess && data != null) {
      return DataState.success(mapper(data as T));
    }
    return DataState._(status: status, errorMessage: errorMessage, lastUpdated: lastUpdated);
  }

  /// Copy with new values
  DataState<T> copyWith({GettingStatus? status, T? data, String? errorMessage, DateTime? lastUpdated}) {
    return DataState._(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  // ==================== WHEN METHOD (Pattern Matching) ====================

  /// Pattern matching for all states - cleaner widget building
  ///
  /// Example:
  /// ```dart
  /// state.when(
  ///   initial: () => SizedBox.shrink(),
  ///   loading: () => CircularProgressIndicator(),
  ///   success: (data) => ListView(children: data),
  ///   error: (msg) => Text(msg),
  ///   empty: () => Text('No data'),
  /// )
  /// ```
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) error,
    required R Function() empty,
  }) {
    switch (status) {
      case GettingStatus.initial:
        return initial();
      case GettingStatus.loading:
        return loading();
      case GettingStatus.success:
        return success(data as T);
      case GettingStatus.error:
        return error(errorMessage ?? 'Unknown error');
      case GettingStatus.empty:
        return empty();
    }
  }

  /// Simplified when - only handle success and loading
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String message)? error,
    R Function()? empty,
    required R Function() orElse,
  }) {
    switch (status) {
      case GettingStatus.initial:
        return initial?.call() ?? orElse();
      case GettingStatus.loading:
        return loading?.call() ?? orElse();
      case GettingStatus.success:
        return success?.call(data as T) ?? orElse();
      case GettingStatus.error:
        return error?.call(errorMessage ?? 'Unknown error') ?? orElse();
      case GettingStatus.empty:
        return empty?.call() ?? orElse();
    }
  }

  @override
  List<Object?> get props => [status, data, errorMessage, lastUpdated];

  @override
  String toString() => 'DataState(status: $status, hasData: $hasData, error: $errorMessage)';
}
