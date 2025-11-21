import 'widgets/popular_tags_widget.dart';
import 'widgets/recent_posts_widget.dart';
import 'widgets/newsletter_widget.dart';
import 'widgets/social_links_widget.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class BlogSidebar extends StatelessWidget {
  const BlogSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Column(
      children: [
        // Newsletter
        const NewsletterWidget(),
        SizedBox(height: s.spaceBtwItems),

        // Recent Posts
        const RecentPostsWidget(),
        SizedBox(height: s.spaceBtwItems),

        // Popular Tags
        const PopularTagsWidget(),
        SizedBox(height: s.spaceBtwItems),

        // Social Links
        const SocialLinksWidget(),
      ],
    );
  }
}
