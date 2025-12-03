import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class ContactHeroSection extends StatelessWidget {
  const ContactHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [DColors.background, DColors.secondaryBackground],
          ),
        ),
        child:
            Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Animated Gradient Heading
                    _buildGradientHeading(context, s),
                    SizedBox(height: s.spaceBtwItems),

                    // Subheading with Icon
                    _buildSubheading(context, s),
                  ],
                )
                .animate()
                .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
                .slideY(begin: 0.1, end: 0, duration: 800.ms, curve: Curves.easeOutCubic),
      ),
    );
  }

  /// Gradient Text Heading
  Widget _buildGradientHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color(0xFF8B5CF6), // Purple
          Color(0xFF3B82F6), // Blue
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        "Let's Build Something Amazing",
        style: fonts.displayLarge.rajdhani(fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Subheading with Icon
  Widget _buildSubheading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Clock Icon
        Container(
          padding: EdgeInsets.all(s.paddingSm * 0.6),
          decoration: BoxDecoration(
            color: DColors.primaryButton.withAlpha((255 * 0.15).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
          ),
          child: Icon(Icons.access_time_rounded, size: 18, color: DColors.primaryButton),
        ),
        SizedBox(width: s.paddingSm),

        // Subheading Text
        Flexible(
          child: Text(
            'I typically respond within 24 hours',
            style: fonts.bodyLarge.rubik(color: DColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
