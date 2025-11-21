import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class TechBadge extends StatelessWidget {
  final String techName;

  const TechBadge({super.key, required this.techName});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round()), width: 1),
      ),
      child: Text(
        techName,
        style: fonts.labelSmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w500),
      ),
    );
  }
}
