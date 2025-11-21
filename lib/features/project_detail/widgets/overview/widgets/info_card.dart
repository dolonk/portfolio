import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoCard({super.key, required this.icon, required this.label, required this.value, this.iconColor});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DColors.cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + Label Row
          Row(
            children: [
              Icon(icon, color: iconColor ?? DColors.primaryButton, size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                label.toUpperCase(),
                style: fonts.labelSmall.rubik(
                  color: DColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: s.paddingSm),

          // Value
          Text(
            value,
            style: fonts.bodyLarge.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
