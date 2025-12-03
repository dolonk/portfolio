import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class PricingIntroSection extends StatelessWidget {
  const PricingIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, top: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 800),
          ),
          child: Text(
            'I believe in transparent, value-based pricing. Every project is unique, so these are starting prices. After understanding your specific requirements, I\'ll provide a detailed quote tailored to your needs.',
            style: fonts.bodyLarge.rubik(
              fontSize: context.responsiveValue(mobile: 16, tablet: 18, desktop: 20),
              color: DColors.textSecondary,
              height: 1.8,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms),
        ),
      ),
    );
  }
}
