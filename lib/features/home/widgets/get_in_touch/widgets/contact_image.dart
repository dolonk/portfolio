import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedContactImage extends StatelessWidget {
  final double height;

  const AnimatedContactImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
          "assets/home/projects/contact.png",
          height: height,
          fit: BoxFit.cover,
          cacheHeight: height.toInt(),
          filterQuality: FilterQuality.medium,
          errorBuilder: (context, error, stackTrace) {
            debugPrint('❌ Failed to load contact image');
            return Container(
              height: height,
              width: height * 0.8,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.person_outline, size: height * 0.4, color: Colors.white54),
            );
          },
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 2000.ms, curve: Curves.easeInOut);
  }
}
