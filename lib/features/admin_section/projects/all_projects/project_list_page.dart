import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../shared/admin_layout.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';
import '../../../../utility/responsive/responsive_helper.dart';
import '../../../../common_function/widgets/custom_button.dart';
import '../../../../common_function/state_widgets/state_widgets.dart';
import '../../../portfolio/providers/project_provider.dart';
import '../../../../common_function/state_widgets/state_builder.dart';
import '../../../../data_layer/domain/entities/portfolio/project.dart';
import 'package:portfolio/features/admin_section/projects/all_projects/widgets/project_filters.dart';
import 'package:portfolio/features/admin_section/projects/all_projects/widgets/project_data_table.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  String _statusFilter = 'all'; // all, published, draft
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final projectProvider = context.watch<ProjectProvider>();

    return AdminLayout(
      title: 'Projects',
      actions: [
        CustomButton(
          width: context.isMobile ? null : 180,
          height: 40,
          tittleText: 'Create New',
          icon: Icons.add_rounded,
          onPressed: () => context.go('/admin/projects/create'),
        ),
      ],
      child: SingleChildScrollView(
        padding: EdgeInsets.all(s.paddingLg),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filters
                ProjectFilters(
                  statusFilter: _statusFilter,
                  searchQuery: _searchQuery,
                  onStatusChanged: (value) => setState(() => _statusFilter = value),
                  onSearchChanged: (value) => setState(() => _searchQuery = value),
                ),
                SizedBox(height: s.spaceBtwItems),

                // Projects Table/List
                DStateBuilder<List<Project>>(
                  state: projectProvider.projectsState,
                  onLoading: () => _buildLoadingState(),
                  onError: (msg) => _buildErrorState(msg),
                  onEmpty: () => _buildEmptyState(),
                  onSuccess: (projects) {
                    final filteredProjects = _filterProjects(projects);

                    if (filteredProjects.isEmpty) {
                      return _buildNoResultsState();
                    }

                    return ProjectDataTable(
                      projects: filteredProjects,
                      onEdit: (project) => _handleEdit(project),
                      onDelete: (project) => _handleDelete(project),
                      onView: (project) => _handleView(project),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Filter projects based on status and search
  List<Project> _filterProjects(List<Project> projects) {
    var filtered = projects;

    // Status filter
    if (_statusFilter == 'published') {
      filtered = filtered.where((p) => p.isPublished).toList();
    } else if (_statusFilter == 'draft') {
      filtered = filtered.where((p) => !p.isPublished).toList();
    }

    // Search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((p) {
        return p.title.toLowerCase().contains(query) ||
            p.category.toLowerCase().contains(query) ||
            p.tagline.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  /// Handle Edit
  void _handleEdit(Project project) {
    context.go('/admin/projects/edit/${project.id}');
  }

  /// Handle Delete
  void _handleDelete(Project project) {
    showDialog(context: context, builder: (context) => _buildDeleteDialog(project));
  }

  /// Handle View
  void _handleView(Project project) {
    context.go('/portfolio/${project.id}');
  }

  /// Delete Confirmation Dialog
  Widget _buildDeleteDialog(Project project) {
    final s = context.sizes;

    return AlertDialog(
      backgroundColor: DColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusLg)),
      title: Text(
        'Delete Project',
        style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to delete this project?',
            style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
          ),
          SizedBox(height: s.paddingMd),
          Container(
            padding: EdgeInsets.all(s.paddingMd),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_rounded, color: Colors.red.shade400, size: 20),
                SizedBox(width: s.paddingSm),
                Expanded(
                  child: Text(
                    'This action cannot be undone.',
                    style: context.fonts.bodySmall.rubik(color: Colors.red.shade700),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: s.paddingSm),
          Text(
            'Project: ${project.title}',
            style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary)),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Call delete API
            Navigator.pop(context);
            _showDeleteSuccessSnackbar();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
          ),
          child: Text('Delete', style: context.fonts.bodyMedium.rubik()),
        ),
      ],
    );
  }

  /// Loading State
  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(60.0),
        child: DLoadingWidget(message: 'Loading projects...'),
      ),
    );
  }

  /// Error State
  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60.0),
        child: DErrorWidget(
          message: message,
          onRetry: () {
            context.read<ProjectProvider>().refresh();
          },
        ),
      ),
    );
  }

  /// Empty State
  Widget _buildEmptyState() {
    final s = context.sizes;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(s.paddingXl * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline_rounded,
              size: 80,
              color: DColors.textSecondary.withAlpha((255 * 0.5).round()),
            ),
            SizedBox(height: s.paddingLg),
            Text(
              'No Projects Yet',
              style: context.fonts.titleLarge.rajdhani(
                fontWeight: FontWeight.bold,
                color: DColors.textPrimary,
              ),
            ),
            SizedBox(height: s.paddingSm),
            Text(
              'Create your first project to get started',
              style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
            ),
            SizedBox(height: s.paddingLg),
            CustomButton(
              width: 200,
              height: 48,
              tittleText: 'Create Project',
              icon: Icons.add_rounded,
              onPressed: () => context.go('/admin/projects/create'),
            ),
          ],
        ),
      ),
    );
  }

  /// No Results State
  Widget _buildNoResultsState() {
    final s = context.sizes;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(s.paddingXl * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80,
              color: DColors.textSecondary.withAlpha((255 * 0.5).round()),
            ),
            SizedBox(height: s.paddingLg),
            Text(
              'No Projects Found',
              style: context.fonts.titleLarge.rajdhani(
                fontWeight: FontWeight.bold,
                color: DColors.textPrimary,
              ),
            ),
            SizedBox(height: s.paddingSm),
            Text(
              'Try adjusting your filters or search query',
              style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
            ),
            SizedBox(height: s.paddingLg),
            CustomButton(
              width: 200,
              height: 48,
              tittleText: 'Clear Filters',
              icon: Icons.clear_rounded,
              isPrimary: false,
              onPressed: () {
                setState(() {
                  _statusFilter = 'all';
                  _searchQuery = '';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Success Snackbar
  void _showDeleteSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Project deleted successfully'),
        backgroundColor: Colors.green.shade400,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
