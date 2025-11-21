import 'dart:ui';
import 'widgets/post_meta.dart';
import 'widgets/share_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/data_layer/model/blog/blog_post_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class PostHeaderSection extends StatelessWidget {
  final BlogPostModel post;

  const PostHeaderSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.all(s.paddingMd),
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 800),
          ),
          child: Column(
            children: [
              // Title with Gradient
              _buildTitle(context, s),
              SizedBox(height: s.spaceBtwItems),

              // Author Avatar + Name
              _buildAuthorInfo(context, s),
              SizedBox(height: s.paddingMd),

              // Meta Information
              PostMeta(
                author: post.author,
                publishedDate: post.publishedDate,
                readingTime: post.readingTime,
                viewCount: post.viewCount,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Share Buttons
              ShareButtons(postTitle: post.title, postUrl: 'https://yourwebsite.com/blog/${post.id}'),
            ],
          ),
        ),
      ),
    );
  }

  /// Title with Gradient Effect
  Widget _buildTitle(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [DColors.textPrimary, DColors.primaryButton, Color(0xFF8B5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        post.title,
        style: fonts.displayMedium.rajdhani(
          fontSize: context.responsiveValue(mobile: 28.0, tablet: 36.0, desktop: 42.0),
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, duration: 600.ms, delay: 200.ms);
  }

  /// Author Info with Avatar
  Widget _buildAuthorInfo(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Author Avatar
            Container(
              width: context.responsiveValue(mobile: 40.0, tablet: 48.0, desktop: 56.0),
              height: context.responsiveValue(mobile: 40.0, tablet: 48.0, desktop: 56.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: DColors.primaryButton, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  post.authorImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: DColors.cardBackground,
                      child: Icon(Icons.person_rounded, color: DColors.textSecondary, size: 24),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: s.paddingMd),

            // Author Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.author,
                  style: fonts.titleMedium.rajdhani(
                    fontWeight: FontWeight.bold,
                    color: DColors.textPrimary,
                    fontSize: context.responsiveValue(mobile: 16.0, tablet: 18.0, desktop: 20.0),
                  ),
                ),
                Text(
                  'Flutter Developer',
                  style: fonts.bodySmall.rubik(
                    color: DColors.textSecondary,
                    fontSize: context.responsiveValue(mobile: 12.0, tablet: 13.0, desktop: 14.0),
                  ),
                ),
              ],
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .scale(begin: const Offset(0.9, 0.9), duration: 600.ms, delay: 300.ms);
  }
}
