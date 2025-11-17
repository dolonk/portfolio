import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../common_function/style/custom_button.dart';
import 'package:responsive_website/data_layer/model/home/blog_model.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/features/home/widgets/blog_section/widgets/blog_card.dart';

/*class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return SectionContainer(
      padding: EdgeInsets.only(top: s.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Subtitle
          Text('Blog & News', style: fonts.bodyLarge.rubik(color: DColors.primaryButton)),
          SizedBox(height: s.paddingSm),

          // Title
          Text('Blogs About Creativity', style: fonts.displayLarge, textAlign: TextAlign.center),
          SizedBox(height: s.spaceBtwItems - s.paddingMd),

          // Blogs Grid
          _buildBlogsGrid(context),

          // SEE ALL PROJECTS BUTTON
          _buildSeeAllButton(context),
        ],
      ),
    );
  }

  // SEE ALL PROJECTS BUTTON
  Widget _buildSeeAllButton(BuildContext context) {
    return CustomButton(
      width: context.responsiveValue(mobile: double.infinity, tablet: 250.0, desktop: 250.0),
      height: 50,
      tittleText: 'View All Articles',
      onPressed: () {
        context.go('/blog');
        debugPrint('Navigating to blog page');
      },
    );
  }

  // GET BLOGS DATA
  List<BlogModel> _getBlogsData() {
    return [
      BlogModel(
        title: "The Art of Minimalist Web Design",
        category: "Web Design",
        description: "Discover how less can be more. Tips and tricks for creating stunning, minimalist websites.",
        imagePath: "assets/home/projects/project_1.png",
      ),
      BlogModel(
        title: "Mobile App UX: A Deep Dive",
        category: "UX/UI",
        description: "Exploring the key principles of user experience that make mobile apps successful and intuitive.",
        imagePath: "assets/home/projects/project_2.png",
      ),
      BlogModel(
        title: "Branding in the Digital Age",
        category: "Marketing",
        description: "How to build a compelling brand identity that resonates with today's online audience.",
        imagePath: "assets/home/projects/project_3.png",
      ),
    ];
  }

  // BLOGS GRID - Fixed Responsive
  Widget _buildBlogsGrid(BuildContext context) {
    final s = context.sizes;
    final blogs = _getBlogsData();

    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 3);
    final gridSpacing = context.responsiveValue(
      mobile: s.spaceBtwItems,
      tablet: s.spaceBtwSections * 0.75,
      desktop: s.spaceBtwSections,
    );

    // 🔥 OPTIMIZED VERSION:
    return Padding(
      padding: EdgeInsets.all(s.paddingMd),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = (constraints.maxWidth - (gridSpacing * (crossAxisCount - 1))) / crossAxisCount;

          return Wrap(
            spacing: gridSpacing,
            runSpacing: gridSpacing,
            children: blogs.map((blog) {
              return SizedBox(
                width: cardWidth,
                height: cardWidth * 1.22,
                child: BlogCard(blog: blog),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}*/

import 'package:responsive_website/route/route_name.dart';
import 'package:responsive_website/common_function/widgets/section_header.dart';
import 'package:responsive_website/common_function/widgets/responsive_grid.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, top: s.spaceBtwSections),
      child: Column(
        children: [
          //  Using DSectionHeader
          DSectionHeader(
            label: 'BLOG & NEWS',
            title: 'Blogs About Creativity',
            subtitle: 'Latest insights and tutorials on Flutter development',
            alignment: TextAlign.center,
            maxWidth: 700,
          ),
          SizedBox(height: s.spaceBtwItems),

          //Using DResponsiveGrid
          DResponsiveGrid(
            desktopColumns: 3,
            tabletColumns: 2,
            mobileColumns: 1,
            animate: true,
            aspectRatio: 1 / 1.15,
            children: _getBlogsData().map((blog) => BlogCard(blog: blog)).toList(),
          ),
          SizedBox(height: s.spaceBtwItems),

          //  Using new CustomButton
          CustomButton(
            width: context.isMobile ? double.infinity : 250,
            tittleText: 'View All Articles',
            icon: Icons.article_rounded,
            onPressed: () => context.go(RouteNames.blog),
          ),
        ],
      ),
    );
  }

  List<BlogModel> _getBlogsData() {
    return [
      BlogModel(
        title: "The Art of Minimalist Web Design",
        category: "Web Design",
        description: "Discover how less can be more. Tips and tricks for creating stunning, minimalist websites.",
        imagePath: "assets/home/projects/project_1.png",
      ),
      BlogModel(
        title: "Mobile App UX: A Deep Dive",
        category: "UX/UI",
        description: "Exploring the key principles of user experience that make mobile apps successful and intuitive.",
        imagePath: "assets/home/projects/project_2.png",
      ),
      BlogModel(
        title: "Branding in the Digital Age",
        category: "Marketing",
        description: "How to build a compelling brand identity that resonates with today's online audience.",
        imagePath: "assets/home/projects/project_3.png",
      ),
    ];
  }
}
