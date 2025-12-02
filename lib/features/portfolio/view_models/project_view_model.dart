import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/state/state.dart';
import '../providers/project_provider.dart';
import '../../../data_layer/domain/entities/portfolio/project.dart';

class ProjectViewModel {
  final BuildContext context;
  ProjectViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  /// Read-only access (for actions)
  ProjectProvider get _provider => context.read<ProjectProvider>();

  /// Watch access (for reactive UI)
  ProjectProvider get _watch => context.watch<ProjectProvider>();

  // ==================== STATE GETTERS ====================
  /// Main projects state - use with .when() for pattern matching
  DataState<List<Project>> get projectsState => _watch.projectsState;

  /// Featured projects state
  DataState<List<Project>> get featuredState => _watch.featuredState;

  /// Recent projects state
  DataState<List<Project>> get recentState => _watch.recentState;

  /// Single project detail state
  DataState<Project> get detailState => _watch.detailState;

  /// Categories state
  DataState<List<String>> get categoriesState => _watch.categoriesState;

  /// Platforms state
  DataState<List<String>> get platformsState => _watch.platformsState;

  /// Tech stacks state
  DataState<List<String>> get techStacksState => _watch.techStacksState;

  // ==================== DATA GETTERS ====================
  /// All projects (unfiltered)
  List<Project> get allProjects => _watch.allProjects;

  /// Featured projects list
  List<Project> get featuredProjects => _watch.featuredProjects;

  /// Recent projects list
  List<Project> get recentProjects => _watch.recentProjects;

  /// Paginated projects for display
  List<Project> get displayProjects => _watch.displayProjects;

  /// All available categories
  List<String> get categories => _watch.categories;

  /// All available platforms
  List<String> get platforms => _watch.platforms;

  /// All available tech stacks
  List<String> get techStacks => _watch.techStacks;

  /// Currently selected project
  Project? get selectedProject => _watch.selectedProject;

  // ==================== STATUS GETTERS ====================
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
  String? get selectedCategory => _watch.selectedCategory;
  String? get selectedPlatform => _watch.selectedPlatform;
  List<String> get selectedTechStacks => _watch.selectedTechStacks;
  bool get hasActiveFilters => _watch.hasActiveFilters;
  int get filteredProjectsCount => _watch.filteredProjectsCount;
  int get totalProjectsCount => _watch.totalProjectsCount;

  // ==================== FETCH ACTIONS ====================
  /// Fetch all projects
  Future<void> fetchAllProjects() => _provider.fetchAllProjects();

  /// Fetch featured projects
  Future<void> fetchFeaturedProjects() => _provider.fetchFeaturedProjects();

  /// Fetch recent projects
  Future<void> fetchRecentProjects({int limit = 3}) => _provider.fetchRecentProjects(limit: limit);

  /// Fetch project by ID
  Future<void> fetchProjectById(String id) => _provider.fetchProjectById(id);

  /// Fetch categories
  Future<void> fetchCategories() => _provider.fetchCategories();

  /// Fetch platforms
  Future<void> fetchPlatforms() => _provider.fetchPlatforms();

  /// Fetch tech stacks
  Future<void> fetchTechStacks() => _provider.fetchTechStacks();

  /// Refresh all data
  Future<void> refresh() => _provider.refresh();

  // ==================== SEARCH ACTIONS ====================
  /// Search projects
  Future<void> search(String query) => _provider.searchProjects(query);

  /// Clear search
  void clearSearch() => _provider.clearSearch();

  // ==================== FILTER ACTIONS ====================
  /// Filter by category
  Future<void> filterByCategory(String? category) => _provider.filterByCategory(category);

  /// Filter by platform
  Future<void> filterByPlatform(String? platform) => _provider.filterByPlatform(platform);

  /// Toggle tech stack filter
  void toggleTechStackFilter(String techStack) => _provider.toggleTechStackFilter(techStack);

  /// Clear all filters
  void clearFilters() => _provider.clearFilters();

  // ==================== PAGINATION ACTIONS ====================
  /// Load more projects
  void loadMore() => _provider.loadMore();

  /// Reset pagination
  void resetPagination() => _provider.resetPagination();

  // ==================== UTILITY ACTIONS ====================
  /// Clear selected project
  void clearSelectedProject() => _provider.clearSelectedProject();

  /// Get project count by category
  int getProjectCountByCategory(String category) => _watch.getProjectCountByCategory(category);

  /// Get project count by platform
  int getProjectCountByPlatform(String platform) => _watch.getProjectCountByPlatform(platform);

  /// Get project count by tech stack
  int getProjectCountByTechStack(String techStack) => _watch.getProjectCountByTechStack(techStack);

  /// Get filter summary text
  String getFilterSummaryText() => _watch.getFilterSummaryText();
}
