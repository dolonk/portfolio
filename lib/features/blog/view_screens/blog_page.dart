import 'package:flutter/material.dart';
import 'widgets/blog_grid/blog_grid_section.dart';
import 'widgets/error_section/blog_filter_chips.dart';
import 'widgets/hero_section/blog_hero_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'widgets/featured_post/featured_post_section.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';
import '../view_models/blog_view_model.dart';
import 'widgets/hero_section/widgets/blog_search_bar.dart';

/*class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: DColors.background,
      child: Column(
        children: [
          // Hero Section
          BlogHeroSection(onSearch: (query) => print('Searching: $query')),

          // Featured Post Section
          FeaturedPostSection(),

          // Blog Grid + Sidebar
          const BlogGridSection(),
        ],
      ),
    );
  }
}*/

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create ViewModel
    final viewModel = BlogViewModel(context);

    return BaseScreen(
      backgroundColor: DColors.background,
      child: RefreshIndicator(
        onRefresh: () => viewModel.refresh(),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              if (notification.metrics.pixels >= notification.metrics.maxScrollExtent * 0.8) {
                viewModel.loadMore();
              }
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section
                const BlogHeroSection(),

                // Featured Post Section
                 //FeaturedPostSection(),

                // Filter Chips (Tags)
                //const BlogFilterChips(),

                const BlogGridSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*  /// Build content based on state
  Widget _buildContent(BuildContext context, BlogViewModel viewModel) {
    // Loading State (First time)
    if (viewModel.isLoading && viewModel.allPosts.isEmpty) {
      return const BlogLoadingSkeleton();
    }

    // Error State
    if (viewModel.hasError) {
      return BlogErrorState(
        message: viewModel.errorMessage ?? 'Failed to load posts',
        onRetry: () => viewModel.fetchAllPosts(),
      );
    }

    // Empty State
    if (viewModel.isEmpty) {
      return const BlogEmptyState();
    }

    // Success State - Show Posts
    return BlogGridSection(
      posts: viewModel.displayPosts,
      isLoadingMore: viewModel.isLoading,
      hasMore: viewModel.hasMore,
    );
  }*/
}
