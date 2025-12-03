import 'package:flutter/material.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class PortfolioHeroSection extends StatelessWidget {
  const PortfolioHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E3A8A), Color(0xFF6366F1), Color(0xFF7C3AED)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Heading
              Text('My Work', style: fonts.displayLarge, textAlign: TextAlign.center),
              SizedBox(height: s.spaceBtwItems),

              // Subheading
              Text(
                'Production-ready apps across platforms',
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
                  'Showcasing 50+ successful portfolio delivered across iOS, Android, Web and Desktop platforms with clean code, best practices, and exceptional user experiences.',
                  style: fonts.bodyMedium.rubik(color: Colors.white.withAlpha((255 * 0.85).round())),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: s.spaceBtwSections),
      ],
    );
  }
}
