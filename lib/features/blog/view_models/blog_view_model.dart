import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/enum/enum.dart';
import '../providers/blog_provider.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';

class BlogViewModel {
  final BuildContext context;

  BlogViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  BlogProvider get _provider => context.read<BlogProvider>();
  BlogProvider get _watchProvider => context.watch<BlogProvider>();

  // ==================== MAIN GETTERS ====================
  List<BlogPost> get allPosts => _watchProvider.allPosts;
  List<BlogPost> get featuredPosts => _watchProvider.featuredPosts;
  List<BlogPost> get displayPosts => _watchProvider.displayPosts;
  List<String> get allTags => _watchProvider.allTags;
  BlogPost? get selectedPost => _watchProvider.selectedPost;

  // ==================== STATUS GETTERS ====================
  bool get isLoading => _watchProvider.isLoading;
  bool get hasError => _watchProvider.hasError;
  bool get isEmpty => _watchProvider.isEmpty;
  bool get hasMore => _watchProvider.hasMore;
  String? get errorMessage => _watchProvider.errorMessage;

  // ADD DETAIL STATUS GETTERS
  bool get isDetailLoading => _watchProvider.isDetailLoading;
  bool get hasDetailError => _watchProvider.hasDetailError;
  bool get isFeaturedLoading => _watchProvider.featuredStatus == GettingStatus.loading;
  bool get hasFeaturedError => _watchProvider.featuredStatus == GettingStatus.error;

  // ==================== SEARCH GETTERS ====================
  String get searchQuery => _watchProvider.searchQuery;

  // ==================== FILTER GETTERS ====================
  String? get selectedTag => _watchProvider.selectedTag;
  bool get showOnlyFeatured => _watchProvider.showOnlyFeatured;
  bool get hasActiveFilters => _watchProvider.hasActiveFilters;

  // ==================== FETCH ACTIONS ====================
  Future<void> fetchAllPosts() async => await _provider.fetchAllPosts();

  /// Fetch post by ID
  Future<void> fetchPostById(String id) async => await _provider.fetchPostById(id);

  // ==================== SEARCH ACTIONS ====================
  Future<void> search(String query) async => await _provider.searchPosts(query);
  void clearSearch() => _provider.clearSearch();

  // ==================== FILTER ACTIONS ====================
  Future<void> filterByTag(String? tag) async => await _provider.filterByTag(tag);

  void clearFilters() => _provider.clearFilters();

  // ==================== PAGINATION ====================
  void loadMore() => _provider.loadMore();

  // ==================== OTHER ====================
  Future<void> refresh() async => await _provider.refresh();

  // ==================== HELPER METHODS ====================
  int getPostCountByTag(String tag) {
    return allPosts.where((post) => post.tags.contains(tag)).length;
  }

  String getFilterSummaryText() {
    if (!hasActiveFilters) return 'No filters applied';

    final parts = <String>[];
    if (selectedTag != null) parts.add('Tag: $selectedTag');
    if (searchQuery.isNotEmpty) parts.add('Search: "$searchQuery"');
    if (showOnlyFeatured) parts.add('Featured only');

    return parts.join(' • ');
  }
}
