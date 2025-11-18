import 'animated_counter.dart';
import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class StartCard extends StatelessWidget {
  final String icon;
  final int number;
  final String title;
  final int index;

  const StartCard({super.key, required this.icon, required this.number, required this.title, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
          padding: EdgeInsets.all(context.isMobile ? 0 : s.paddingMd),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(color: DColors.cardBorder, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Icon
              Text(
                icon,
                style: TextStyle(fontSize: context.responsiveValue(mobile: 36, tablet: 44, desktop: 52)),
              ),

              // Animated Counter
              AnimatedCounter(
                targetValue: number,
                duration: const Duration(milliseconds: 2000),
                delay: Duration(milliseconds: 200 * index),
                textStyle: fonts.headlineLarge.rajdhani(
                  color: DColors.primaryButton,
                  fontWeight: FontWeight.bold,
                  fontSize: context.responsiveValue(mobile: 32, tablet: 36, desktop: 40),
                ),
              ),

              // Title
              Text(
                title,
                style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, curve: Curves.easeIn)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        )
        .then(delay: (150 * index).ms); // Staggered delay
  }
}
