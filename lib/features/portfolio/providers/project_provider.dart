import 'package:flutter/foundation.dart';
import '../../../core/state/state.dart';
import '../../../data_layer/domain/entities/portfolio/project.dart';
import '../../../data_layer/domain/repositories/portfolio/project_repository.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectRepository repository;

  ProjectProvider({required this.repository}) {
    _initialize();
  }

  // ==================== STATE HOLDERS ====================
  /// Main projects state
  DataState<List<Project>> _projectsState = DataState.initial();

  /// Featured projects state
  DataState<List<Project>> _featuredState = DataState.initial();

  /// Single project detail state
  DataState<Project> _detailState = DataState.initial();

  /// Categories state
  DataState<List<String>> _categoriesState = DataState.initial();

  /// Platforms state
  DataState<List<String>> _platformsState = DataState.initial();

  /// Tech stacks state
  DataState<List<String>> _techStacksState = DataState.initial();

  /// Recent projects state
  DataState<List<Project>> _recentState = DataState.initial();

  // ==================== PAGINATION ====================
  PaginationState<Project> _pagination = PaginationState.initial(itemsPerPage: 3);

  // ==================== FILTER & SEARCH STATE ====================
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedPlatform;
  List<String> _selectedTechStacks = [];

  // ==================== INTERNAL LISTS ====================
  List<Project> _allProjects = [];
  List<Project> _filteredProjects = [];

  // ==================== PUBLIC GETTERS - States ====================
  DataState<List<Project>> get projectsState => _projectsState;
  DataState<List<Project>> get featuredState => _featuredState;
  DataState<Project> get detailState => _detailState;
  DataState<List<String>> get categoriesState => _categoriesState;
  DataState<List<String>> get platformsState => _platformsState;
  DataState<List<String>> get techStacksState => _techStacksState;
  DataState<List<Project>> get recentState => _recentState;

  // ==================== PUBLIC GETTERS - Data ====================
  List<Project> get allProjects => _allProjects;
  List<Project> get featuredProjects => _featuredState.data ?? [];
  List<Project> get recentProjects => _recentState.data ?? [];
  List<String> get categories => _categoriesState.data ?? [];
  List<String> get platforms => _platformsState.data ?? [];
  List<String> get techStacks => _techStacksState.data ?? [];
  Project? get selectedProject => _detailState.data;

  /// Paginated projects for display
  List<Project> get displayProjects => _pagination.currentItems;

  // ==================== PUBLIC GETTERS - Status ====================
  bool get isLoading => _projectsState.isLoading;
  bool get hasError => _projectsState.hasError;
  bool get isEmpty => _projectsState.isEmpty;
  String? get errorMessage => _projectsState.errorMessage;

  bool get isDetailLoading => _detailState.isLoading;
  bool get hasDetailError => _detailState.hasError;

  bool get isFeaturedLoading => _featuredState.isLoading;
  bool get hasFeaturedError => _featuredState.hasError;

  // ==================== PUBLIC GETTERS - Pagination ====================
  bool get hasMore => _pagination.hasMore;
  int get currentPage => _pagination.currentPage;
  int get totalPages => _pagination.totalPages;

  // ==================== PUBLIC GETTERS - Filter & Search ====================
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  String? get selectedPlatform => _selectedPlatform;
  List<String> get selectedTechStacks => _selectedTechStacks;
  bool get hasActiveFilters =>
      _selectedCategory != null ||
      _selectedPlatform != null ||
      _selectedTechStacks.isNotEmpty ||
      _searchQuery.isNotEmpty;

  /// ==================== PUBLIC GETTERS - Utility ====================
  int get filteredProjectsCount => _filteredProjects.length;
  int get totalProjectsCount => _allProjects.length;

  /// ==================== INITIALIZATION ====================
  Future<void> _initialize() async {
    debugPrint('🔄 ProjectProvider: Initializing...');

    await Future.wait([
      fetchAllProjects(),
      fetchFeaturedProjects(),
      fetchCategories(),
      fetchPlatforms(),
      fetchTechStacks(),
      fetchRecentProjects(),
    ]);

    debugPrint('✅ ProjectProvider: Initialization complete!');
  }

  /// ==================== FETCH METHODS ====================
  Future<void> fetchAllProjects() async {
    _projectsState = DataState.loading();
    notifyListeners();

    final result = await repository.getAllProjects();

    result.fold(
      (failure) {
        _projectsState = DataState.error(failure.message);
        debugPrint('❌ Projects fetch failed: ${failure.message}');
      },
      (projects) {
        _allProjects = projects;
        _filteredProjects = projects;
        _pagination = _pagination.setItems(projects);
        _projectsState = projects.isEmpty ? DataState.empty() : DataState.success(projects);
        debugPrint('✅ Fetched ${projects.length} projects');
      },
    );

    notifyListeners();
  }

  Future<void> fetchFeaturedProjects() async {
    _featuredState = DataState.loading();
    notifyListeners();

    final result = await repository.getFeaturedProjects();

    result.fold(
      (failure) {
        _featuredState = DataState.error(failure.message);
        debugPrint('❌ Featured projects fetch failed: ${failure.message}');
      },
      (projects) {
        _featuredState = projects.isEmpty ? DataState.empty() : DataState.success(projects);
        debugPrint('✅ Fetched ${projects.length} featured projects');
      },
    );

    notifyListeners();
  }

  Future<void> fetchRecentProjects({int limit = 6}) async {
    _recentState = DataState.loading();
    notifyListeners();

    final result = await repository.getRecentProjects(limit: limit);

    result.fold(
      (failure) {
        _recentState = DataState.error(failure.message);
        debugPrint('❌ Recent projects fetch failed: ${failure.message}');
      },
      (projects) {
        _recentState = projects.isEmpty ? DataState.empty() : DataState.success(projects);
        debugPrint('✅ Fetched ${projects.length} recent projects');
      },
    );

    notifyListeners();
  }

  Future<void> fetchCategories() async {
    _categoriesState = DataState.loading();

    final result = await repository.getAllCategories();

    result.fold(
      (failure) {
        _categoriesState = DataState.error(failure.message);
        debugPrint('❌ Categories fetch failed: ${failure.message}');
      },
      (categories) {
        _categoriesState = DataState.success(categories);
        debugPrint('✅ Fetched ${categories.length} categories');
      },
    );

    notifyListeners();
  }

  Future<void> fetchPlatforms() async {
    _platformsState = DataState.loading();

    final result = await repository.getAllPlatforms();

    result.fold(
      (failure) {
        _platformsState = DataState.error(failure.message);
        debugPrint('❌ Platforms fetch failed: ${failure.message}');
      },
      (platforms) {
        _platformsState = DataState.success(platforms);
        debugPrint('✅ Fetched ${platforms.length} platforms');
      },
    );

    notifyListeners();
  }

  Future<void> fetchTechStacks() async {
    _techStacksState = DataState.loading();

    final result = await repository.getAllTechStacks();

    result.fold(
      (failure) {
        _techStacksState = DataState.error(failure.message);
        debugPrint('❌ Tech stacks fetch failed: ${failure.message}');
      },
      (techStacks) {
        _techStacksState = DataState.success(techStacks);
        debugPrint('✅ Fetched ${techStacks.length} tech stacks');
      },
    );

    notifyListeners();
  }

  Future<void> fetchProjectById(String id) async {
    _detailState = DataState.loading();
    notifyListeners();

    final result = await repository.getProjectById(id);

    result.fold(
      (failure) {
        _detailState = DataState.error(failure.message);
        debugPrint('❌ Project detail fetch failed: ${failure.message}');
      },
      (project) {
        _detailState = DataState.success(project);
        // Increment view count (fire and forget)
        repository.incrementViewCount(id);
        debugPrint('✅ Fetched project: ${project.title}');
      },
    );

    notifyListeners();
  }

  /// ==================== SEARCH METHODS ====================
  Future<void> searchProjects(String query) async {
    debugPrint('🔍 Searching: "$query"');
    _searchQuery = query;

    if (query.trim().isEmpty) {
      _resetToAllProjects();
      return;
    }

    _projectsState = DataState.loading();
    notifyListeners();

    final result = await repository.searchProjects(query);

    result.fold(
      (failure) {
        _projectsState = DataState.error(failure.message);
        _filteredProjects = [];
      },
      (projects) {
        _filteredProjects = projects;
        _pagination = _pagination.setItems(projects);
        _projectsState = projects.isEmpty ? DataState.empty() : DataState.success(projects);
        debugPrint('✅ Found ${projects.length} results for "$query"');
      },
    );

    notifyListeners();
  }

  void clearSearch() {
    debugPrint('🧹 Clearing search');
    _searchQuery = '';
    _resetToAllProjects();
  }

  /// ==================== FILTER METHODS ====================
  Future<void> filterByCategory(String? category) async {
    debugPrint('📂 Filtering by category: $category');
    _selectedCategory = category;

    if (category == null || category.isEmpty) {
      _resetToAllProjects();
      return;
    }

    _projectsState = DataState.loading();
    notifyListeners();

    final result = await repository.getProjectsByCategory(category);

    result.fold(
      (failure) {
        _projectsState = DataState.error(failure.message);
        _filteredProjects = [];
      },
      (projects) {
        _filteredProjects = projects;
        _pagination = _pagination.setItems(projects);
        _projectsState = projects.isEmpty ? DataState.empty() : DataState.success(projects);
        debugPrint('✅ Found ${projects.length} projects in category "$category"');
      },
    );

    notifyListeners();
  }

  Future<void> filterByPlatform(String? platform) async {
    debugPrint('📱 Filtering by platform: $platform');
    _selectedPlatform = platform;

    if (platform == null || platform.isEmpty) {
      _resetToAllProjects();
      return;
    }

    _projectsState = DataState.loading();
    notifyListeners();

    final result = await repository.getProjectsByPlatform(platform);

    result.fold(
      (failure) {
        _projectsState = DataState.error(failure.message);
        _filteredProjects = [];
      },
      (projects) {
        _filteredProjects = projects;
        _pagination = _pagination.setItems(projects);
        _projectsState = projects.isEmpty ? DataState.empty() : DataState.success(projects);
        debugPrint('✅ Found ${projects.length} projects for platform "$platform"');
      },
    );

    notifyListeners();
  }

  void toggleTechStackFilter(String techStack) {
    if (_selectedTechStacks.contains(techStack)) {
      _selectedTechStacks.remove(techStack);
    } else {
      _selectedTechStacks.add(techStack);
    }

    if (_selectedTechStacks.isEmpty) {
      _resetToAllProjects();
    } else {
      _applyTechStackFilter();
    }
  }

  void _applyTechStackFilter() {
    _filteredProjects = _allProjects.where((project) {
      return _selectedTechStacks.any((tech) => project.techStack.contains(tech));
    }).toList();

    _pagination = _pagination.setItems(_filteredProjects);
    _projectsState = _filteredProjects.isEmpty ? DataState.empty() : DataState.success(_filteredProjects);
    notifyListeners();
  }

  void clearFilters() {
    debugPrint('🧹 Clearing all filters');
    _selectedCategory = null;
    _selectedPlatform = null;
    _selectedTechStacks = [];
    _searchQuery = '';
    _resetToAllProjects();
  }

  /// ==================== PAGINATION METHODS ====================
  void loadMore() {
    if (!_pagination.hasMore || _projectsState.isLoading) return;

    _pagination = _pagination.loadNextPage();
    debugPrint('📄 Loaded page ${_pagination.currentPage}');
    notifyListeners();
  }

  void resetPagination() {
    _pagination = _pagination.reset();
    notifyListeners();
  }

  /// ==================== Admin section ====================
  Future<bool> createProject(Project project) async {
    debugPrint('📝 Creating project: ${project.title}');

    try {
      final result = await repository.createProject(project);

      return result.fold(
        (failure) {
          debugPrint('❌ Create failed: ${failure.message}');
          _projectsState = DataState.error(failure.message);
          notifyListeners();
          return false;
        },
        (_) {
          debugPrint('✅ Project created successfully');
          refresh();
          return true;
        },
      );
    } catch (e) {
      debugPrint('❌ Create error: $e');
      _projectsState = DataState.error(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Update existing project
  Future<bool> updateProject(Project project) async {
    debugPrint('📝 Updating project: ${project.id}');

    try {
      final result = await repository.updateProject(project);

      return result.fold(
        (failure) {
          debugPrint('❌ Update failed: ${failure.message}');
          _projectsState = DataState.error(failure.message);
          notifyListeners();
          return false;
        },
        (_) {
          debugPrint('✅ Project updated successfully');
          refresh();
          return true;
        },
      );
    } catch (e) {
      debugPrint('❌ Update error: $e');
      _projectsState = DataState.error(e.toString());
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProject(String projectId) async {
    debugPrint('🗑️ Deleting project: $projectId');

    final result = await repository.deleteProject(projectId);

    return result.fold(
      (failure) {
        debugPrint('❌ Project delete failed: ${failure.message}');
        return false;
      },
      (_) {
        // Remove from local lists
        _allProjects.removeWhere((p) => p.id == projectId);
        _filteredProjects.removeWhere((p) => p.id == projectId);

        // Update pagination
        _pagination = _pagination.setItems(_filteredProjects);

        // Update state
        _projectsState = _filteredProjects.isEmpty ? DataState.empty() : DataState.success(_filteredProjects);

        notifyListeners();
        debugPrint('✅ Project deleted successfully');
        return true;
      },
    );
  }

  /// ==================== UTILITY METHODS ====================
  void _resetToAllProjects() {
    _filteredProjects = _allProjects;
    _pagination = _pagination.setItems(_allProjects);
    _projectsState = _allProjects.isEmpty ? DataState.empty() : DataState.success(_allProjects);
    notifyListeners();
  }

  int getProjectCountByCategory(String category) {
    return _allProjects.where((p) => p.category == category).length;
  }

  int getProjectCountByPlatform(String platform) {
    return _allProjects.where((p) => p.platforms.contains(platform)).length;
  }

  int getProjectCountByTechStack(String techStack) {
    return _allProjects.where((p) => p.techStack.contains(techStack)).length;
  }

  String getFilterSummaryText() {
    final List<String> filters = [];

    if (_selectedCategory != null) {
      filters.add('Category: $_selectedCategory');
    }

    if (_selectedPlatform != null) {
      filters.add('Platform: $_selectedPlatform');
    }

    if (_selectedTechStacks.isNotEmpty) {
      filters.add('Tech: ${_selectedTechStacks.join(", ")}');
    }

    if (_searchQuery.isNotEmpty) {
      filters.add('Search: "$_searchQuery"');
    }

    if (filters.isEmpty) {
      return 'No filters applied';
    }

    return filters.join(' • ');
  }

  Future<void> refresh() async {
    debugPrint('🔄 Refreshing all data...');
    clearFilters();
    await _initialize();
  }

  void clearSelectedProject() {
    _detailState = DataState.initial();
    notifyListeners();
  }

  @override
  void dispose() {
    _allProjects.clear();
    _filteredProjects.clear();
    _selectedTechStacks.clear();
    debugPrint('🗑️ ProjectProvider disposed');
    super.dispose();
  }
}
