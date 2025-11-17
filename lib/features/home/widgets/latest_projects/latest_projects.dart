import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data_layer/model/portfolio/project_model.dart';
import '../../../../common_function/style/custom_button.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/features/home/widgets/latest_projects/widgets/filter_chip.dart';
import 'package:responsive_website/features/home/widgets/latest_projects/widgets/project_card.dart';

class LatestProjectsSection extends StatefulWidget {
  const LatestProjectsSection({super.key});

  @override
  State<LatestProjectsSection> createState() => _LatestProjectsSectionState();
}

class _LatestProjectsSectionState extends State<LatestProjectsSection> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Android App', 'Ios App', 'Web Development', 'Desktop', 'Mac Os'];

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return SectionContainer(
      padding: EdgeInsets.only(top: s.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SECTION HEADER
          Text('Latest Portfolios', style: fonts.bodyLarge.rubik(color: DColors.primaryButton)),
          SizedBox(height: s.paddingSm),

          Text('Elevating Visions into Masterpieces', style: fonts.displayLarge, textAlign: TextAlign.center),
          SizedBox(height: s.paddingSm),

          // FILTER CHIPS
          _buildFilterChips(context),
          SizedBox(height: s.spaceBtwItems - s.paddingMd),

          // PROJECTS GRID
          _buildProjectsGrid(context),

          // SEE ALL PROJECTS BUTTON
          _buildSeeAllButton(context, s),
        ],
      ),
    );
  }

  // FILTER CHIPS - Responsive
  Widget _buildFilterChips(BuildContext context) {
    final s = context.sizes;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Wrap(
        spacing: context.responsiveValue(
          mobile: s.spaceBtwItems * 0.5,
          tablet: s.spaceBtwItems * 0.75,
          desktop: s.spaceBtwItems,
        ),
        runSpacing: context.responsiveValue(
          mobile: s.spaceBtwItems * 0.5,
          tablet: s.spaceBtwItems * 0.75,
          desktop: s.spaceBtwItems,
        ),
        alignment: WrapAlignment.center,
        children: _filters.map((filter) {
          final isActive = _selectedFilter == filter;
          return DFilterChip(
            label: filter,
            isActive: isActive,
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
            },
          );
        }).toList(),
      ),
    );
  }

  // GET FILTERED PROJECTS
  List<ProjectModel> _getFilteredProjects() {
    final allProjects = _getAllProjects();
    if (_selectedFilter == 'All') return allProjects;
    return allProjects.where((project) => project.category == _selectedFilter).toList();
  }

  // PROJECTS GRID - Fixed Responsive
  Widget _buildProjectsGrid(BuildContext context) {
    final s = context.sizes;
    final projects = _getFilteredProjects();

    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 3);
    final gridSpacing = context.responsiveValue(
      mobile: s.spaceBtwItems,
      tablet: s.spaceBtwSections * 0.75,
      desktop: s.spaceBtwSections,
    );

    return Padding(
      padding: EdgeInsets.all(s.paddingMd),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = (constraints.maxWidth - (gridSpacing * (crossAxisCount - 1))) / crossAxisCount;

          return Wrap(
            spacing: gridSpacing,
            runSpacing: gridSpacing,
            children: projects.map((project) {
              return SizedBox(
                width: cardWidth,
                height: cardWidth * 1.15,
                child: ProjectCard(project: project),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // SEE ALL PROJECTS BUTTON
  Widget _buildSeeAllButton(BuildContext context, DSizes s) {
    return CustomButton(
      width: context.responsiveValue(mobile: double.infinity, tablet: 250.0, desktop: 250.0),
      height: 50,
      tittleText: 'See All Projects',
      onPressed: () {
        context.go('/portfolio');
        debugPrint('Navigating to portfolio page');
      },
    );
  }

  // PROJECT DATA (Sample - 6 Projects)
  List<ProjectModel> _getAllProjects() {
    return [
      ProjectModel(
        title: "Fashion Portfolio Website",
        category: "Web Development",
        description: "A sleek and modern portfolio website tailored for a fashion model showcasing creativity.",
        imagePath: "assets/home/projects/project_1.png",
      ),
      ProjectModel(
        title: "E-Commerce Mobile App",
        category: "Android App",
        description: "Full-featured shopping app with payment integration and real-time tracking capabilities.",
        imagePath: "assets/home/projects/project_2.png",
      ),
      ProjectModel(
        title: "Restaurant Booking System",
        category: "Web Development",
        description: "Modern restaurant booking platform with table management and customer reviews system.",
        imagePath: "assets/home/projects/project_3.png",
      ),
      ProjectModel(
        title: "Fitness Tracking App",
        category: "Ios App",
        description: "Health and fitness app with workout plans, calorie tracking, and progress analytics.",
        imagePath: "assets/home/projects/project_4.png",
      ),
      ProjectModel(
        title: "Brand Identity Design",
        category: "Desktop",
        description: "Complete brand identity package including logo, color palette, and marketing materials.",
        imagePath: "assets/home/projects/project_5.png",
      ),
      ProjectModel(
        title: "Travel Vlog Edit",
        category: "Mac Os",
        description: "Cinematic travel video with smooth transitions, color grading, and motion graphics.",
        imagePath: "assets/home/projects/project_6.png",
      ),
    ];
  }
}
