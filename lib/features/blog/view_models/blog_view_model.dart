import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/state/state.dart';
import '../providers/blog_provider.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';

class BlogViewModel {
  final BuildContext context;

  BlogViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  /// Read-only access (for actions)
  BlogProvider get _provider => context.read<BlogProvider>();

  /// Watch access (for reactive UI)
  BlogProvider get _watch => context.watch<BlogProvider>();

  // ==================== STATE GETTERS ====================
  /// Main posts state - use with .when() for pattern matching
  DataState<List<BlogPost>> get postsState => _watch.postsState;

  /// Featured posts state
  DataState<List<BlogPost>> get featuredState => _watch.featuredState;

  /// Recent posts state (for sidebar/widgets)
  DataState<List<BlogPost>> get recentState => _watch.recentState;

  /// Single post detail state
  DataState<BlogPost> get detailState => _watch.detailState;

  /// Tags state
  DataState<List<String>> get tagsState => _watch.tagsState;

  // ==================== DATA GETTERS ====================
  /// All posts (unfiltered)
  List<BlogPost> get allPosts => _watch.allPosts;

  /// Featured posts list
  List<BlogPost> get featuredPosts => _watch.featuredPosts;

  /// Recent posts list
  List<BlogPost> get recentPosts => _watch.recentPosts;

  /// Paginated posts for display
  List<BlogPost> get displayPosts => _watch.displayPosts;

  /// All available tags
  List<String> get allTags => _watch.allTags;

  /// Currently selected post
  BlogPost? get selectedPost => _watch.selectedPost;

  // ==================== STATUS GETTERS (Backward Compatible) ====================
  bool get isLoading => _watch.isLoading;
  bool get hasError => _watch.hasError;
  bool get isEmpty => _watch.isEmpty;
  String? get errorMessage => _watch.errorMessage;

  bool get isDetailLoading => _watch.isDetailLoading;
  bool get hasDetailError => _watch.hasDetailError;

  bool get isFeaturedLoading => _watch.isFeaturedLoading;
  bool get hasFeaturedError => _watch.hasFeaturedError;

  // ==================== PAGINATION GETTERS ====================
  bool get hasMore => _watch.hasMore;
  int get currentPage => _watch.currentPage;
  int get totalPages => _watch.totalPages;

  // ==================== FILTER & SEARCH GETTERS ====================
  String get searchQuery => _watch.searchQuery;
  String? get selectedTag => _watch.selectedTag;
  bool get showOnlyFeatured => _watch.showOnlyFeatured;
  bool get hasActiveFilters => _watch.hasActiveFilters;
  int get filteredPostsCount => _watch.filteredPostsCount;
  int get totalPostsCount => _watch.totalPostsCount;

  // ==================== FETCH ACTIONS ====================
  /// Fetch all posts
  Future<void> fetchAllPosts() => _provider.fetchAllPosts();

  /// Fetch featured posts
  Future<void> fetchFeaturedPosts() => _provider.fetchFeaturedPosts();

  /// Fetch recent posts
  Future<void> fetchRecentPosts({int limit = 5}) => _provider.fetchRecentPosts(limit: limit);

  /// Fetch post by ID
  Future<void> fetchPostById(String id) => _provider.fetchPostById(id);

  /// Fetch all tags
  Future<void> fetchAllTags() => _provider.fetchAllTags();

  /// Refresh all data
  Future<void> refresh() => _provider.refresh();

  // ==================== SEARCH ACTIONS ====================
  /// Search posts
  Future<void> search(String query) => _provider.searchPosts(query);

  /// Clear search
  void clearSearch() => _provider.clearSearch();

  // ==================== FILTER ACTIONS ====================
  /// Filter by tag
  Future<void> filterByTag(String? tag) => _provider.filterByTag(tag);

  /// Toggle featured filter
  void toggleFeaturedFilter() => _provider.toggleFeaturedFilter();

  /// Clear all filters
  void clearFilters() => _provider.clearFilters();

  // ==================== PAGINATION ACTIONS ====================
  /// Load more posts
  void loadMore() => _provider.loadMore();

  /// Reset pagination
  void resetPagination() => _provider.resetPagination();

  // ==================== UTILITY ACTIONS ====================
  /// Clear selected post (call when leaving detail page)
  void clearSelectedPost() => _provider.clearSelectedPost();

  /// Get post count by tag
  int getPostCountByTag(String tag) => _watch.getPostCountByTag(tag);

  /// Get filter summary text
  String getFilterSummaryText() => _watch.getFilterSummaryText();
}
