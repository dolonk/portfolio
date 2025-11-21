import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/data_layer/model/about/skill_model.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class LanguageChip extends StatelessWidget {
  final SkillModel skill;
  final Color accentColor;

  const LanguageChip({super.key, required this.skill, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm + 2),
      decoration: BoxDecoration(
        color: accentColor.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusSm),
        border: Border.all(color: accentColor.withAlpha((255 * 0.4).round())),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            skill.name,
            style: fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: s.paddingSm),
          Text(
            '${skill.percentage.toInt()}%',
            style: fonts.bodySmall.rubik(color: accentColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
