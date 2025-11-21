import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';

class FloatingShapes extends StatelessWidget {
  const FloatingShapes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shape 1 - Top Left
        Positioned(
          top: 50,
          left: 30,
          child: _buildShape(size: 80, color: DColors.primaryButton.withAlpha((255 * 0.1).round()), delay: 0),
        ),

        // Shape 2 - Top Right
        Positioned(
          top: 80,
          right: 50,
          child: _buildShape(size: 60, color: const Color(0xFF8B5CF6).withAlpha((255 * 0.1).round()), delay: 500),
        ),

        // Shape 3 - Bottom Left
        Positioned(
          bottom: 60,
          left: 80,
          child: _buildShape(size: 50, color: const Color(0xFF3B82F6).withAlpha((255 * 0.1).round()), delay: 1000),
        ),

        // Shape 4 - Bottom Right
        Positioned(
          bottom: 100,
          right: 100,
          child: _buildShape(size: 70, color: const Color(0xFFF59E0B).withAlpha((255 * 0.1).round()), delay: 1500),
        ),
      ],
    );
  }

  Widget _buildShape({required double size, required Color color, required int delay}) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: 0, end: -20, duration: 3000.ms, delay: delay.ms, curve: Curves.easeInOut)
        .fadeIn(duration: 1000.ms);
  }
}
