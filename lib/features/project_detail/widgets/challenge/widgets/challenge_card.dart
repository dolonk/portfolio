import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class ChallengeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color iconColor;

  const ChallengeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingXl),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DColors.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha((255 * 0.05).round()), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with Colored Background
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconColor.withAlpha((255 * 0.15).round()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Icon(icon, color: iconColor, size: 28)),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Title
          Text(title, style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold)),
          SizedBox(height: s.paddingMd),

          // Content
          Text(
            content,
            style: fonts.bodyMedium.rubik(
              color: DColors.textSecondary,
              height: 1.7,
              fontSize: context.responsiveValue(mobile: 14, tablet: 15, desktop: 16),
            ),
          ),
        ],
      ),
    );
  }
}
