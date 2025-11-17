import 'package:flutter/material.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'widgets/load_more/load_more_section.dart';
import 'widgets/hero/portfolio_hero_section.dart';
import 'widgets/filter_bar/filter_bar_section.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import '../../common_function/base_screen/footer/custom_footer.dart';
import 'package:responsive_website/data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/common_function/base_screen/base_screen.dart';
import 'package:responsive_website/features/portfolio/widgets/project_grid/project_grid_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String _selectedFilter = 'All';
  int _displayedCount = 6;
  bool _isLoading = false;

  /// Get total count of filtered projects
  int _getTotalProjectCount() {
    final allProjects = ProjectModel.getAllProjects();
    if (_selectedFilter == 'All') return allProjects.length;
    return allProjects.where((project) => project.category == _selectedFilter).length;
  }

  /// Handle Load More action
  void _handleLoadMore() {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _displayedCount += 6;
          _isLoading = false;
        });
      }
    });
  }

  /// Handle filter change - reset displayed count
  void _handleFilterChange(String filter) {
    setState(() {
      _selectedFilter = filter;
      _displayedCount = 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = _getTotalProjectCount();
    final filterBar = FilterBarSection(selectedFilter: _selectedFilter, onFilterChanged: _handleFilterChange);

    return BaseScreen(
      useCustomScrollView: true,
      backgroundColor: DColors.background,
      child: CustomScrollView(
        slivers: [
          // Hero Section
          const SliverToBoxAdapter(child: PortfolioHeroSection()),

          // Sticky Filter Bar
          SliverPinnedHeader(
            child: Container(
              decoration: BoxDecoration(
                color: DColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((255 * 0.15).round()),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: filterBar,
            ),
          ),

          // Project Grid
          SliverToBoxAdapter(
            child: ProjectGridSection(selectedFilter: _selectedFilter, displayedCount: _displayedCount),
          ),

          // Load More
          SliverToBoxAdapter(
            child: LoadMoreSection(
              displayedCount: _displayedCount,
              totalCount: totalCount,
              isLoading: _isLoading,
              onLoadMore: _handleLoadMore,
            ),
          ),

          SliverToBoxAdapter(child: const FooterSection()),
        ],
      ),
    );
  }
}
