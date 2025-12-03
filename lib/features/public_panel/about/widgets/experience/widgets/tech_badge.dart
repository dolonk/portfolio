import 'package:flutter/material.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class TechBadge extends StatelessWidget {
  final String tech;
  final Color accentColor;

  const TechBadge({super.key, required this.tech, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm * 0.7),
      decoration: BoxDecoration(
        color: accentColor.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusSm),
        border: Border.all(color: accentColor.withAlpha((255 * 0.3).round()), width: 1),
      ),
      child: Text(
        tech,
        style: fonts.bodySmall.rubik(color: accentColor, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
