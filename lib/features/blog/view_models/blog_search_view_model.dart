import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';
import '../providers/blog_search_provider.dart';

class BlogSearchViewModel {
  final BuildContext context;
  BlogSearchViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  BlogSearchProvider get _provider => context.read<BlogSearchProvider>();
  BlogSearchProvider get _watchProvider => context.watch<BlogSearchProvider>();

  // ==================== GETTERS (From Provider) ====================
  List<BlogPost> get searchResults => _watchProvider.searchResults;
  bool get isSearching => _watchProvider.isSearching;
  String get searchQuery => _watchProvider.searchQuery;
  String? get errorMessage => _watchProvider.errorMessage;
  bool get hasResults => searchResults.isNotEmpty;

  // ==================== ACTIONS (Forward to Provider) ====================
  Future<void> search(String query) async {
    await _provider.search(query);
  }

  void clearSearch() {
    _provider.clearSearch();
  }

  // ==================== HELPER METHODS (UI Formatting) ====================
  String getResultCountText() {
    if (isSearching) return 'Searching...';
    if (!hasResults && searchQuery.isNotEmpty) {
      return 'No results found for "$searchQuery"';
    }
    if (hasResults) {
      return '${searchResults.length} results found';
    }
    return '';
  }

  bool shouldShowClearButton() {
    return searchQuery.isNotEmpty;
  }
}
