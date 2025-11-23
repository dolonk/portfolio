import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/error/failures.dart';
import '../../../utility/enum/enum.dart';
import '../../../data_layer/domain/entities/blog/blog_post.dart';
import '../../../data_layer/domain/repositories/blog/blog_repository.dart';

/*class BlogProvider with ChangeNotifier {
  final BlogRepository repository;

  BlogProvider({required this.repository}) {
    _initializeProvider();
  }

  // ==================== MAIN STATE ====================
  List<BlogPost> _allPosts = [];
  List<BlogPost> _featuredPosts = [];
  List<BlogPost> _filteredPosts = [];
  BlogPost? _selectedPost;
  List<String> _allTags = [];

  // ==================== SEARCH STATE ====================
  String _searchQuery = '';

  // ==================== FILTER STATE ====================
  String? _selectedTag;
  final List<String> _selectedTags = [];
  bool _showOnlyFeatured = false;

  // ==================== STATUS STATE ====================
  GettingStatus _status = GettingStatus.initial;
  GettingStatus _featuredStatus = GettingStatus.initial;
  GettingStatus _detailStatus = GettingStatus.initial;

  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _postsPerPage = 6;

  // ==================== MAIN GETTERS ====================
  List<BlogPost> get allPosts => _allPosts;
  List<BlogPost> get featuredPosts => _featuredPosts;
  List<String> get allTags => _allTags;

  // ==================== SEARCH GETTERS ====================
  String get searchQuery => _searchQuery;

  // ==================== FILTER GETTERS ====================
  String? get selectedTag => _selectedTag;
  bool get showOnlyFeatured => _showOnlyFeatured;
  bool get hasActiveFilters =>
      _selectedTag != null || _selectedTags.isNotEmpty || _showOnlyFeatured || _searchQuery.isNotEmpty;

  // ==================== STATUS GETTERS ====================
  GettingStatus get detailStatus => _detailStatus;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  // Computed getters
  bool get isLoading => _status == GettingStatus.loading;
  bool get hasError => _status == GettingStatus.error;
  bool get isEmpty => _status == GettingStatus.empty;
  bool get isDetailLoading => _detailStatus == GettingStatus.loading;

  // ==================== DISPLAY POSTS (Paginated) ====================
  List<BlogPost> get displayPosts {
    final endIndex = _currentPage * _postsPerPage;
    if (endIndex >= _filteredPosts.length) {
      _hasMore = false;
      return _filteredPosts;
    }
    return _filteredPosts.sublist(0, endIndex);
  }

  // ==================== INITIALIZATION ====================
  Future<void> _initializeProvider() async {
    print('🔄 BlogProvider: Starting initialization...');
    await fetchAllPosts();
    await fetchFeaturedPosts();
    await fetchAllTags();
    print('✅ BlogProvider: Initialization complete!');
  }

  // ==================== FETCH METHODS ====================
  /// Fetch all blog posts
  Future<void> fetchAllPosts() async {
    print('📥 Fetching all posts...');
    _status = GettingStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.getAllPosts();

    result.fold(
      (failure) {
        print('❌ Failed to fetch posts: ${failure.message}');
        _status = GettingStatus.error;
        _errorMessage = failure.message;
      },
      (posts) {
        print('✅ Fetched ${posts.length} posts successfully');
        _allPosts = posts;
        _filteredPosts = posts;
        _status = posts.isEmpty ? GettingStatus.empty : GettingStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
      },
    );
    notifyListeners();
  }

  /// Fetch featured posts only
  Future<void> fetchFeaturedPosts() async {
    print('📥 Fetching featured posts...');
    _featuredStatus = GettingStatus.loading;
    notifyListeners();

    final result = await repository.getFeaturedPosts();

    result.fold(
      (failure) {
        print('❌ Failed to fetch featured posts: ${failure.message}');
        _featuredStatus = GettingStatus.error;
      },
      (posts) {
        print('✅ Fetched ${posts.length} featured posts');
        _featuredPosts = posts;
        _featuredStatus = posts.isEmpty ? GettingStatus.empty : GettingStatus.success;
      },
    );
    notifyListeners();
  }

  /// Fetch all available tags
  Future<void> fetchAllTags() async {
    print('📥 Fetching tags...');
    final result = await repository.getAllTags();

    result.fold((failure) => print('⚠️ Failed to fetch tags: ${failure.message}'), (tags) {
      print('✅ Fetched ${tags.length} tags');
      _allTags = tags;
      notifyListeners();
    });
  }

  /// Fetch single post by ID
  Future<void> fetchPostById(String id) async {
    _detailStatus = GettingStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.getPostById(id);

    result.fold(
      (failure) {
        _detailStatus = GettingStatus.error;
        _errorMessage = failure.message;
      },
      (post) {
        _selectedPost = post;
        _detailStatus = GettingStatus.success;
        repository.incrementViewCount(id);
      },
    );
    notifyListeners();
  }

  // ==================== SEARCH METHODS ====================
  /// Search posts by query
  Future<void> searchPosts(String query) async {
    print('🔍 Searching for: "$query"');
    _searchQuery = query;

    if (query.trim().isEmpty) {
      _resetToAllPosts();
      return;
    }

    _status = GettingStatus.loading;
    notifyListeners();

    final result = await repository.searchPosts(query);

    result.fold(
      (failure) {
        print('❌ Search failed: ${failure.message}');
        _status = GettingStatus.error;
        _errorMessage = failure.message;
        _filteredPosts = [];
      },
      (posts) {
        print('✅ Found ${posts.length} results for "$query"');
        _filteredPosts = posts;
        _status = posts.isEmpty ? GettingStatus.empty : GettingStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
      },
    );
    notifyListeners();
  }

  /// Clear search
  void clearSearch() {
    print('🧹 Clearing search');
    _searchQuery = '';
    _resetToAllPosts();
  }

  // ==================== FILTER METHODS ====================
  /// Filter posts by single tag
  Future<void> filterByTag(String? tag) async {
    print('🏷️ Filtering by tag: $tag');
    _selectedTag = tag;

    if (tag == null || tag.isEmpty) {
      _resetToAllPosts();
      return;
    }

    _status = GettingStatus.loading;
    notifyListeners();

    final result = await repository.getPostsByTag(tag);

    result.fold(
      (failure) {
        _status = GettingStatus.error;
        _errorMessage = failure.message;
      },
      (posts) {
        print('✅ Found ${posts.length} posts with tag "$tag"');
        _filteredPosts = posts;
        _status = posts.isEmpty ? GettingStatus.empty : GettingStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
      },
    );
    notifyListeners();
  }

  // ==================== PAGINATION ====================
  /// Load more posts
  void loadMore() {
    if (!_hasMore || _status == GettingStatus.loading) return;
    _currentPage++;
    _hasMore = (_currentPage * _postsPerPage) < _filteredPosts.length;
    notifyListeners();
  }

  // ==================== CLEAR / RESET METHODS ====================
  /// Reset to all posts
  void _resetToAllPosts() {
    _filteredPosts = _allPosts;
    _status = _allPosts.isEmpty ? GettingStatus.empty : GettingStatus.success;
    _currentPage = 1;
    _hasMore = _filteredPosts.length > _postsPerPage;
    notifyListeners();
  }

  /// Clear all filters and search
  void clearFilters() {
    print('🧹 Clearing all filters');
    _selectedTag = null;
    _selectedTags.clear();
    _showOnlyFeatured = false;
    _searchQuery = '';
    _resetToAllPosts();
  }

  /// Refresh all data
  Future<void> refresh() async {
    clearFilters();
    await _initializeProvider();
  }

  @override
  void dispose() {
    _allPosts.clear();
    _featuredPosts.clear();
    _filteredPosts.clear();
    _selectedTags.clear();
    _allTags.clear();
    super.dispose();
  }
}*/

