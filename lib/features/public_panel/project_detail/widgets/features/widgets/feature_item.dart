import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Padding(
      padding: EdgeInsets.only(bottom: s.spaceBtwItems),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon in Colored Circle
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: iconColor.withAlpha((255 * 0.15).round()), shape: BoxShape.circle),
            child: Center(child: FaIcon(icon, size: 24, color: iconColor)),
          ),
          SizedBox(width: s.paddingLg),

          // Title + Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(title, style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),

                // Description (1 line)
                Text(
                  description,
                  style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
