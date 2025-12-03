import 'widgets/post_tags.dart';
import 'widgets/featured_badge.dart';
import 'widgets/post_meta_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../route/route_name.dart';
import '../../../view_models/blog_view_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import '../../../../../../common_function/widgets/custom_button.dart';
import '../../../../../../data_layer/domain/entities/blog/blog_post.dart';

class FeaturedPostSection extends StatefulWidget {
  const FeaturedPostSection({super.key});

  @override
  State<FeaturedPostSection> createState() => _FeaturedPostSectionState();
}

class _FeaturedPostSectionState extends State<FeaturedPostSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final viewModel = BlogViewModel(context);

    // Get featured posts from ViewModel
    final featuredPosts = viewModel.featuredPosts;

    // Show first featured post (or null if empty)
    final post = featuredPosts.isNotEmpty ? featuredPosts.first : null;

    // Hide if no featured post
    if (post == null) return const SizedBox.shrink();

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 900, desktop: 1200),
          ),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: () => context.go('${RouteNames.blog}/${post.id}'),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
                decoration: BoxDecoration(
                  color: DColors.cardBackground,
                  borderRadius: BorderRadius.circular(s.borderRadiusLg),
                  border: Border.all(
                    color: _isHovered ? DColors.primaryButton : DColors.cardBorder,
                    width: _isHovered ? 2 : 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withAlpha((255 * 0.3).round()),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(s.borderRadiusLg),
                  child: context.isMobile
                      ? _buildMobileLayout(context, post, s, () => context.go('${RouteNames.blog}/${post.id}'))
                      : _buildDesktopLayout(context, post, s, () => context.go('${RouteNames.blog}/${post.id}')),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, duration: 600.ms, delay: 200.ms),
        ),
      ),
    );
  }

  /// Desktop/Tablet Layout (Image on Left, Content on Right)
  Widget _buildDesktopLayout(BuildContext context, BlogPost post, DSizes s, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Row(
            children: [
              // Image Section (Left - 45%)
              Expanded(flex: 45, child: _buildImageSection(context, post, s)),

              // Content Section (Right - 55%)
              Expanded(flex: 55, child: _buildContentSection(context, post, s, onPressed)),
            ],
          ),

          // Featured Badge (Top Left)
          Positioned(top: 0, left: 0, child: const FeaturedBadge()),
        ],
      ),
    );
  }

  /// Mobile Layout (Image on Top, Content Below)
  Widget _buildMobileLayout(BuildContext context, BlogPost post, DSizes s, void Function() onPressed) {
    return Column(
      children: [
        // Image Section (Top)
        _buildImageSection(context, post, s),

        // Content Section (Bottom)
        _buildContentSection(context, post, s, onPressed),
      ],
    );
  }

  /// Image Section with Gradient Overlay
  Widget _buildImageSection(BuildContext context, BlogPost post, DSizes s) {
    return SizedBox(
      height: context.responsiveValue(mobile: 250.0, tablet: 350.0, desktop: 400.0),
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              post.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: DColors.cardBorder,
                  child: Icon(Icons.image_not_supported_outlined, size: 80, color: DColors.textSecondary),
                );
              },
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withAlpha((255 * 0.7).round()), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Content Section
  Widget _buildContentSection(BuildContext context, BlogPost post, DSizes s, void Function() onPressed) {
    final fonts = context.fonts;

    return Padding(
      padding: EdgeInsets.all(context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingXl)),
      child: Column(
        crossAxisAlignment: context.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            post.title,
            style: fonts.headlineMedium.rajdhani(
              fontWeight: FontWeight.bold,
              color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
              fontSize: context.responsiveValue(mobile: 22.0, tablet: 26.0, desktop: 30.0),
            ),
            textAlign: context.isMobile ? TextAlign.center : TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: s.paddingMd),

          // Excerpt
          Text(
            post.excerpt,
            style: fonts.bodyMedium.rubik(
              color: DColors.textSecondary,
              height: 1.6,
              fontSize: context.responsiveValue(mobile: 14.0, tablet: 15.0, desktop: 16.0),
            ),
            textAlign: context.isMobile ? TextAlign.center : TextAlign.left,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Meta Info
          PostMetaInfo(author: post.author, date: post.publishedDate, readingTime: post.readingTime),
          SizedBox(height: s.spaceBtwItems),

          // Tags
          PostTags(tags: post.tags),
          SizedBox(height: s.spaceBtwItems),

          // CTA Button
          CustomButton(
            width: context.responsiveValue(mobile: double.infinity, desktop: 200),
            height: 52,
            tittleText: "Read Article",
            icon: Icons.arrow_forward_rounded,
            isPrimary: true,
            iconRight: true,
            backgroundColor: DColors.primaryButton,
            foregroundColor: Colors.white,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
