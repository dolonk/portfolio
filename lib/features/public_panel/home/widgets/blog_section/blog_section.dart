import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route/route_name.dart';
import '../../../../../common_function/widgets/custom_button.dart';
import 'package:portfolio/data_layer/model/home/blog_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';
import 'package:portfolio/common_function/widgets/responsive_grid.dart';
import 'package:portfolio/features/public_panel/home/widgets/blog_section/widgets/blog_card.dart';

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
