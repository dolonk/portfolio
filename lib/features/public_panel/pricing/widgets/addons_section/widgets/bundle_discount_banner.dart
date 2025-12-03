import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/route/route_name.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/common_function/widgets/custom_button.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class BundleDiscountBanner extends StatefulWidget {
  const BundleDiscountBanner({super.key});

  @override
  State<BundleDiscountBanner> createState() => _BundleDiscountBannerState();
}

class _BundleDiscountBannerState extends State<BundleDiscountBanner> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(
          context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFFF59E0B).withAlpha(38), const Color(0xFFFBBF24).withAlpha(38)],
          ),
          borderRadius: BorderRadius.circular(s.borderRadiusLg),
          border: Border.all(
            color: _isHovered ? const Color(0xFFF59E0B) : const Color(0xFFF59E0B).withAlpha(128),
            width: 2,
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: const Color(0xFFF59E0B).withAlpha(77), blurRadius: 25, offset: Offset(0, 10))]
              : null,
        ),
        child: Column(
          children: [
            // Icon
            Text('💡', style: TextStyle(fontSize: context.responsiveValue(mobile: 40, tablet: 48, desktop: 52)))
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2000.ms, color: Colors.white.withAlpha(77)),
            SizedBox(height: s.paddingMd),

            // Heading
            Text(
              'Bundle Discount Available!',
              style: fonts.titleLarge.rajdhani(
                fontSize: context.responsiveValue(mobile: 22, tablet: 26, desktop: 28),
                fontWeight: FontWeight.bold,
                color: Color(0xFFF59E0B),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: s.paddingSm),

            // Description
            Container(
              constraints: BoxConstraints(
                maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
              ),
              child: Text(
                'Get 15% off when you add 3 or more services to your package! Mix and match to create the perfect solution for your project.',
                style: fonts.bodyLarge.rubik(
                  fontSize: context.responsiveValue(mobile: 14, tablet: 16, desktop: 17),
                  color: DColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: s.spaceBtwItems),

            // CTA Button
            CustomButton(
              width: context.responsiveValue(mobile: double.infinity, tablet: 250, desktop: 280),
              height: 50,
              tittleText: 'Contact for Bundle Quote',
              onPressed: () {
                context.go('${RouteNames.contact}?type=bundle');
              },
            ),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.2, duration: 600.ms, delay: 800.ms),
    );
  }
}
