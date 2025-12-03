import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/about/achievement_model.dart';
import 'achievement_marker.dart';

class AchievementItem extends StatefulWidget {
  final AchievementModel achievement;
  final bool isLast;
  final int delay;

  const AchievementItem({super.key, required this.achievement, this.isLast = false, this.delay = 0});

  @override
  State<AchievementItem> createState() => _AchievementItemState();
}

class _AchievementItemState extends State<AchievementItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child:
          Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Timeline Marker + Line
                  Column(
                    children: [
                      AchievementMarker(accentColor: widget.achievement.accentColor, icon: widget.achievement.icon),

                      // Connecting Line (if not last)
                      if (!widget.isLast)
                        Container(
                          width: 3,
                          height: context.responsiveValue(mobile: 100.0, tablet: 110.0, desktop: 120.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                widget.achievement.accentColor.withAlpha((255 * 0.5).round()),
                                widget.achievement.accentColor.withAlpha((255 * 0.1).round()),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    width: context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
                  ),

                  // Right: Content
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
                      padding: EdgeInsets.all(
                        context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
                      ),
                      margin: EdgeInsets.only(bottom: widget.isLast ? 0 : s.spaceBtwItems),
                      decoration: BoxDecoration(
                        color: DColors.cardBackground,
                        borderRadius: BorderRadius.circular(s.borderRadiusMd),
                        border: Border.all(
                          color: _isHovered
                              ? widget.achievement.accentColor
                              : widget.achievement.accentColor.withAlpha((255 * 0.3).round()),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isHovered
                                ? widget.achievement.accentColor.withAlpha((255 * 0.15).round())
                                : Colors.black.withAlpha((255 * 0.05).round()),
                            blurRadius: _isHovered ? 15 : 8,
                            offset: Offset(0, _isHovered ? 6 : 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(context, s),
                          SizedBox(height: s.paddingMd),
                          _buildDescription(context, s),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: widget.delay.ms)
              .slideX(begin: -0.1, duration: 600.ms, delay: widget.delay.ms),
    );
  }

  /// Header (Title + Date)
  Widget _buildHeader(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          widget.achievement.title,
          style: fonts.headlineSmall.rajdhani(
            fontSize: context.responsiveValue(mobile: 18.0, tablet: 20.0, desktop: 22.0),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
        ),
        SizedBox(height: s.paddingSm * 0.5),

        // Date Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm * 0.6),
          decoration: BoxDecoration(
            color: widget.achievement.accentColor.withAlpha((255 * 0.15).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: widget.achievement.accentColor.withAlpha((255 * 0.5).round()), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_today_rounded, size: 14, color: widget.achievement.accentColor),
              SizedBox(width: s.paddingSm * 0.5),
              Text(
                widget.achievement.date,
                style: fonts.bodySmall.rubik(
                  color: widget.achievement.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Description
  Widget _buildDescription(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Text(
      widget.achievement.description,
      style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.7),
    );
  }
}
