import 'widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProjectGridSection extends StatelessWidget {
  final String selectedFilter;
  final int displayedCount;

  const ProjectGridSection({super.key, required this.selectedFilter, required this.displayedCount});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final filteredProjects = _getFilteredProjects();
    final visibleProjects = filteredProjects.take(displayedCount).toList();

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: _buildProjectGrid(context, visibleProjects, s),
    );
  }

  /// Filter projects based on the selected category
  List<ProjectModel> _getFilteredProjects() {
    final allProjects = ProjectModel.getAllProjects();
    if (selectedFilter == 'All') return allProjects;
    return allProjects.where((project) => project.category == selectedFilter).toList();
  }

  /// Project Grid Layout with Staggered Animations
  Widget _buildProjectGrid(BuildContext context, List<ProjectModel> projects, DSizes s) {
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
