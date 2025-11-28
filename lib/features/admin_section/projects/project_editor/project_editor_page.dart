import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/admin_layout.dart';
import '../../../../utility/default_sizes/default_sizes.dart';
import '../../../../data_layer/domain/entities/portfolio/project.dart';
import 'package:portfolio/features/admin_section/projects/project_editor/widgets/project_form.dart';

class ProjectEditorPage extends StatefulWidget {
  final String? projectId; // null = create mode, non-null = edit mode

  const ProjectEditorPage({super.key, this.projectId});

  @override
  State<ProjectEditorPage> createState() => _ProjectEditorPageState();
}

class _ProjectEditorPageState extends State<ProjectEditorPage> {
  bool _isLoading = false;
  Project? _existingProject;

  @override
  void initState() {
    super.initState();
    if (widget.projectId != null) {
      _loadProject();
    }
  }

  Future<void> _loadProject() async {
    setState(() => _isLoading = true);

    // TODO: Load project from provider by ID
    // For now, simulating delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final isEditMode = widget.projectId != null;

    return AdminLayout(
      title: isEditMode ? 'Edit Project' : 'Create New Project',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(s.paddingLg),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: ProjectForm(
                    existingProject: _existingProject,
                    onCancel: () => context.go('/admin/projects'),
                    onSave: (project, publish) => _handleSave(project, publish),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _handleSave(Project project, bool publish) async {
    // TODO: Call provider to save/update project

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(publish ? 'Project published!' : 'Draft saved!'),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigate back
      context.go('/admin/projects');
    }
  }
}