class BlogProvider with ChangeNotifier {
  final BlogRepository repository;

  BlogProvider({required this.repository}) {
    _initializeProvider();
  }

  // ==================== STATE HOLDERS ====================
  final List<BlogPost> _allPosts = [];
  final List<BlogPost> _featuredPosts = [];
  final List<BlogPost> _filteredPosts = [];
  final List<String> _allTags = [];
  final List<String> _selectedTags = [];
  BlogPost? _selectedPost;

  String _searchQuery = '';
  String? _selectedTag;
  bool _showOnlyFeatured = false;

  // ==================== STATUS MANAGEMENT ====================
  final _statusManager = _StatusManager();

  // ==================== PAGINATION ====================
  final _paginationManager = _PaginationManager(postsPerPage: 6);

  // ==================== PUBLIC GETTERS ====================
  List<BlogPost> get allPosts => _allPosts;
  List<BlogPost> get featuredPosts => _featuredPosts;
  List<String> get allTags => _allTags;
  String get searchQuery => _searchQuery;
  String? get selectedTag => _selectedTag;
  bool get showOnlyFeatured => _showOnlyFeatured;
  BlogPost? get selectedPost => _selectedPost;
  bool get hasActiveFilters =>
      _selectedTag != null || _selectedTags.isNotEmpty || _showOnlyFeatured || _searchQuery.isNotEmpty;

