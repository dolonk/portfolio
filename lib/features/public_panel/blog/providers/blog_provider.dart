import 'package:flutter/material.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/pagination_state.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';
import '../../../../data_layer/domain/repositories/blog/blog_repository.dart';


class BlogProvider with ChangeNotifier {
  final BlogRepository repository;

  BlogProvider({required this.repository}) {
    _initialize();
  }

  // ==================== STATE HOLDERS ====================

  /// Main posts state
  DataState<List<BlogPost>> _postsState = DataState.initial();

  /// Featured posts state
  DataState<List<BlogPost>> _featuredState = DataState.initial();

  /// Single post detail state
  DataState<BlogPost> _detailState = DataState.initial();

  /// All tags state
  DataState<List<String>> _tagsState = DataState.initial();

  /// Recent posts state (for sidebar/widgets)
  DataState<List<BlogPost>> _recentState = DataState.initial();

  // ==================== PAGINATION ====================
  PaginationState<BlogPost> _pagination = PaginationState.initial(itemsPerPage: 6);

  // ==================== FILTER & SEARCH STATE ====================
  String _searchQuery = '';
  String? _selectedTag;
  bool _showOnlyFeatured = false;

  // ==================== INTERNAL LISTS ====================
  List<BlogPost> _allPosts = [];
  List<BlogPost> _filteredPosts = [];

  // ==================== PUBLIC GETTERS - States ====================
  DataState<List<BlogPost>> get postsState => _postsState;
  DataState<List<BlogPost>> get featuredState => _featuredState;
  DataState<BlogPost> get detailState => _detailState;
  DataState<List<String>> get tagsState => _tagsState;
  DataState<List<BlogPost>> get recentState => _recentState;

  // ==================== PUBLIC GETTERS - Data ====================
  List<BlogPost> get allPosts => _allPosts;
  List<BlogPost> get featuredPosts => _featuredState.data ?? [];
  List<BlogPost> get recentPosts => _recentState.data ?? [];
  List<String> get allTags => _tagsState.data ?? [];
  BlogPost? get selectedPost => _detailState.data;

  // ==================== PUBLIC GETTERS - Status (Backward Compatible) ====================
  bool get isLoading => _postsState.isLoading;
  bool get hasError => _postsState.hasError;
  bool get isEmpty => _postsState.isEmpty;
  String? get errorMessage => _postsState.errorMessage;

  // ==================== PUBLIC GETTERS - Featured ====================
  bool get isFeaturedLoading => _featuredState.isLoading;
  bool get hasFeaturedError => _featuredState.hasError;

  // ==================== PUBLIC GETTERS - Pagination ====================
  bool get hasMore => _pagination.hasMore;
  int get currentPage => _pagination.currentPage;
  int get totalPages => _pagination.totalPages;
  List<BlogPost> get displayPosts => _pagination.currentItems;

  // ==================== PUBLIC GETTERS - Filter & Search ====================
  String get searchQuery => _searchQuery;
  String? get selectedTag => _selectedTag;
  bool get showOnlyFeatured => _showOnlyFeatured;
  int get filteredPostsCount => _filteredPosts.length;
  int get totalPostsCount => _allPosts.length;
  bool get hasActiveFilters => _selectedTag != null || _showOnlyFeatured || _searchQuery.isNotEmpty;

  // ==================== PUBLIC GETTERS - Detail ====================
  bool get isDetailLoading => _detailState.isLoading;
  bool get hasDetailError => _detailState.hasError;

  // ==================== INITIALIZATION ====================
  Future<void> _initialize() async {
    debugPrint('🔄 BlogProvider: Initializing...');

    await Future.wait([fetchAllPosts(), fetchFeaturedPosts(), fetchAllTags(), fetchRecentPosts()]);

    debugPrint('✅ BlogProvider: Initialization complete!');
  }

  // ==================== FETCH METHODS ====================
  /// Fetch all posts
  Future<void> fetchAllPosts() async {
    _postsState = DataState.loading();
    notifyListeners();

    final result = await repository.getAllPosts();

    result.fold(
      (failure) {
        _postsState = DataState.error(failure.message);
        debugPrint('❌ Posts fetch failed: ${failure.message}');
      },
      (posts) {
        _allPosts = posts;
        _filteredPosts = posts;
        _pagination = _pagination.setItems(posts);
        _postsState = posts.isEmpty ? DataState.empty() : DataState.success(posts);
        debugPrint('✅ Fetched ${posts.length} posts');
      },
    );

    notifyListeners();
  }

  /// Fetch featured posts
  Future<void> fetchFeaturedPosts() async {
    _featuredState = DataState.loading();
    notifyListeners();

    final result = await repository.getFeaturedPosts();

    result.fold(
      (failure) {
        _featuredState = DataState.error(failure.message);
        debugPrint('❌ Featured posts fetch failed: ${failure.message}');
      },
      (posts) {
        _featuredState = posts.isEmpty ? DataState.empty() : DataState.success(posts);
        debugPrint('✅ Fetched ${posts.length} featured posts');
      },
    );

    notifyListeners();
  }

  /// Fetch recent posts (for sidebar/home widgets)
  Future<void> fetchRecentPosts({int limit = 5}) async {
    _recentState = DataState.loading();
    notifyListeners();

    final result = await repository.getRecentPosts(limit: limit);

    result.fold(
      (failure) {
        _recentState = DataState.error(failure.message);
        debugPrint('❌ Recent posts fetch failed: ${failure.message}');
      },
      (posts) {
        _recentState = posts.isEmpty ? DataState.empty() : DataState.success(posts);
        debugPrint('✅ Fetched ${posts.length} recent posts');
      },
    );

    notifyListeners();
  }

