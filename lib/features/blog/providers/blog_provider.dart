import 'package:flutter/foundation.dart';
import '../../../data_layer/domain/entities/blog/blog_post.dart';
import '../../../data_layer/domain/repositories/blog/blog_repository.dart';

/// Blog State Status
/*enum BlogStatus { initial, loading, success, error, empty }

class BlogProvider with ChangeNotifier {
  final BlogRepository repository;
  BlogProvider({required this.repository}) {
    _initializePosts();
  }

  // ==================== STATE ====================
  List<BlogPost> _allPosts = [];
  List<BlogPost> _featuredPosts = [];
  List<BlogPost> _filteredPosts = [];
  BlogPost? _selectedPost;
  List<String> _allTags = [];
  String? _selectedTag;
  String _searchQuery = '';

  BlogStatus _status = BlogStatus.initial;
  BlogStatus _featuredStatus = BlogStatus.initial;
  BlogStatus _detailStatus = BlogStatus.initial;

  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _postsPerPage = 6;

  // ==================== GETTERS ====================
  List<BlogPost> get allPosts => _allPosts;
  List<BlogPost> get featuredPosts => _featuredPosts;
  List<BlogPost> get filteredPosts => _filteredPosts;
  BlogPost? get selectedPost => _selectedPost;
  List<String> get allTags => _allTags;
  String? get selectedTag => _selectedTag;
  String get searchQuery => _searchQuery;

  BlogStatus get status => _status;
  BlogStatus get featuredStatus => _featuredStatus;
  BlogStatus get detailStatus => _detailStatus;

  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  // Computed getters
  bool get isLoading => _status == BlogStatus.loading;
  bool get isSuccess => _status == BlogStatus.success;
  bool get hasError => _status == BlogStatus.error;
  bool get isEmpty => _status == BlogStatus.empty;

  bool get isFeaturedLoading => _featuredStatus == BlogStatus.loading;
  bool get isDetailLoading => _detailStatus == BlogStatus.loading;

  // Display posts for UI (paginated)
  List<BlogPost> get displayPosts {
    final endIndex = _currentPage * _postsPerPage;
    if (endIndex >= _filteredPosts.length) {
      _hasMore = false;
      return _filteredPosts;
    }
    return _filteredPosts.sublist(0, endIndex);
  }

  // ==================== METHODS ====================

  /// Initialize posts automatically
  Future<void> _initializePosts() async {
    await fetchAllPosts();
  }

  /// Fetch all blog posts
  Future<void> fetchAllPosts() async {
    _status = BlogStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.getAllPosts();

    result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (posts) {
        _allPosts = posts;
        _filteredPosts = posts;
        _status = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
        notifyListeners();
      },
    );
  }

  /// Fetch featured posts only
  Future<void> fetchFeaturedPosts() async {
    _featuredStatus = BlogStatus.loading;
    notifyListeners();

    final result = await repository.getFeaturedPosts();

    result.fold(
      (failure) {
        _featuredStatus = BlogStatus.error;
        notifyListeners();
      },
      (posts) {
        _featuredPosts = posts;
        _featuredStatus = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        notifyListeners();
      },
    );
  }

  /// Fetch single post by ID
  Future<void> fetchPostById(String id) async {
    _detailStatus = BlogStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.getPostById(id);

    result.fold(
      (failure) {
        _detailStatus = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (post) {
        _selectedPost = post;
        _detailStatus = BlogStatus.success;
        notifyListeners();

        // Increment view count (fire and forget)
        repository.incrementViewCount(id);
      },
    );
  }

  /// Fetch all available tags
  Future<void> fetchAllTags() async {
    final result = await repository.getAllTags();

    result.fold(
      (failure) {
        // Silently fail - tags optional
      },
      (tags) {
        _allTags = tags;
        notifyListeners();
      },
    );
  }

  /// Filter posts by tag
  Future<void> filterByTag(String? tag) async {
    _selectedTag = tag;

    if (tag == null || tag.isEmpty) {
      // Reset filter
      _filteredPosts = _allPosts;
      _status = _allPosts.isEmpty ? BlogStatus.empty : BlogStatus.success;
      _currentPage = 1;
      _hasMore = _filteredPosts.length > _postsPerPage;
      notifyListeners();
      return;
    }

    _status = BlogStatus.loading;
    notifyListeners();

    final result = await repository.getPostsByTag(tag);

    result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (posts) {
        _filteredPosts = posts;
        _status = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
        notifyListeners();
      },
    );
  }

  /// Search posts
  Future<void> searchPosts(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      // Reset to all posts
      _filteredPosts = _allPosts;
      _status = _allPosts.isEmpty ? BlogStatus.empty : BlogStatus.success;
      _currentPage = 1;
      _hasMore = _filteredPosts.length > _postsPerPage;
      notifyListeners();
      return;
    }

    _status = BlogStatus.loading;
    notifyListeners();

    final result = await repository.searchPosts(query);

    result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (posts) {
        _filteredPosts = posts;
        _status = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
        notifyListeners();
      },
    );
  }

  /// Load more posts (pagination)
  void loadMore() {
    if (!_hasMore || _status == BlogStatus.loading) return;

    _currentPage++;

    if (_currentPage * _postsPerPage >= _filteredPosts.length) {
      _hasMore = false;
    }

    notifyListeners();
  }

  /// Reset pagination
  void resetPagination() {
    _currentPage = 1;
    _hasMore = _filteredPosts.length > _postsPerPage;
    notifyListeners();
  }

  /// Clear selected post
  void clearSelectedPost() {
    _selectedPost = null;
    _detailStatus = BlogStatus.initial;
    notifyListeners();
  }

  /// Clear all filters
  void clearFilters() {
    _selectedTag = null;
    _searchQuery = '';
    _filteredPosts = _allPosts;
    _status = _allPosts.isEmpty ? BlogStatus.empty : BlogStatus.success;
    _currentPage = 1;
    _hasMore = _filteredPosts.length > _postsPerPage;
    notifyListeners();
  }

  /// Refresh all data
  Future<void> refresh() async {
    await fetchAllPosts();
    await fetchFeaturedPosts();
    await fetchAllTags();
  }

  // ==================== ADMIN METHODS ====================
  /// Create new blog post
  Future<bool> createPost(BlogPost post) async {
    _status = BlogStatus.loading;
    notifyListeners();

    final result = await repository.createPost(post);

    return result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        _status = BlogStatus.success;
        // Refresh list after creating
        fetchAllPosts();
        return true;
      },
    );
  }

  /// Update existing post
  Future<bool> updatePost(BlogPost post) async {
    _status = BlogStatus.loading;
    notifyListeners();

    final result = await repository.updatePost(post);

    return result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        _status = BlogStatus.success;
        // Refresh list after updating
        fetchAllPosts();
        return true;
      },
    );
  }

  /// Delete post
  Future<bool> deletePost(String id) async {
    _status = BlogStatus.loading;
    notifyListeners();

    final result = await repository.deletePost(id);

    return result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        _status = BlogStatus.success;
        // Remove from local list
        _allPosts.removeWhere((post) => post.id == id);
        _filteredPosts.removeWhere((post) => post.id == id);
        notifyListeners();
        return true;
      },
    );
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up resources
    _allPosts.clear();
    _featuredPosts.clear();
    _filteredPosts.clear();
    _allTags.clear();
    _selectedPost = null;
    super.dispose();
  }
}*/

