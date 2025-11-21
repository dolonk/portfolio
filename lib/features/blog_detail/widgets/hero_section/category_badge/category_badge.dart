import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class CategoryBadge extends StatelessWidget {
  final String category;

  const CategoryBadge({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [DColors.primaryButton, Color(0xFFD4003D)],
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
      child: Text(
        category.toUpperCase(),
        style: fonts.labelMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 300.ms).slideX(begin: -0.1, duration: 600.ms, delay: 300.ms);
  }
}
