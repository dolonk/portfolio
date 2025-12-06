import 'package:flutter/material.dart';
import '../../shared/admin_layout.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/snack_bar_toast/snack_bar.dart';
import '../../../../common_function/state_widgets/state_builder.dart';
import '../../../../common_function/state_widgets/state_widgets.dart';
import '../../../public_panel/portfolio/providers/project_provider.dart';
import 'package:portfolio/data_layer/domain/entities/portfolio/project.dart';
import 'package:portfolio/features/admin_panel/projects/project_editor/widgets/project_form.dart';

class ProjectEditorPage extends StatefulWidget {
  final String? projectId;

  const ProjectEditorPage({super.key, this.projectId});

  @override
  State<ProjectEditorPage> createState() => _ProjectEditorPageState();
}

class _ProjectEditorPageState extends State<ProjectEditorPage> {
  @override
  void initState() {
    super.initState();
    if (widget.projectId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ProjectProvider>().fetchProjectById(widget.projectId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final isEditMode = widget.projectId != null;
    final projectProvider = context.watch<ProjectProvider>();

    return AdminLayout(
      title: isEditMode ? 'Edit Project' : 'Create New Project',
      child: isEditMode
          ? _buildEditMode(context, s, projectProvider)
          : _buildForm(context, s),
    );
  }

  /// Edit Mode - Uses Provider's detailState
  Widget _buildEditMode(
    BuildContext context,
    DSizes s,
    ProjectProvider provider,
  ) {
    return DStateBuilder<Project>(
      state: provider.detailState,
      onLoading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(60.0),
          child: DLoadingWidget(message: 'Loading project...'),
        ),
      ),
      onError: (message) => Center(
        child: Padding(
          padding: EdgeInsets.all(60.0),
          child: DErrorWidget(
            message: message,
            onRetry: () {
              provider.fetchProjectById(widget.projectId!);
            },
          ),
        ),
      ),
      onEmpty: () => Center(
        child: Padding(
          padding: EdgeInsets.all(60.0),
          child: DEmptyWidget(
            title: 'Project Not Found',
            subtitle: 'The project you\'re looking for doesn\'t exist',
            icon: Icons.search_off_rounded,
            actionLabel: 'Back to Projects',
            onAction: () => context.go('/admin/projects'),
          ),
        ),
      ),
      onSuccess: (project) => _buildForm(context, s, existingProject: project),
    );
  }

  /// Common Form Builder
  Widget _buildForm(
    BuildContext context,
    DSizes s, {
    Project? existingProject,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(s.paddingLg),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ProjectForm(
            existingProject: existingProject,
            onCancel: () => context.go('/admin/projects'),
            onSave: (project, publish) => _handleSave(project, publish),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave(Project project, bool publish) async {
    final provider = context.read<ProjectProvider>();
    final isEditMode = widget.projectId != null;

    bool success;
    if (isEditMode) {
      success = await provider.updateProject(project);
    } else {
      success = await provider.createProject(project);
    }

    if (success && mounted) {
      DSnackBar.success(
        title: 'Success',
        message: isEditMode
            ? publish
                  ? 'Project updated & published!'
                  : 'Project updated!'
            : publish
            ? 'Project published!'
            : 'Draft saved!',
      );
      // Navigate back
      context.go('/admin/projects');
    } else {
      final errorMsg = provider.errorMessage ?? 'Failed to save project';
      DSnackBar.error(title: 'Error', message: errorMsg);
    }
  }
}
