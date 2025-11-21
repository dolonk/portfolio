import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';

class AnimatedCounter extends StatelessWidget {
  final String value;

  const AnimatedCounter({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(value, style: context.fonts.headlineLarge)
        .animate()
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), duration: 600.ms);
  }
}
