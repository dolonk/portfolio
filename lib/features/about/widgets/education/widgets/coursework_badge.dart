import 'package:flutter/material.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class CourseworkBadge extends StatelessWidget {
  final String course;
  final Color accentColor;

  const CourseworkBadge({super.key, required this.course, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm * 0.7),
      decoration: BoxDecoration(
        color: accentColor.withAlpha(25),
        borderRadius: BorderRadius.circular(s.borderRadiusSm),
        border: Border.all(color: accentColor.withAlpha(76), width: 1),
      ),
      child: Text(
        course,
        style: fonts.bodySmall.rubik(color: accentColor, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