  /// Fetch all tags
  Future<void> fetchAllTags() async {
    _tagsState = DataState.loading();

    final result = await repository.getAllTags();

    result.fold(
      (failure) {
        _tagsState = DataState.error(failure.message);
        debugPrint('❌ Tags fetch failed: ${failure.message}');
      },
      (tags) {
        _tagsState = DataState.success(tags);
        debugPrint('✅ Fetched ${tags.length} tags');
      },
    );

    notifyListeners();
  }

  /// Fetch single post by ID
  Future<void> fetchPostById(String id) async {
    _detailState = DataState.loading();
    notifyListeners();

    final result = await repository.getPostById(id);

    result.fold(
      (failure) {
        _detailState = DataState.error(failure.message);
        debugPrint('❌ Post detail fetch failed: ${failure.message}');
      },
      (post) {
        _detailState = DataState.success(post);
        repository.incrementViewCount(id);
        debugPrint('✅ Fetched post: ${post.title}');
      },
    );

    notifyListeners();
  }

  // ==================== SEARCH METHODS ====================
  /// Search posts by query
  Future<void> searchPosts(String query) async {
    debugPrint('🔍 Searching: "$query"');
    _searchQuery = query;

    if (query.trim().isEmpty) {
      _resetToAllPosts();
      return;
    }

    _postsState = DataState.loading();
    notifyListeners();

    final result = await repository.searchPosts(query);

    result.fold(
      (failure) {
        _postsState = DataState.error(failure.message);
        _filteredPosts = [];
      },
      (posts) {
        _filteredPosts = posts;
        _pagination = _pagination.setItems(posts);
        _postsState = posts.isEmpty ? DataState.empty() : DataState.success(posts);
        debugPrint('✅ Found ${posts.length} results for "$query"');
      },
    );

    notifyListeners();
  }

  /// Clear search and reset
  void clearSearch() {
    debugPrint('🧹 Clearing search');
    _searchQuery = '';
    _resetToAllPosts();
  }

  // ==================== FILTER METHODS ====================
  /// Filter posts by tag
  Future<void> filterByTag(String? tag) async {
    debugPrint('🏷️ Filtering by tag: $tag');
    _selectedTag = tag;

    if (tag == null || tag.isEmpty) {
      _resetToAllPosts();
      return;
    }

    _postsState = DataState.loading();
    notifyListeners();

    final result = await repository.getPostsByTag(tag);

    result.fold(
      (failure) {
        _postsState = DataState.error(failure.message);
        _filteredPosts = [];
      },
      (posts) {
        _filteredPosts = posts;
        _pagination = _pagination.setItems(posts);
        _postsState = posts.isEmpty ? DataState.empty() : DataState.success(posts);
        debugPrint('✅ Found ${posts.length} posts with tag "$tag"');
      },
    );

    notifyListeners();
  }

  /// Toggle featured filter
  void toggleFeaturedFilter() {
    _showOnlyFeatured = !_showOnlyFeatured;

    if (_showOnlyFeatured) {
      _filteredPosts = _allPosts.where((p) => p.isFeatured).toList();
    } else {
      _filteredPosts = _allPosts;
    }

    _pagination = _pagination.setItems(_filteredPosts);
    _postsState = _filteredPosts.isEmpty ? DataState.empty() : DataState.success(_filteredPosts);

    notifyListeners();
  }

  /// Clear all filters
  void clearFilters() {
    debugPrint('🧹 Clearing all filters');
    _selectedTag = null;
    _showOnlyFeatured = false;
    _searchQuery = '';
    _resetToAllPosts();
  }

  // ==================== PAGINATION METHODS ====================
  /// Load more posts
  void loadMore() {
    if (!_pagination.hasMore || _postsState.isLoading) return;

    _pagination = _pagination.loadNextPage();
    debugPrint('📄 Loaded page ${_pagination.currentPage}');
    notifyListeners();
  }

  /// Reset pagination to first page
  void resetPagination() {
    _pagination = _pagination.reset();
    notifyListeners();
  }

  // ==================== UTILITY METHODS ====================
  /// Reset to all posts (internal)
  void _resetToAllPosts() {
    _filteredPosts = _allPosts;
    _pagination = _pagination.setItems(_allPosts);
    _postsState = _allPosts.isEmpty ? DataState.empty() : DataState.success(_allPosts);
    notifyListeners();
  }

  /// Get post count by specific tag
  int getPostCountByTag(String tag) {
    return _allPosts.where((post) => post.tags.contains(tag)).length;
  }

  /// Get filter summary text for UI
  String getFilterSummaryText() {
    final List<String> filters = [];

    if (_selectedTag != null) {
      filters.add('Tag: $_selectedTag');
    }

    if (_showOnlyFeatured) {
      filters.add('Featured only');
    }

    if (_searchQuery.isNotEmpty) {
      filters.add('Search: "$_searchQuery"');
    }

    if (filters.isEmpty) {
      return 'No filters applied';
    }

    return filters.join(' • ');
  }

  /// Refresh all data
  Future<void> refresh() async {
    debugPrint('🔄 Refreshing all data...');
    clearFilters();
    await _initialize();
  }

  /// Clear selected post (when leaving detail page)
  void clearSelectedPost() {
    _detailState = DataState.initial();
    notifyListeners();
  }

  @override
  void dispose() {
    _allPosts.clear();
    _filteredPosts.clear();
    debugPrint('🗑️ BlogProvider disposed');
    super.dispose();
  }
}
