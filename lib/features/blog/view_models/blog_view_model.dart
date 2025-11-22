import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/blog_provider.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';

class BlogViewModel {
  final BuildContext context;

  BlogViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  /// Get BlogProvider (read only - no rebuild)
  BlogProvider get _provider => context.read<BlogProvider>();

  /// Watch BlogProvider (rebuilds on change)
  BlogProvider get _watchProvider => context.watch<BlogProvider>();

  // ==================== GETTERS  ====================
  /// All posts
  List<BlogPost> get allPosts => _watchProvider.allPosts;

  /// Featured posts
  List<BlogPost> get featuredPosts => _watchProvider.featuredPosts;

  /// Display posts (paginated)
  List<BlogPost> get displayPosts => _watchProvider.displayPosts;

  /// Selected post
  BlogPost? get selectedPost => _watchProvider.selectedPost;

  /// All tags
  List<String> get allTags => _watchProvider.allTags;

  /// Selected tag
  String? get selectedTag => _watchProvider.selectedTag;

  /// Search query
  String get searchQuery => _watchProvider.searchQuery;

  // ==================== STATUS GETTERS ====================

  /// Is loading
  bool get isLoading => _watchProvider.isLoading;

  /// Has error
  bool get hasError => _watchProvider.hasError;

  /// Is empty
  bool get isEmpty => _watchProvider.isEmpty;

  /// Error message
  String? get errorMessage => _watchProvider.errorMessage;

  /// Has more posts
  bool get hasMore => _watchProvider.hasMore;

  /// Is featured loading
  bool get isFeaturedLoading => _watchProvider.isFeaturedLoading;

  // ==================== ACTIONS (UI থেকে call হবে) ====================

  /// Fetch all posts
  Future<void> fetchAllPosts() async {
    await _provider.fetchAllPosts();
  }

  /// Fetch featured posts
  Future<void> fetchFeaturedPosts() async {
    await _provider.fetchFeaturedPosts();
  }

  /// Fetch post by ID
  Future<void> fetchPostById(String id) async {
    await _provider.fetchPostById(id);
  }

  /// Fetch all tags
  Future<void> fetchAllTags() async {
    await _provider.fetchAllTags();
  }

  /// Filter by tag
  Future<void> filterByTag(String? tag) async {
    await _provider.filterByTag(tag);
  }

  /// Search posts
  Future<void> searchPosts(String query) async {
    await _provider.searchPosts(query);
  }

  /// Load more posts (pagination)
  void loadMore() {
    _provider.loadMore();
  }

  /// Clear filters
  void clearFilters() {
    _provider.clearFilters();
  }

  /// Refresh all data
  Future<void> refresh() async {
    await _provider.refresh();
  }

  /// Clear selected post
  void clearSelectedPost() {
    _provider.clearSelectedPost();
  }

  /// Clear error
  void clearError() {
    _provider.clearError();
  }

  // ==================== HELPER METHODS ====================
  /// Get post count text
  String getPostCountText() {
    final count = displayPosts.length;
    final total = allPosts.length;
    return 'Showing $count of $total posts';
  }

  /// Check if tag is selected
  bool isTagSelected(String tag) {
    return selectedTag == tag;
  }

  /// Get filtered post count by tag
  int getPostCountByTag(String tag) {
    return allPosts.where((post) => post.tags.contains(tag)).length;
  }
}
