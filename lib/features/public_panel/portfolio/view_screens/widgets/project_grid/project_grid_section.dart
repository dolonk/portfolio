import 'widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/domain/entities/portfolio/project.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProjectGridSection extends StatelessWidget {
  final List<Project> projects;

  const ProjectGridSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: _buildProjectGrid(context, projects, s),
    );
  }

  /// Project Grid Layout with Staggered Animations
  Widget _buildProjectGrid(BuildContext context, List<Project> projects, DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 3);
    final spacing = s.spaceBtwItems;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return AnimationLimiter(
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(projects.length, (index) {
              final project = projects[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 400),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: SizedBox(
                      width: context.isMobile ? double.infinity : cardWidth,
                      child: ProjectCard(project: project),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