  // Status getters
  GettingStatus get status => _statusManager.mainStatus;
  GettingStatus get featuredStatus => _statusManager.featuredStatus;
  GettingStatus get detailStatus => _statusManager.detailStatus;
  String? get errorMessage => _statusManager.errorMessage;
  bool get hasMore => _paginationManager.hasMore;

  // Computed getters
  bool get isLoading => _statusManager.isLoading;
  bool get hasError => _statusManager.hasError;
  bool get isEmpty => _statusManager.isEmpty;
  bool get isDetailLoading => _statusManager.isDetailLoading;
  bool get hasDetailError => _statusManager.hasDetailError;

  // ==================== DISPLAY POSTS (Paginated) ====================
  List<BlogPost> get displayPosts => _paginationManager.getPaginatedPosts(_filteredPosts);

  // ==================== INITIALIZATION ====================
  Future<void> _initializeProvider() async {
    print('🔄 BlogProvider: Starting initialization...');
    await Future.wait([fetchAllPosts(), fetchFeaturedPosts(), fetchAllTags()]);
    print('✅ BlogProvider: Initialization complete!');
  }

  // ==================== Helper FETCH METHOD ====================
  Future<void> _fetchData<T>({
    required Future<Either<Failure, T>> Function() fetchFunction,
    required void Function(T data) onSuccess,
    required GettingStatus Function(T data) getSuccessStatus,
    required _StatusType statusType,
    bool notify = true,
  }) async {
    _statusManager.setLoading(statusType);
    if (notify) notifyListeners();

    final result = await fetchFunction();

    result.fold(
      (failure) {
        _statusManager.setError(statusType, failure.message);
        print('❌ ${statusType.name} fetch failed: ${failure.message}');
      },
      (data) {
        onSuccess(data);
        _statusManager.setStatus(statusType, getSuccessStatus(data));
        print('✅ ${statusType.name} fetch successful: ${_getDataInfo(data)}');
      },
    );

    if (notify) notifyListeners();
  }

  // ==================== MAIN FETCH METHODS ====================
  Future<void> fetchAllPosts() => _fetchData<List<BlogPost>>(
    fetchFunction: repository.getAllPosts,
    onSuccess: (posts) {
      _allPosts
        ..clear()
        ..addAll(posts);
      _resetToAllPosts();
    },
    getSuccessStatus: (posts) => posts.isEmpty ? GettingStatus.empty : GettingStatus.success,
    statusType: _StatusType.main,
  );

  Future<void> fetchFeaturedPosts() => _fetchData<List<BlogPost>>(
    fetchFunction: repository.getFeaturedPosts,
    onSuccess: (posts) => _featuredPosts
      ..clear()
      ..addAll(posts),
    getSuccessStatus: (posts) => posts.isEmpty ? GettingStatus.empty : GettingStatus.success,
    statusType: _StatusType.featured,
  );

  Future<void> fetchAllTags() => _fetchData<List<String>>(
    fetchFunction: repository.getAllTags,
    onSuccess: (tags) => _allTags
      ..clear()
      ..addAll(tags),
    getSuccessStatus: (tags) => GettingStatus.success,
    statusType: _StatusType.tags,
    notify: false,
  );

  Future<void> fetchPostById(String id) => _fetchData<BlogPost>(
    fetchFunction: () => repository.getPostById(id),
    onSuccess: (post) {
      _selectedPost = post;
      repository.incrementViewCount(id);
    },
    getSuccessStatus: (_) => GettingStatus.success,
    statusType: _StatusType.detail,
  );

  // ==================== SEARCH & FILTER METHODS ====================
  Future<void> searchPosts(String query) async {
    print('🔍 Searching for: "$query"');
    _searchQuery = query;

    if (query.trim().isEmpty) {
      _resetToAllPosts();
      return;
    }

    await _fetchData<List<BlogPost>>(
      fetchFunction: () => repository.searchPosts(query),
      onSuccess: (posts) => _updateFilteredPosts(posts),
      getSuccessStatus: (posts) => posts.isEmpty ? GettingStatus.empty : GettingStatus.success,
      statusType: _StatusType.main,
    );
  }

  Future<void> filterByTag(String? tag) async {
    print('🏷️ Filtering by tag: $tag');
    _selectedTag = tag;

    if (tag == null || tag.isEmpty) {
      _resetToAllPosts();
      return;
    }

    await _fetchData<List<BlogPost>>(
      fetchFunction: () => repository.getPostsByTag(tag),
      onSuccess: (posts) => _updateFilteredPosts(posts),
      getSuccessStatus: (posts) => posts.isEmpty ? GettingStatus.empty : GettingStatus.success,
      statusType: _StatusType.main,
    );
  }

