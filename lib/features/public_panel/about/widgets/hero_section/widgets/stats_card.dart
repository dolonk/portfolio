import 'animated_counter.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/about/about_stats_model.dart';

class StatsCard extends StatefulWidget {
  final AboutStatsModel stat;

  const StatsCard({super.key, required this.stat});

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.diagonal3Values(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0, 1.0),
        padding: EdgeInsets.all(s.paddingMd),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [widget.stat.accentColor.withAlpha((25)), widget.stat.accentColor.withAlpha((12))],
          ),
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
          border: Border.all(
            color: _isHovered ? widget.stat.accentColor : widget.stat.accentColor.withAlpha(76),
            width: 2,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(color: widget.stat.accentColor.withAlpha((51)), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Icon(
              widget.stat.icon,
              size: context.responsiveValue(mobile: 28.0, tablet: 32.0, desktop: 36.0),
              color: widget.stat.accentColor,
            ),
            SizedBox(height: s.paddingSm),

            // Value with Counter Animation
            AnimatedCounter(value: widget.stat.value),
            SizedBox(height: s.paddingSm * 0.5),

            // Label
            Text(
              widget.stat.label,
              style: fonts.bodySmall.rubik(color: DColors.textSecondary),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
