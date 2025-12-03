import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class YearCard extends StatefulWidget {
  final int year;
  final String description;
  final int index;

  const YearCard({super.key, required this.year, required this.description, this.index = 0});

  @override
  State<YearCard> createState() => _YearCardState();
}

class _YearCardState extends State<YearCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedScale(
            duration: 200.ms,
            scale: _isHovered ? 1.02 : 1.0,
            child: Container(
              padding: EdgeInsets.all(
                context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingSm),
              ),
              decoration: BoxDecoration(
                color: DColors.cardBackground,
                borderRadius: BorderRadius.circular(s.borderRadiusLg),
                border: Border.all(color: _isHovered ? DColors.primaryButton : DColors.cardBorder, width: 1.5),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Year
                  Text(
                    widget.year.toString(),
                    style: fonts.titleLarge.rajdhani(color: DColors.primaryButton, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: context.isDesktop ? 4 : s.paddingSm),

                  // Description
                  Flexible(
                    child: Text(
                      widget.description,
                      style: fonts.bodySmall.rubik(color: DColors.textSecondary),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        // Animation chain
        .animate(delay: (200 * widget.index).ms)
        .fadeIn(duration: 600.ms, curve: Curves.easeIn)
        .slide(begin: const Offset(0, 0.3), end: Offset.zero, duration: 650.ms, curve: Curves.easeOutCubic);
  }
}
