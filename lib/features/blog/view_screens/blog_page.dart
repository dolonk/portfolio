import 'package:flutter/material.dart';
import 'widgets/blog_grid/blog_grid_section.dart';
import 'widgets/hero_section/blog_hero_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'widgets/featured_post/featured_post_section.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';

class BlogPage extends StatelessWidget {
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
}
