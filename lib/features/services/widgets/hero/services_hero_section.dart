import 'package:flutter/material.dart';
import '../../../../utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class ServicesHeroSection extends StatelessWidget {
  const ServicesHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Heading
          Text(
            'Professional Flutter Development Services',
            style: fonts.displayLarge.rajdhani(height: 1.2),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Subheading
          Text(
            'End-to-end solutions for your digital products',
            style: fonts.bodyLarge.rubik(color: Colors.white.withAlpha((255 * 0.95).round())),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Description
          Container(
            constraints: BoxConstraints(
              maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
            ),
            child: Text(
              'From mobile apps to enterprise solutions, I deliver production-ready applications across all platforms with clean architecture and best practices.',
              style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
