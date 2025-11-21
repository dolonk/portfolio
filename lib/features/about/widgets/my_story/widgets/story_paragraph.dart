import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class StoryParagraph extends StatelessWidget {
  final String text;
  final int delay;

  const StoryParagraph({super.key, required this.text, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Padding(
      padding: EdgeInsets.only(bottom: s.spaceBtwItems),
      child: Text(
        text,
        style: fonts.bodyLarge.rubik(
          color: DColors.textSecondary,
          height: 1.6,
          fontSize: context.responsiveValue(mobile: 14.0, tablet: 16.0, desktop: 18.0),
        ),
        textAlign: TextAlign.left,
      ),
    ).animate().fadeIn(duration: 600.ms, delay: delay.ms).slideY(begin: 0.1, duration: 600.ms, delay: delay.ms);
  }
}
