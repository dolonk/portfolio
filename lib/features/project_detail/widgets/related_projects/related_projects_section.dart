import 'widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_website/route/route_name.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class RelatedProjectsSection extends StatelessWidget {
  final ProjectModel project;

  const RelatedProjectsSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Heading
            _buildSectionHeading(context, s),
            SizedBox(height: s.spaceBtwItems),

            // Related Projects Grid
            _buildProjectsGrid(context, s),
            SizedBox(height: s.spaceBtwItems),

            // "View More Work" Button
            _buildViewMoreButton(context, s),
          ],
        ),
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Related Projects', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text('More projects you might be interested in', style: fonts.bodyLarge.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  /// Related Projects Grid with Wrap Layout
  Widget _buildProjectsGrid(BuildContext context, DSizes s) {
    final relatedProjects = _getRelatedProjects();

    final cardWidth = context.responsiveValue(
      mobile: double.infinity,
      tablet: (900 - s.spaceBtwItems) / 2,
      desktop: (1000 - s.spaceBtwItems * 2) / 3,
    );

    return Wrap(
      spacing: s.spaceBtwItems,
      runSpacing: s.spaceBtwItems,
      children: relatedProjects.map((relatedProject) {
        return SizedBox(
          width: context.isMobile ? double.infinity : cardWidth,
          child: RelatedProjectCard(project: relatedProject),
        );
      }).toList(),
    );
  }

  /// "View More Work" Button
  Widget _buildViewMoreButton(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Center(
      child: SizedBox(
        width: context.responsiveValue(mobile: double.infinity, tablet: 300, desktop: 300),
        child: ElevatedButton(
          onPressed: () => context.go(RouteNames.portfolio),
          style: ElevatedButton.styleFrom(
            backgroundColor: DColors.primaryButton,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: s.paddingXl, vertical: s.paddingMd),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View More Work', style: fonts.labelLarge.rubik(fontWeight: FontWeight.bold)),
              SizedBox(width: s.paddingMd),
              Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Get Related Projects (By Category)
  List<ProjectModel> _getRelatedProjects() {
    // Get all projects
    final allProjects = ProjectModel.getAllProjects();

    // Filter by same category, exclude current project
    final relatedProjects = allProjects.where((p) => p.category == project.category && p.id != project.id).toList();

    // Return max 3 projects
    return relatedProjects.take(3).toList();
  }
}
