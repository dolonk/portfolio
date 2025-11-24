import 'package:flutter/material.dart';
import '../../../utility/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../utility/default_sizes/font_size.dart';
import '../../../utility/default_sizes/default_sizes.dart';

class DataNotFoundState extends StatelessWidget {
  const DataNotFoundState({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Center(
      child: Container(
        padding: EdgeInsets.all(s.paddingXl * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.article_outlined, size: 100, color: DColors.textSecondary),
            SizedBox(height: s.spaceBtwItems),
            Text(
              'Post Not Found',
              style: fonts.headlineMedium.rajdhani(color: DColors.textPrimary, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: s.paddingSm),
            Text(
              'The article you\'re looking for does\'t exist\nor may have been removed.',
              style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9), duration: 400.ms);
  }
}