  // ==================== HELPER METHODS ====================
  void _updateFilteredPosts(List<BlogPost> posts) {
    _filteredPosts
      ..clear()
      ..addAll(posts);
    _paginationManager.reset();
    _paginationManager.updateHasMore(posts.length);
  }

  void _resetToAllPosts() {
    _filteredPosts
      ..clear()
      ..addAll(_allPosts);
    _paginationManager.reset();
    _paginationManager.updateHasMore(_allPosts.length);
    _statusManager.setMainStatus(_allPosts.isEmpty ? GettingStatus.empty : GettingStatus.success);
    notifyListeners();
  }

  // ==================== PUBLIC ACTIONS ====================
  void clearSearch() {
    print('🧹 Clearing search');
    _searchQuery = '';
    _resetToAllPosts();
  }

  void clearFilters() {
    print('🧹 Clearing all filters');
    _selectedTag = null;
    _selectedTags.clear();
    _showOnlyFeatured = false;
    _searchQuery = '';
    _resetToAllPosts();
  }

  void loadMore() {
    if (!_paginationManager.canLoadMore || _statusManager.isLoading) return;
    _paginationManager.loadNextPage();
    notifyListeners();
  }

  Future<void> refresh() async {
    clearFilters();
    await _initializeProvider();
  }

  @override
  void dispose() {
    _allPosts.clear();
    _featuredPosts.clear();
    _filteredPosts.clear();
    _selectedTags.clear();
    _allTags.clear();
    _selectedPost = null;
    super.dispose();
  }

  // ==================== PRIVATE HELPER METHODS ====================
  String _getDataInfo<T>(T data) {
    if (data is List) return '${data.length} items';
    if (data is BlogPost) return 'post: ${data.title}';
    return 'data updated';
  }
}

// ==================== STATUS MANAGEMENT CLASS ====================
class _StatusManager {
  GettingStatus _mainStatus = GettingStatus.initial;
  GettingStatus _featuredStatus = GettingStatus.initial;
  GettingStatus _detailStatus = GettingStatus.initial;
  String? _errorMessage;

  // Getters
  GettingStatus get mainStatus => _mainStatus;
  GettingStatus get featuredStatus => _featuredStatus;
  GettingStatus get detailStatus => _detailStatus;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _mainStatus == GettingStatus.loading;
  bool get hasError => _mainStatus == GettingStatus.error;
  bool get isEmpty => _mainStatus == GettingStatus.empty;
  bool get isDetailLoading => _detailStatus == GettingStatus.loading;
  bool get hasDetailError => _detailStatus == GettingStatus.error;
  bool get isFeaturedLoading => _featuredStatus == GettingStatus.loading;

  // Methods
  void setLoading(_StatusType type) {
    _errorMessage = null;
    _setStatus(type, GettingStatus.loading);
  }

  void setError(_StatusType type, String message) {
    _errorMessage = message;
    _setStatus(type, GettingStatus.error);
  }

  void setStatus(_StatusType type, GettingStatus status) {
    _setStatus(type, status);
  }

  void setMainStatus(GettingStatus status) {
    _mainStatus = status;
  }

  void _setStatus(_StatusType type, GettingStatus status) {
    switch (type) {
      case _StatusType.main:
        _mainStatus = status;
        break;
      case _StatusType.featured:
        _featuredStatus = status;
        break;
      case _StatusType.detail:
        _detailStatus = status;
        break;
      case _StatusType.tags:
        break;
    }
  }
}

// ==================== PAGINATION MANAGEMENT CLASS ====================
class _PaginationManager {
  final int postsPerPage;
  int _currentPage = 1;
  bool _hasMore = true;

  _PaginationManager({required this.postsPerPage});

  bool get hasMore => _hasMore;
  bool get canLoadMore => _hasMore;

  List<BlogPost> getPaginatedPosts(List<BlogPost> posts) {
    final endIndex = _currentPage * postsPerPage;
    if (endIndex >= posts.length) {
      _hasMore = false;
      return posts;
    }
    return posts.sublist(0, endIndex);
  }

  void loadNextPage() {
    _currentPage++;
  }

  void reset() {
    _currentPage = 1;
    _hasMore = true;
  }

  void updateHasMore(int totalPosts) {
    _hasMore = totalPosts > (_currentPage * postsPerPage);
  }
}

// ==================== STATUS TYPE ENUM ====================
enum _StatusType {
  main('Main Posts'),
  featured('Featured Posts'),
  detail('Post Detail'),
  tags('Tags');

  const _StatusType(this.name);
  final String name;
}
