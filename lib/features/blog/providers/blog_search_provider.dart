import 'package:flutter/foundation.dart';
import '../../../data_layer/domain/entities/blog/blog_post.dart';
import '../../../data_layer/domain/repositories/blog/blog_repository.dart';

/// Blog Search Provider
/// Separate provider for search to avoid rebuilding main list
class BlogSearchProvider with ChangeNotifier {
  final BlogRepository repository;

  BlogSearchProvider({required this.repository});

  // State
  List<BlogPost> _searchResults = [];
  bool _isSearching = false;
  String _searchQuery = '';
  String? _errorMessage;

  // Getters
  List<BlogPost> get searchResults => _searchResults;
  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;
  bool get hasResults => _searchResults.isNotEmpty;
  bool get hasError => _errorMessage != null;

  /// Perform search
  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      clearSearch();
      return;
    }

    _searchQuery = query;
    _isSearching = true;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.searchPosts(query);

    result.fold(
      (failure) {
        _isSearching = false;
        _errorMessage = failure.message;
        _searchResults = [];
        notifyListeners();
      },
      (posts) {
        _isSearching = false;
        _searchResults = posts;
        notifyListeners();
      },
    );
  }

  /// Clear search
  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    _isSearching = false;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _searchResults.clear();
    super.dispose();
  }
}
