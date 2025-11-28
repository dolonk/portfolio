import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';
import '../../../../../data_layer/domain/entities/portfolio/project.dart';

class ProjectDataTable extends StatelessWidget {
  final List<Project> projects;
  final Function(Project) onEdit;
  final Function(Project) onDelete;
  final Function(Project) onView;

  const ProjectDataTable({
    super.key,
    required this.projects,
    required this.onEdit,
    required this.onDelete,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? _buildMobileList(context) : _buildDesktopTable(context);
  }

  /// Desktop Table View
  Widget _buildDesktopTable(BuildContext context) {
    final s = context.sizes;

    return Container(
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        children: [
          // Table Header
          _buildTableHeader(context, s),

          Divider(height: 1, color: DColors.cardBorder),

          // Table Rows
          ...projects.map((project) => _buildTableRow(context, s, project)),
        ],
      ),
    );
  }

  /// Table Header
  Widget _buildTableHeader(BuildContext context, DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      child: Row(
        children: [
          SizedBox(width: 80, child: _buildHeaderCell(context, 'Image')),
          SizedBox(width: s.paddingMd),
          Expanded(flex: 3, child: _buildHeaderCell(context, 'Title')),
          SizedBox(width: s.paddingMd),
          Expanded(flex: 2, child: _buildHeaderCell(context, 'Category')),
          SizedBox(width: s.paddingMd),
          SizedBox(width: 100, child: _buildHeaderCell(context, 'Status')),
          SizedBox(width: s.paddingMd),
          SizedBox(width: 80, child: _buildHeaderCell(context, 'Views')),
          SizedBox(width: s.paddingMd),
          SizedBox(width: 120, child: _buildHeaderCell(context, 'Actions')),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(BuildContext context, String text) {
    return Text(
      text,
      style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textSecondary),
    );
  }

  /// Table Row
  Widget _buildTableRow(BuildContext context, DSizes s, Project project) {
    return Column(
      children: [
        Divider(height: 1, color: DColors.cardBorder),
        Container(
          padding: EdgeInsets.all(s.paddingMd),
          child: Row(
            children: [
              // Thumbnail
              SizedBox(
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.asset(
                      project.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: DColors.background,
                        child: Icon(Icons.image_rounded, color: DColors.textSecondary),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: s.paddingMd),

              // Title
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: context.fonts.bodyMedium.rubik(
                        fontWeight: FontWeight.w600,
                        color: DColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (project.tagline.isNotEmpty)
                      Text(
                        project.tagline,
                        style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              SizedBox(width: s.paddingMd),

              // Category
              Expanded(flex: 2, child: _buildCategoryBadge(context, s, project.category)),
              SizedBox(width: s.paddingMd),

              // Status
              SizedBox(width: 100, child: _buildStatusBadge(context, s, project.isPublished)),
              SizedBox(width: s.paddingMd),

              // Views
              SizedBox(
                width: 80,
                child: Text(
                  '${project.viewCount}',
                  style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                ),
              ),
              SizedBox(width: s.paddingMd),

              // Actions
              SizedBox(width: 120, child: _buildActions(context, s, project)),
            ],
          ),
        ),
      ],
    );
  }

  /// Mobile List View
  Widget _buildMobileList(BuildContext context) {
    final s = context.sizes;

    return Column(
      children: projects.map((project) {
        return Container(
          margin: EdgeInsets.only(bottom: s.paddingMd),
          padding: EdgeInsets.all(s.paddingMd),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(color: DColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image + Title
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(s.borderRadiusSm),
                    child: SizedBox(
                      width: 80,
                      height: 50,
                      child: Image.asset(
                        project.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: DColors.background, child: Icon(Icons.image_rounded, size: 24)),
                      ),
                    ),
                  ),
                  SizedBox(width: s.paddingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: context.fonts.bodyMedium.rubik(
                            fontWeight: FontWeight.w600,
                            color: DColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: s.paddingMd),

              // Category + Status
              Row(
                children: [
                  _buildCategoryBadge(context, s, project.category),
                  SizedBox(width: s.paddingSm),
                  _buildStatusBadge(context, s, project.isPublished),
                  Spacer(),
                  Text(
                    '${project.viewCount} views',
                    style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
                  ),
                ],
              ),
              SizedBox(height: s.paddingMd),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => onView(project),
                      icon: Icon(Icons.visibility_rounded, size: 16),
                      label: Text('View'),
                      style: OutlinedButton.styleFrom(side: BorderSide(color: DColors.cardBorder)),
                    ),
                  ),
                  SizedBox(width: s.paddingSm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => onEdit(project),
                      icon: Icon(Icons.edit_rounded, size: 16),
                      label: Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: DColors.primaryButton),
                        foregroundColor: DColors.primaryButton,
                      ),
                    ),
                  ),
                  SizedBox(width: s.paddingSm),
                  IconButton(
                    onPressed: () => onDelete(project),
                    icon: Icon(Icons.delete_rounded, color: Colors.red.shade400),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Category Badge
  Widget _buildCategoryBadge(BuildContext context, DSizes s, String category) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: 4),
      decoration: BoxDecoration(
        color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusSm),
        border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round())),
      ),
      child: Text(
        category,
        style: context.fonts.labelSmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Status Badge
  Widget _buildStatusBadge(BuildContext context, DSizes s, bool isPublished) {
    final color = isPublished ? Colors.green : Colors.orange;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingXs, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusSm),
        border: Border.all(color: color.withAlpha((255 * 0.3).round())),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isPublished ? Icons.check_circle_rounded : Icons.edit_rounded, size: 12, color: color),
          SizedBox(width: 4),
          Text(
            isPublished ? 'Published' : 'Draft',
            style: context.fonts.labelSmall.rubik(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// Action Buttons
  Widget _buildActions(BuildContext context, DSizes s, Project project) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => onView(project),
          icon: Icon(Icons.visibility_rounded, size: 18),
          tooltip: 'View',
          color: DColors.textSecondary,
        ),
        IconButton(
          onPressed: () => onEdit(project),
          icon: Icon(Icons.edit_rounded, size: 18),
          tooltip: 'Edit',
          color: DColors.primaryButton,
        ),
        IconButton(
          onPressed: () => onDelete(project),
          icon: Icon(Icons.delete_rounded, size: 18),
          tooltip: 'Delete',
          color: Colors.red.shade400,
        ),
      ],
    );
  }
}
