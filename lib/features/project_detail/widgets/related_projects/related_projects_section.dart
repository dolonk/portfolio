import 'widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route/route_name.dart';
import 'package:portfolio/utility/constants/colors.dart';
import '../../../portfolio/view_models/project_view_model.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import '../../../../common_function/widgets/custom_button.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import '../../../../data_layer/domain/entities/portfolio/project.dart';

class RelatedProjectsSection extends StatelessWidget {
  final Project project;

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
            _buildViewMoreButton(context),
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
    final relatedProjects = _getRelatedProjects(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = context.responsiveValue(
          mobile: double.infinity,
          tablet: (constraints.maxWidth - s.spaceBtwItems) / 2,
          desktop: (1100 - s.spaceBtwItems * 2) / 3,
        );
        return Wrap(
          spacing: s.spaceBtwItems,
          runSpacing: s.spaceBtwItems,
          children: relatedProjects.map((relatedProject) {
            return SizedBox(
              width: context.isMobile ? double.infinity : cardWidth,
              child: RelatedProjectCard(project: project),
            );
          }).toList(),
        );
      },
    );
  }

  /// "View More Work" Button
  Widget _buildViewMoreButton(BuildContext context) {
    return Center(
      child: CustomButton(
        width: context.responsiveValue(mobile: double.infinity, tablet: 300, desktop: 300),
        height: 52,
        tittleText: "View More Work",
        icon: Icons.arrow_forward_rounded,
        isPrimary: true,
        iconRight: true,
        backgroundColor: DColors.primaryButton,
        foregroundColor: Colors.white,
        onPressed: () => context.go(RouteNames.portfolio),
      ),
    );
  }

  /// Get Related Projects (By Category)
  List<Project> _getRelatedProjects(BuildContext context) {
    final vm = ProjectViewModel(context);
    final allProjects = vm.recentProjects;

    final relatedProjects = allProjects
        .where((p) => p.category == project.category && p.id != project.id)
        .take(3)
        .toList();

    return relatedProjects;
  }
}
