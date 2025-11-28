import 'package:flutter/material.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatsCard({super.key, required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(s.paddingMd),
            decoration: BoxDecoration(
              color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
              borderRadius: BorderRadius.circular(s.borderRadiusMd),
            ),
            child: Icon(icon, color: DColors.primaryButton, size: 24),
          ),
          SizedBox(height: s.paddingMd),

          // Title
          Text(title, style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary)),
          SizedBox(height: s.paddingSm),

          // Value
          Text(
            value,
            style: context.fonts.displaySmall.rajdhani(
              fontWeight: FontWeight.bold,
              color: DColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
