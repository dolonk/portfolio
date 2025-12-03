import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../view_models/project_view_model.dart';
import 'widgets/hero/portfolio_hero_section.dart';
import 'widgets/load_more/load_more_section.dart';
import 'widgets/filter_bar/filter_bar_section.dart';
import 'widgets/project_grid/project_grid_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import '../../../../common_function/state_widgets/state_builder.dart';
import 'package:portfolio/data_layer/domain/entities/portfolio/project.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';
import '../../../../common_function/state_widgets/error/error_state.dart';
import '../../../../common_function/base_screen/footer/custom_footer.dart';
import 'package:portfolio/common_function/state_widgets/loading/blog_page.dart';
import '../../../../common_function/state_widgets/data_not_found/not_found_state.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late final ProjectViewModel vm = ProjectViewModel(context);

  void _handleFilterChange(String filter) {
    if (filter == 'All') {
      vm.clearFilters();
    } else {
      vm.filterByCategory(filter);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterBar = FilterBarSection(
      selectedFilter: vm.selectedCategory ?? 'All',
      onFilterChanged: _handleFilterChange,
    );

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
            child: DStateBuilder<List<Project>>(
              state: vm.projectsState,
              onLoading: () => BlogPageLoading(),
              onError: (message) => ErrorState(message: message, onRetry: () => vm.refresh()),
              onEmpty: () => const DataNotFoundState(),
              onSuccess: (projects) => ProjectGridSection(projects: vm.displayProjects),
            ),
          ),

          // Load More
          SliverToBoxAdapter(
            child: LoadMoreSection(
              isLoading: vm.isLoading,
              displayedCount: vm.displayProjects.length,
              totalCount: vm.filteredProjectsCount,
              onLoadMore: () => vm.loadMore(),
            ),
          ),

          SliverToBoxAdapter(child: const FooterSection()),
        ],
      ),
    );
  }
}
