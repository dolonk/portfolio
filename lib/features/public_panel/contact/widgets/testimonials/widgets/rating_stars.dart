import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color? color;

  const RatingStars({super.key, required this.rating, this.size = 20, this.color});

  @override
  Widget build(BuildContext context) {
    final starColor = color ?? const Color(0xFFFBBF24);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          // Full star
          return Icon(Icons.star_rounded, size: size, color: starColor);
        } else if (index < rating) {
          // Half star
          return Icon(Icons.star_half_rounded, size: size, color: starColor);
        } else {
          // Empty star
          return Icon(Icons.star_outline_rounded, size: size, color: starColor.withAlpha((255 * 0.3).round()));
        }
      }),
    );
  }
}
