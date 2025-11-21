import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class TimelineStep extends StatelessWidget {
  final int stepNumber;
  final IconData icon;
  final String title;
  final String description;
  final List<String>? highlights;
  final bool isLast;
  final Color stepColor;

  const TimelineStep({
    super.key,
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
    this.highlights,
    required this.isLast,
    required this.stepColor,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Timeline indicator (circle + line)
          Column(
            children: [
              // Numbered Circle with Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: stepColor.withAlpha((255 * 0.15).round()),
                  shape: BoxShape.circle,
                  border: Border.all(color: stepColor, width: 3),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Icon
                    Icon(icon, color: stepColor, size: 28),
                    // Step number (small, top-right corner)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(color: stepColor, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '$stepNumber',
                            style: fonts.labelSmall.rubik(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Vertical connecting line (if not last step)
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    margin: EdgeInsets.symmetric(vertical: s.paddingSm),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [stepColor, stepColor.withAlpha((255 * 0.2).round())],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: s.paddingLg),

          // Right: Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: fonts.headlineSmall.rajdhani(
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveValue(mobile: 22, tablet: 24, desktop: 26),
                  ),
                ),
                SizedBox(height: s.paddingMd),

                // Description paragraph
                Text(description, style: fonts.bodyMedium.rubik(color: DColors.textSecondary)),

                // Highlights (if provided)
                if (highlights != null && highlights!.isNotEmpty) ...[
                  SizedBox(height: s.spaceBtwItems),
                  _buildHighlights(context, s, fonts),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Key Points Highlights
  Widget _buildHighlights(BuildContext context, DSizes s, AppFonts fonts) {
    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: stepColor.withAlpha((255 * 0.05).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: stepColor.withAlpha((255 * 0.2).round()), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Key Points" label
          Row(
            children: [
              Icon(Icons.check_circle_outline_rounded, color: stepColor, size: 18),
              SizedBox(width: s.paddingSm),
              Text(
                'Key Points',
                style: fonts.labelMedium.rubik(color: stepColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: s.paddingSm),

          // Highlight bullets
          ...highlights!.map((highlight) {
            return Padding(
              padding: EdgeInsets.only(bottom: s.paddingSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_rounded, color: stepColor, size: 18),
                  SizedBox(width: s.paddingSm),
                  Expanded(
                    child: Text(highlight, style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.5)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