/// Blog State Status
enum BlogStatus { initial, loading, success, error, empty }

class BlogProvider with ChangeNotifier {
  final BlogRepository repository;

  BlogProvider({required this.repository}) {
    // ✅ AUTO-FETCH posts on initialization
    _initializeProvider();
  }

  // ==================== STATE ====================
  List<BlogPost> _allPosts = [];
  List<BlogPost> _featuredPosts = [];
  List<BlogPost> _filteredPosts = [];
  BlogPost? _selectedPost;
  List<String> _allTags = [];
  String? _selectedTag;
  String _searchQuery = '';

  BlogStatus _status = BlogStatus.initial;
  BlogStatus _featuredStatus = BlogStatus.initial;
  BlogStatus _detailStatus = BlogStatus.initial;

  String? _errorMessage;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _postsPerPage = 6;

  // ==================== GETTERS ====================
  List<BlogPost> get allPosts => _allPosts;
  List<BlogPost> get featuredPosts => _featuredPosts;
  List<BlogPost> get filteredPosts => _filteredPosts;
  BlogPost? get selectedPost => _selectedPost;
  List<String> get allTags => _allTags;
  String? get selectedTag => _selectedTag;
  String get searchQuery => _searchQuery;

  BlogStatus get status => _status;
  BlogStatus get featuredStatus => _featuredStatus;
  BlogStatus get detailStatus => _detailStatus;

  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  // Computed getters
  bool get isLoading => _status == BlogStatus.loading;
  bool get isSuccess => _status == BlogStatus.success;
  bool get hasError => _status == BlogStatus.error;
  bool get isEmpty => _status == BlogStatus.empty;

  bool get isFeaturedLoading => _featuredStatus == BlogStatus.loading;
  bool get isDetailLoading => _detailStatus == BlogStatus.loading;

  // Display posts for UI (paginated)
  List<BlogPost> get displayPosts {
    final endIndex = _currentPage * _postsPerPage;
    if (endIndex >= _filteredPosts.length) {
      _hasMore = false;
      return _filteredPosts;
    }
    return _filteredPosts.sublist(0, endIndex);
  }

