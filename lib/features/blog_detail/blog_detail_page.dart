import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import 'widgets/content_section/content_section.dart';
import '../../data_layer/model/blog/blog_post_model.dart';
import 'package:responsive_website/common_function/base_screen/base_screen.dart';
import 'package:responsive_website/features/blog_detail/widgets/comments/comments_section.dart';
import 'package:responsive_website/features/blog_detail/widgets/hero_section/blog_detail_hero.dart';
import 'package:responsive_website/features/blog_detail/widgets/newsletter/newsletter_cta_section.dart';

class BlogDetailPage extends StatelessWidget {
  final String postId;
  const BlogDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final post = BlogPostModel.getPostById(postId);

    return BaseScreen(
      backgroundColor: DColors.background,
      child: Column(
        children: [
          //  Hero + Post Header
          BlogDetailHero(post: post!),

          // Content
          ContentSection(post: post),

          // Comments
          CommentsSection(post: post),

          // Newsletter CTA
          const NewsletterCtaSection(),
        ],
      ),
    );
  }
}
