import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';

class BlogLoadingSkeleton extends StatelessWidget {
  const BlogLoadingSkeleton({super.key});

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
      itemCount: 6, // Show 6 skeleton cards
      itemBuilder: (context, index) => _SkeletonCard(),
    );
  }
}

class _SkeletonCard extends StatefulWidget {
  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)..repeat();
    _animation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: DColors.cardBorder,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(s.borderRadiusLg),
                    topRight: Radius.circular(s.borderRadiusLg),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      DColors.cardBorder,
                      DColors.cardBorder.withAlpha((255 * 0.5).round()),
                      DColors.cardBorder,
                    ],
                    stops: [
                      (_animation.value - 1).clamp(0.0, 1.0),
                      _animation.value.clamp(0.0, 1.0),
                      (_animation.value + 1).clamp(0.0, 1.0),
                    ],
                  ),
                ),
              );
            },
          ),

          Padding(
            padding: EdgeInsets.all(s.paddingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag skeleton
                _buildShimmerBox(width: 60, height: 20, s: s),
                SizedBox(height: s.paddingSm),

                // Title skeleton
                _buildShimmerBox(width: double.infinity, height: 24, s: s),
                SizedBox(height: s.paddingSm / 2),
                _buildShimmerBox(width: 150, height: 24, s: s),
                SizedBox(height: s.paddingSm),

                // Excerpt skeleton
                _buildShimmerBox(width: double.infinity, height: 14, s: s),
                SizedBox(height: s.paddingSm / 2),
                _buildShimmerBox(width: double.infinity, height: 14, s: s),
                SizedBox(height: s.paddingMd),

                // Meta info skeleton
                Row(
                  children: [
                    _buildShimmerBox(width: 80, height: 12, s: s),
                    SizedBox(width: s.paddingSm),
                    _buildShimmerBox(width: 80, height: 12, s: s),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height, required DSizes s}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                DColors.cardBorder,
                DColors.cardBorder.withAlpha((255 * 0.5).round()),
                DColors.cardBorder,
              ],
              stops: [
                (_animation.value - 1).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 1).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
