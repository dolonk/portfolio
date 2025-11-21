import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class FeaturedBadge extends StatelessWidget {
  const FeaturedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
          padding: EdgeInsets.all(s.paddingMd),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [DColors.primaryButton, Color(0xFF8B5CF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            boxShadow: [
              BoxShadow(
                color: DColors.primaryButton.withAlpha((255 * 0.4).round()),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, color: DColors.textPrimary, size: 18),
              SizedBox(width: s.paddingXs),
              Text(
                'FEATURED',
                style: fonts.labelMedium.rubik(
                  color: DColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(duration: 2000.ms, color: Colors.white.withAlpha((255 * 0.3).round()))
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 1000.ms);
  }
}
