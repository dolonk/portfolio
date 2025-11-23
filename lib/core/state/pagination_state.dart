import 'package:equatable/equatable.dart';

/// ============================================================
/// Generic PaginationState - Project-Wide Pagination Handler
/// ============================================================
///
/// Usage Example:
/// ```dart
/// final pagination = PaginationState<BlogPost>(itemsPerPage: 6);
/// pagination.setItems(allPosts);
/// final displayPosts = pagination.currentItems;
/// pagination.loadNextPage();
/// ```

class PaginationState<T> extends Equatable {
  final List<T> _allItems;
  final int itemsPerPage;
  final int _currentPage;

  const PaginationState._({required List<T> allItems, required this.itemsPerPage, required int currentPage})
    : _allItems = allItems,
      _currentPage = currentPage;

  /// Create initial pagination state
  factory PaginationState.initial({int itemsPerPage = 6}) {
    return PaginationState._(allItems: const [], itemsPerPage: itemsPerPage, currentPage: 1);
  }

  // ==================== GETTERS ====================

  /// Get all items (unfiltered)
  List<T> get allItems => List.unmodifiable(_allItems);

  /// Get current page number
  int get currentPage => _currentPage;

  /// Total number of items
  int get totalItems => _allItems.length;

  /// Total number of pages
  int get totalPages => (_allItems.length / itemsPerPage).ceil();

  /// Check if more items available
  bool get hasMore => (_currentPage * itemsPerPage) < _allItems.length;

  /// Check if can go to previous page
  bool get hasPrevious => _currentPage > 1;

  /// Get current page items
  List<T> get currentItems {
    if (_allItems.isEmpty) return [];

    final endIndex = _currentPage * itemsPerPage;
    if (endIndex >= _allItems.length) {
      return _allItems;
    }
    return _allItems.sublist(0, endIndex);
  }

  // ==================== ACTIONS ====================

  /// Set all items and reset pagination
  PaginationState<T> setItems(List<T> items) {
    return PaginationState._(allItems: items, itemsPerPage: itemsPerPage, currentPage: 1);
  }

  /// Load next page
  PaginationState<T> loadNextPage() {
    if (!hasMore) return this;
    return PaginationState._(allItems: _allItems, itemsPerPage: itemsPerPage, currentPage: _currentPage + 1);
  }

  /// Go to specific page
  PaginationState<T> goToPage(int page) {
    final validPage = page.clamp(1, totalPages);
    return PaginationState._(allItems: _allItems, itemsPerPage: itemsPerPage, currentPage: validPage);
  }

  /// Reset to first page
  PaginationState<T> reset() {
    return PaginationState._(allItems: _allItems, itemsPerPage: itemsPerPage, currentPage: 1);
  }

  /// Clear all items
  PaginationState<T> clear() {
    return PaginationState.initial(itemsPerPage: itemsPerPage);
  }

  @override
  List<Object?> get props => [_allItems, itemsPerPage, _currentPage];
}
