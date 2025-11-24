import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../route/route_name.dart';
import 'category_badge/category_badge.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/domain/entities/blog/blog_post.dart';
import 'package:portfolio/features/blog_detail/view_screens/widgets/hero_section/post_header/post_header_section.dart';

class BlogDetailHero extends StatelessWidget {
  final BlogPost post;

  const BlogDetailHero({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SizedBox(
      width: double.infinity,
      height: context.responsiveValue(
        mobile: ResponsiveHelper.getHeight(context) * 0.4,
        tablet: ResponsiveHelper.getHeight(context) * 0.28,
        desktop: ResponsiveHelper.getHeight(context) * 0.44,
      ),
      child: Stack(
        children: [
          // Background Image
          _buildHeroImage(context),

          // Post Header Section
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: PostHeaderSection(post: post),
            ),
          ),

          // Back Button (Desktop only)
          context.isDesktop
              ? Positioned(top: 2, left: s.paddingLg, child: _buildBackButton(context, s))
              : const SizedBox.shrink(),

          // Category Badge (Desktop only)
          context.isDesktop
              ? Positioned(
                  bottom: 2,
                  left: s.paddingLg,
                  child: CategoryBadge(category: post.category),
                )
              : const SizedBox.shrink(),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  /// Hero Image with Error Handling and Responsive Height
  Widget _buildHeroImage(BuildContext context) {
    return Image.asset(
      post.imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: DColors.cardBackground,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported_outlined, size: 80, color: DColors.textSecondary),
                SizedBox(height: 16),
                Text('Image not available', style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackButton(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.go(RouteNames.blog);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha((255 * 0.5).round()),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withAlpha((255 * 0.3).round()), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                'Back to Blog',
                style: fonts.labelLarge.rubik(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
