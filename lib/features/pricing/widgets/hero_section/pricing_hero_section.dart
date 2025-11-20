import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class PricingHeroSection extends StatelessWidget {
  const PricingHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFF3B82F6)],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 900),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeading(context, fonts, s),
              SizedBox(height: s.paddingMd),
              _buildUnderlineDecoration(context),
              SizedBox(height: s.spaceBtwItems),
              _buildSubheading(context, fonts, s),
              SizedBox(height: s.paddingSm),
              _buildDescription(context, fonts, s),
              SizedBox(height: s.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnderlineDecoration(BuildContext context) {
    return Container(
      height: 4,
      width: context.responsiveValue(mobile: 150, tablet: 250, desktop: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(color: Colors.white.withAlpha(153), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
    ).animate().scaleX(begin: 0, duration: 800.ms, delay: 400.ms, curve: Curves.easeOut);
  }

  Widget _buildHeading(BuildContext context, AppFonts fonts, DSizes s) {
    return _buildAnimatedText(
      text: 'Transparent Pricing Plans',
      style: fonts.displayLarge.rajdhani(
        fontSize: context.responsiveValue(mobile: 36, tablet: 44, desktop: 52),
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubheading(BuildContext context, AppFonts fonts, DSizes s) {
    return _buildAnimatedText(
      text: 'Investment in quality, delivered with care',
      style: fonts.titleLarge.rubik(
        fontSize: context.responsiveValue(mobile: 18, tablet: 20, desktop: 22),
        fontWeight: FontWeight.w500,
        color: Colors.white.withAlpha(242),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, AppFonts fonts, DSizes s) {
    return _buildAnimatedText(
      text:
          'Choose the perfect package for your project needs.\nNo hidden fees, transparent pricing, flexible terms.',
      style: fonts.bodyLarge.rubik(
        fontSize: context.responsiveValue(mobile: 14, tablet: 16, desktop: 18),
        color: Colors.white.withAlpha(218),
        height: 1.6,
      ),
    );
  }

  Widget _buildAnimatedText({required String text, required TextStyle style}) {
    return Text(text, style: style, textAlign: TextAlign.center);
  }
}
