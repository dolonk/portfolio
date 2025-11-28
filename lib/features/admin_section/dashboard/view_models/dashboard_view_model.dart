import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../blog/providers/blog_provider.dart';
import '../../../portfolio/providers/project_provider.dart';
import '../../../../data_layer/domain/entities/portfolio/project.dart';
import '../../../../data_layer/domain/entities/blog/blog_post.dart';

class DashboardViewModel {
  final BuildContext context;
  DashboardViewModel(this.context);

  // ==================== PROVIDER ACCESS ====================
  ProjectProvider get _projectProvider => context.read<ProjectProvider>();
  ProjectProvider get _watchProjects => context.watch<ProjectProvider>();

  BlogProvider get _blogProvider => context.read<BlogProvider>();
  BlogProvider get _watchBlogs => context.watch<BlogProvider>();

  // ==================== DASHBOARD STATS ====================
  /// Total projects count (from allProjects list)
  int get totalProjects => _watchProjects.allProjects.length;

  /// Total blogs count (from allPosts list)
  int get totalBlogs => _watchBlogs.allPosts.length;

  /// Total comments count (placeholder - implement when comment feature ready)
  int get totalComments => 0;

  /// Total views count (placeholder - implement when analytics ready)
  int get totalViews => 0;

  // ==================== RECENT DATA ====================
  /// Get recent projects (limit 5) from recentProjects getter
  List<Project> get recentProjects => _watchProjects.recentProjects.take(5).toList();

  /// Get recent blogs (limit 5) from recentPosts getter
  List<BlogPost> get recentBlogs => _watchBlogs.recentPosts.take(5).toList();

  // ==================== LOADING STATES ====================
  /// Check if projects are loading
  bool get isProjectsLoading => _watchProjects.isLoading;

  /// Check if blogs are loading
  bool get isBlogsLoading => _watchBlogs.isLoading;

  /// Dashboard is loading if ANY provider is loading
  bool get isDashboardLoading => isProjectsLoading || isBlogsLoading;

  // ==================== ERROR STATES ====================
  /// Check if projects have error
  bool get hasProjectsError => _watchProjects.hasError;

  /// Check if blogs have error
  bool get hasBlogsError => _watchBlogs.hasError;

  /// Get project error message
  String? get projectsErrorMessage => _watchProjects.errorMessage;

  /// Get blog error message
  String? get blogsErrorMessage => _watchBlogs.errorMessage;

  // ==================== EMPTY STATES ====================
  /// Check if no projects exist
  bool get hasNoProjects => _watchProjects.allProjects.isEmpty;

  /// Check if no blogs exist
  bool get hasNoBlogs => _watchBlogs.allPosts.isEmpty;

  // ==================== ACTIONS ====================
  /// Refresh dashboard data
  Future<void> refresh() async {
    await Future.wait([_projectProvider.refresh(), _blogProvider.refresh()]);
  }
}