  // ==================== INITIALIZATION ====================

  /// Initialize provider - auto-fetch all data
  Future<void> _initializeProvider() async {
    print('🔄 BlogProvider: Starting initialization...');
    await fetchAllPosts();
    await fetchFeaturedPosts();
    await fetchAllTags();
    print('✅ BlogProvider: Initialization complete!');
  }

  // ==================== METHODS ====================

  /// Fetch all blog posts
  Future<void> fetchAllPosts() async {
    print('📥 Fetching all posts...');
    _status = BlogStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.getAllPosts();

    result.fold(
      (failure) {
        print('❌ Failed to fetch posts: ${failure.message}');
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (posts) {
        print('✅ Fetched ${posts.length} posts successfully');
        _allPosts = posts;
        _filteredPosts = posts;
        _status = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
        notifyListeners();
      },
    );
  }

  /// Fetch featured posts only
  Future<void> fetchFeaturedPosts() async {
    print('📥 Fetching featured posts...');
    _featuredStatus = BlogStatus.loading;
    notifyListeners();

    final result = await repository.getFeaturedPosts();

    result.fold(
      (failure) {
        print('❌ Failed to fetch featured posts: ${failure.message}');
        _featuredStatus = BlogStatus.error;
        notifyListeners();
      },
      (posts) {
        print('✅ Fetched ${posts.length} featured posts');
        _featuredPosts = posts;
        _featuredStatus = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        notifyListeners();
      },
    );
  }

  /// Fetch all available tags
  Future<void> fetchAllTags() async {
    print('📥 Fetching tags...');
    final result = await repository.getAllTags();

    result.fold(
      (failure) {
        print('⚠️ Failed to fetch tags: ${failure.message}');
        // Silently fail - tags optional
      },
      (tags) {
        print('✅ Fetched ${tags.length} tags');
        _allTags = tags;
        notifyListeners();
      },
    );
  }

  /// Fetch single post by ID
  Future<void> fetchPostById(String id) async {
    _detailStatus = BlogStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await repository.getPostById(id);

    result.fold(
      (failure) {
        _detailStatus = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (post) {
        _selectedPost = post;
        _detailStatus = BlogStatus.success;
        notifyListeners();

        // Increment view count (fire and forget)
        repository.incrementViewCount(id);
      },
    );
  }

  /// Filter posts by tag
  Future<void> filterByTag(String? tag) async {
    _selectedTag = tag;

    if (tag == null || tag.isEmpty) {
      // Reset filter
      _filteredPosts = _allPosts;
      _status = _allPosts.isEmpty ? BlogStatus.empty : BlogStatus.success;
      _currentPage = 1;
      _hasMore = _filteredPosts.length > _postsPerPage;
      notifyListeners();
      return;
    }

    _status = BlogStatus.loading;
    notifyListeners();

    final result = await repository.getPostsByTag(tag);

    result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (posts) {
        _filteredPosts = posts;
        _status = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
        notifyListeners();
      },
    );
  }

  /// Search posts
  Future<void> searchPosts(String query) async {
    _searchQuery = query;

    if (query.isEmpty) {
      // Reset to all posts
      _filteredPosts = _allPosts;
      _status = _allPosts.isEmpty ? BlogStatus.empty : BlogStatus.success;
      _currentPage = 1;
      _hasMore = _filteredPosts.length > _postsPerPage;
      notifyListeners();
      return;
    }

    _status = BlogStatus.loading;
    notifyListeners();

    final result = await repository.searchPosts(query);

    result.fold(
      (failure) {
        _status = BlogStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (posts) {
        _filteredPosts = posts;
        _status = posts.isEmpty ? BlogStatus.empty : BlogStatus.success;
        _currentPage = 1;
        _hasMore = posts.length > _postsPerPage;
        notifyListeners();
      },
    );
  }

  /// Load more posts (pagination)
  void loadMore() {
    if (!_hasMore || _status == BlogStatus.loading) return;

    _currentPage++;
    _hasMore = (_currentPage * _postsPerPage) < _filteredPosts.length;
    notifyListeners();
  }

  /// Clear filters and search
  void clearFilters() {
    _selectedTag = null;
    _searchQuery = '';
    _filteredPosts = _allPosts;
    _status = _allPosts.isEmpty ? BlogStatus.empty : BlogStatus.success;
    _currentPage = 1;
    _hasMore = _filteredPosts.length > _postsPerPage;
    notifyListeners();
  }


  /// Clear selected post
  void clearSelectedPost() {
    _selectedPost = null;
    _detailStatus = BlogStatus.initial;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Refresh all data
  Future<void> refresh() async {
    await _initializeProvider();
  }
}
