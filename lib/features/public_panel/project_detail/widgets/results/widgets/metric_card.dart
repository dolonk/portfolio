import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const MetricCard({super.key, required this.icon, required this.value, required this.label, required this.iconColor});

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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: iconColor.withAlpha((255 * 0.15).round()), shape: BoxShape.circle),
            child: Center(child: Icon(icon, size: 32, color: iconColor)),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Value (Large Number)
          Text(value, style: fonts.displayMedium, textAlign: TextAlign.center),
          SizedBox(height: s.paddingSm),

          // Label
          Text(
            label,
            style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
