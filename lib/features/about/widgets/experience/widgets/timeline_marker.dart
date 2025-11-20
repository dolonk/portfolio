import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class TimelineMarker extends StatelessWidget {
  final Color accentColor;
  final bool isCurrent;
  final IconData icon;

  const TimelineMarker({super.key, required this.accentColor, this.isCurrent = false, this.icon = Icons.work_rounded});

  @override
  Widget build(BuildContext context) {
    final size = context.responsiveValue(mobile: 50.0, tablet: 60.0, desktop: 70.0);

    Widget marker = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accentColor, accentColor.withAlpha(178)],
        ),
        boxShadow: [BoxShadow(color: accentColor.withAlpha(102), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Icon(icon, color: Colors.white, size: size * 0.5),
    );

    // Add pulse animation if current position
    if (isCurrent) {
      marker = marker
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.08, 1.08),
            duration: 2000.ms,
            curve: Curves.easeInOut,
          );
    }

    return marker;
  }
}
