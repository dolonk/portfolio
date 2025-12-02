import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route/route_name.dart';
import '../../../../common_function/widgets/custom_button.dart';
import '../../../../data_layer/domain/entities/portfolio/project.dart';
import '../../../../data_layer/model/portfolio/project_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';
import 'package:portfolio/common_function/widgets/responsive_grid.dart';
import 'package:portfolio/features/home/widgets/latest_projects/widgets/filter_chip.dart';
import 'package:portfolio/features/home/widgets/latest_projects/widgets/project_card.dart';

import '../../../blog/view_models/blog_view_model.dart';
import '../../../portfolio/view_models/project_view_model.dart';

class LatestProjectsSection extends StatefulWidget {
  const LatestProjectsSection({super.key});

  @override
  State<LatestProjectsSection> createState() => _LatestProjectsSectionState();
}

class _LatestProjectsSectionState extends State<LatestProjectsSection> {
  late final ProjectViewModel vm = ProjectViewModel(context);
  String _selectedFilter = 'All';
  //final List<String> _filters = ['All', 'Android App', 'Ios App', 'Web Development', 'Desktop', 'Mac Os'];
  final List<String> _filters = ['All', 'Mobile', 'Web', 'Desktop', 'UI/UX'];

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, top: s.spaceBtwSections),
      child: Column(
        children: [
          // DSectionHeader
          DSectionHeader(
            label: 'PORTFOLIO',
            title: 'Latest Portfolios',
            subtitle: 'Elevating Visions into Reality Through Code',
            alignment: TextAlign.center,
            maxWidth: 700,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Filter Chips (keep as is - already good)
          _buildFilterChips(context),
          SizedBox(height: s.spaceBtwItems),

          // Using DResponsiveGrid
          DResponsiveGrid(
            desktopColumns: 3,
            tabletColumns: 2,
            mobileColumns: 1,
            animate: true,
            aspectRatio: 1 / 1.15,
            children: _getFilteredProjects().map((project) => ProjectCard(project: project)).toList(),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Using new CustomButton
          CustomButton(
            width: context.isMobile ? double.infinity : 250,
            iconRight: true,
            tittleText: 'See All Projects',
            icon: Icons.arrow_forward_rounded,
            onPressed: () => context.go(RouteNames.portfolio),
          ),
        ],
      ),
    );
  }

  List<Project> _getFilteredProjects() {
    final allProjects = vm.fe;
    if (_selectedFilter == 'All') return allProjects;
    return allProjects.where((project) => project.category == _selectedFilter).toList();
  }

  // Filter Chips
  Widget _buildFilterChips(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: _filters.map((filter) {
        final isSelected = filter == _selectedFilter;
        return DFilterChip(
          label: filter,
          isActive: isSelected,
          onTap: () {
            setState(() {
              _selectedFilter = filter;
            });
          },
        );
      }).toList(),
    );
  }

  void _handleFilterChange(ProjectViewModel vm, String filter) {
    if (filter == 'All') {
      vm.clearFilters();
    } else {
      vm.filterByCategory(filter);
    }
  }

  // List<ProjectModel> getAllProjects() {
  //   return Project.getAllProjects().take(6).toList();
  // }
}
