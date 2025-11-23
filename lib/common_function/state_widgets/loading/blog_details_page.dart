import 'package:flutter/material.dart';
import '../../../utility/constants/colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../utility/default_sizes/default_sizes.dart';
import '../../../utility/responsive/responsive_helper.dart';

class BlogDetailPageLoading extends StatelessWidget {
  const BlogDetailPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Skeleton
          _buildHeroSkeleton(context, s),

          // Content Skeleton
          _buildContentSkeleton(context, s),
        ],
      ),
    );
  }

  /// Hero Section Skeleton
  Widget _buildHeroSkeleton(BuildContext context, DSizes s) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(milliseconds: 500),
      color: DColors.cardBorder,
      colorOpacity: 0.3,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Container(
        height: context.responsiveValue(mobile: 300.0, tablet: 400.0, desktop: 500.0),
        width: double.infinity,
        color: DColors.cardBorder,
        child: Padding(
          padding: EdgeInsets.all(s.paddingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Category badge skeleton
              _buildSkeletonBox(80, 28, s),
              SizedBox(height: s.paddingMd),

              // Title skeleton
              _buildSkeletonBox(400, 36, s),
              SizedBox(height: s.paddingSm),
              _buildSkeletonBox(300, 36, s),
              SizedBox(height: s.paddingMd),

              // Meta info skeleton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSkeletonBox(100, 16, s),
                  SizedBox(width: s.paddingMd),
                  _buildSkeletonBox(100, 16, s),
                  SizedBox(width: s.paddingMd),
                  _buildSkeletonBox(80, 16, s),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Content Section Skeleton
  Widget _buildContentSkeleton(BuildContext context, DSizes s) {
    return Padding(
      padding: EdgeInsets.all(s.paddingLg),
      child: context.isMobile ? _buildMobileContentSkeleton(context, s) : _buildDesktopContentSkeleton(context, s),
    );
  }

  /// Desktop Content Skeleton (with sidebar)
  Widget _buildDesktopContentSkeleton(BuildContext context, DSizes s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Content (70%)
        Expanded(
          flex: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author info skeleton
              _buildAuthorSkeleton(s),
              SizedBox(height: s.spaceBtwSections),

              // Article content skeleton
              ..._buildArticleParagraphsSkeletons(context, s, 5),
            ],
          ),
        ),

        SizedBox(width: s.spaceBtwSections),

        // Sidebar (30%)
        Expanded(
          flex: 30,
          child: Column(
            children: [
              // TOC skeleton
              _buildTocSkeleton(s),
              SizedBox(height: s.spaceBtwItems),

              // Related posts skeleton
              _buildRelatedPostsSkeleton(s),
            ],
          ),
        ),
      ],
    );
  }

  /// Mobile Content Skeleton
  Widget _buildMobileContentSkeleton(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Author info skeleton
        _buildAuthorSkeleton(s),
        SizedBox(height: s.spaceBtwSections),

        // Article content skeleton
        ..._buildArticleParagraphsSkeletons(context, s, 4),
      ],
    );
  }

  /// Author Section Skeleton
  Widget _buildAuthorSkeleton(DSizes s) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: DColors.cardBorder),
        ),
        SizedBox(width: s.paddingMd),

        // Author name & bio
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkeletonBox(150, 18, s),
              SizedBox(height: s.paddingSm / 2),
              _buildSkeletonBox(200, 14, s),
            ],
          ),
        ),
      ],
    );
  }

  /// Article Paragraphs Skeleton
  List<Widget> _buildArticleParagraphsSkeletons(BuildContext context, DSizes s, int count) {
    return List.generate(count, (index) {
      return Padding(
        padding: EdgeInsets.only(bottom: s.paddingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading skeleton (alternate)
            if (index % 2 == 0) ...[_buildSkeletonBox(250, 24, s), SizedBox(height: s.paddingMd)],

            // Paragraph lines
            _buildSkeletonLine(s),
            SizedBox(height: s.paddingSm / 2),
            _buildSkeletonLine(s),
            SizedBox(height: s.paddingSm / 2),
            _buildSkeletonLine(s),
            SizedBox(height: s.paddingSm / 2),
            _buildSkeletonBox(context.responsiveValue(mobile: 200.0, tablet: 300.0, desktop: 400.0), 16, s),
          ],
        ),
      );
    });
  }

  /// TOC Skeleton
  Widget _buildTocSkeleton(DSizes s) {
    return _buildSkeletonContainer(
      s,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonBox(150, 20, s),
          SizedBox(height: s.paddingMd),
          ...List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: s.paddingSm),
              child: _buildSkeletonBox(180 - (index * 10).toDouble(), 14, s),
            );
          }),
        ],
      ),
    );
  }

  /// Related Posts Skeleton
  Widget _buildRelatedPostsSkeleton(DSizes s) {
    return _buildSkeletonContainer(
      s,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonBox(120, 20, s),
          SizedBox(height: s.paddingMd),
          ...List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: s.paddingMd),
              child: Row(
                children: [
                  // Thumbnail
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(s.borderRadiusSm),
                      color: DColors.cardBorder,
                    ),
                  ),
                  SizedBox(width: s.paddingSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSkeletonLine(s),
                        SizedBox(height: s.paddingSm / 2),
                        _buildSkeletonBox(80, 12, s),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// ==================== HELPER METHODS ====================

  /// Skeleton Box Helper
  Widget _buildSkeletonBox(double width, double height, DSizes s) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(s.borderRadiusSm), color: DColors.cardBorder),
    );
  }

  /// Skeleton Line Helper
  Widget _buildSkeletonLine(DSizes s) {
    return Container(
      width: double.infinity,
      height: 16,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(s.borderRadiusSm), color: DColors.cardBorder),
    );
  }

  /// Skeleton Container Helper
  Widget _buildSkeletonContainer(DSizes s, {required Widget child}) {
    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: child,
    );
  }
}
