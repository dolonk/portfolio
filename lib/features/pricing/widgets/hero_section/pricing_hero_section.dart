import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class PricingHeroSection extends StatefulWidget {
  const PricingHeroSection({super.key});

  @override
  State<PricingHeroSection> createState() => _PricingHeroSectionState();
}

class _PricingHeroSectionState extends State<PricingHeroSection> with TickerProviderStateMixin {
  late AnimationController _gradientController;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    // Gradient shift animation (infinite)
    _gradientController = AnimationController(duration: const Duration(seconds: 8), vsync: this)
      ..repeat(reverse: true);

    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _gradientController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(s.paddingMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFF3B82F6)],
              stops: [0.0 + (_gradientAnimation.value * 0.1), 0.5 + (_gradientAnimation.value * 0.1), 1.0],
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
                  // Main Heading
                  _buildHeading(fonts, s),
                  SizedBox(height: s.paddingMd),

                  // Gradient underline decoration
                  _buildUnderlineDecoration(),
                  SizedBox(height: s.spaceBtwItems),

                  // Subheading
                  _buildSubheading(fonts, s),
                  SizedBox(height: s.paddingSm),

                  // Description
                  _buildDescription(fonts, s),
                  SizedBox(height: s.spaceBtwSections),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Gradient animated underline
  Widget _buildUnderlineDecoration() {
    return Container(
      height: 4,
      width: context.responsiveValue(mobile: 150, tablet: 250, desktop: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(color: Colors.white.withAlpha((255 * 0.6).round()), blurRadius: 10, offset: Offset(0, 2)),
        ],
      ),
    ).animate().scaleX(begin: 0, duration: 800.ms, delay: 400.ms, curve: Curves.easeOut);
  }

  /// Main heading text
  Widget _buildHeading(AppFonts fonts, DSizes s) {
    return Text(
          'Transparent Pricing Plans',
          style: fonts.displayLarge.rajdhani(
            fontSize: context.responsiveValue(mobile: 36, tablet: 44, desktop: 52),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms)
        .then()
        .shimmer(duration: 1500.ms, color: Colors.white.withAlpha((255 * 0.3).round()));
  }

  /// Subheading text
  Widget _buildSubheading(AppFonts fonts, DSizes s) {
    return Text(
      'Investment in quality, delivered with care',
      style: fonts.titleLarge.rubik(
        fontSize: context.responsiveValue(mobile: 18, tablet: 20, desktop: 22),
        fontWeight: FontWeight.w500,
        color: Colors.white.withAlpha((255 * 0.95).round()),
      ),
      textAlign: TextAlign.center,
    ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0, duration: 600.ms);
  }

  /// Description text
  Widget _buildDescription(AppFonts fonts, DSizes s) {
    return Text(
      'Choose the perfect package for your project needs.\nNo hidden fees, transparent pricing, flexible terms.',
      style: fonts.bodyLarge.rubik(
        fontSize: context.responsiveValue(mobile: 14, tablet: 16, desktop: 18),
        color: Colors.white.withAlpha((255 * 0.85).round()),
        height: 1.6,
      ),
      textAlign: TextAlign.center,
    ).animate(delay: 400.ms).fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0, duration: 600.ms);
  }
}
