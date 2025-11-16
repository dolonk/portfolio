import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

import '../../../../route/route_name.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E293B),
            const Color(0xFF0F172A),
            DColors.primaryButton.withAlpha((255 * 0.3).round()),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Top-left circle
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [DColors.primaryButton.withAlpha((255 * 0.2).round()), Colors.transparent],
                ),
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              _buildHeading(context, s),
              SizedBox(height: s.paddingMd),

              _buildCtaButton(context, s),
            ],
          ),
        ],
      ),
    );
  }

  /// Main Heading
  Widget _buildHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        Text(
          'Have a Project in Mind?',
          style: fonts.displayMedium.rajdhani(fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.spaceBtwItems),
        Text(
          "Let's work together to bring your vision to life",
          style: fonts.bodyLarge.rubik(color: Colors.white.withAlpha((255 * 0.95).round()), height: 1.6),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// CTA Button
  Widget _buildCtaButton(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Center(
      child: SizedBox(
        width: context.responsiveValue(mobile: double.infinity, tablet: 300, desktop: 300),
        child: ElevatedButton(
          onPressed: () => context.go(RouteNames.contact),
          style: ElevatedButton.styleFrom(
            backgroundColor: DColors.primaryButton,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: s.paddingXl, vertical: s.paddingMd),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Let's Build Your App", style: fonts.labelLarge.rubik(fontWeight: FontWeight.bold)),
              SizedBox(width: s.paddingMd),
              Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
