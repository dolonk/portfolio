import 'package:flutter/material.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class AchievementMarker extends StatelessWidget {
  final Color accentColor;
  final IconData icon;

  const AchievementMarker({super.key, required this.accentColor, required this.icon});

  @override
  Widget build(BuildContext context) {
    final size = context.responsiveValue(mobile: 50.0, tablet: 55.0, desktop: 60.0);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [accentColor, accentColor.withAlpha((255 * 0.7).round())],
        ),
        boxShadow: [
          BoxShadow(color: accentColor.withAlpha((255 * 0.4).round()), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: size * 0.5),
    );
  }
}
