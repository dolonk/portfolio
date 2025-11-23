import 'package:flutter/material.dart';
import '../../../utility/constants/colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../utility/default_sizes/default_sizes.dart';
import '../../../utility/responsive/responsive_helper.dart';

class BlogPageLoading extends StatelessWidget {
  const BlogPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 2);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: s.spaceBtwItems,
        mainAxisSpacing: s.spaceBtwItems,
        childAspectRatio: context.isMobile ? 0.9 : 0.75,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Shimmer(
        duration: const Duration(seconds: 2),
        interval: const Duration(milliseconds: 500),
        color: DColors.cardBorder,
        colorOpacity: 0.3,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: Container(
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(color: DColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image skeleton
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: DColors.cardBorder,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(s.borderRadiusLg),
                    topRight: Radius.circular(s.borderRadiusLg),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(s.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tag skeleton
                    _buildSkeletonBox(60, 20, s),
                    SizedBox(height: s.paddingSm),

                    // Title skeleton
                    _buildSkeletonBox(double.infinity, 24, s),
                    SizedBox(height: s.paddingSm / 2),
                    _buildSkeletonBox(150, 24, s),
                    SizedBox(height: s.paddingSm),

                    // Excerpt skeleton
                    _buildSkeletonBox(double.infinity, 14, s),
                    SizedBox(height: s.paddingSm / 2),
                    _buildSkeletonBox(double.infinity, 14, s),
                    SizedBox(height: s.paddingMd),

                    // Meta info skeleton
                    Row(
                      children: [
                        _buildSkeletonBox(80, 12, s),
                        SizedBox(width: s.paddingSm),
                        _buildSkeletonBox(80, 12, s),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonBox(double width, double height, DSizes s) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: DColors.cardBorder, borderRadius: BorderRadius.circular(s.borderRadiusSm)),
    );
  }
}
