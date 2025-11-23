import 'package:flutter/material.dart';
import '../view_models/blog_view_model.dart';
import 'widgets/blog_grid/blog_grid_section.dart';
import 'widgets/blog_filter_chips/blog_filter_chips.dart';
import 'widgets/hero_section/blog_hero_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'widgets/featured_post/featured_post_section.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';

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
                FeaturedPostSection(),

                // Filter Chips (Tags)
                const BlogFilterChips(),

                const BlogGridSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
