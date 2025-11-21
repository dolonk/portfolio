import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/route/route_name.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/common_function/widgets/custom_button.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class PriceCustomCtaSection extends StatefulWidget {
  const PriceCustomCtaSection({super.key});

  @override
  State<PriceCustomCtaSection> createState() => _PriceCustomCtaSectionState();
}

class _PriceCustomCtaSectionState extends State<PriceCustomCtaSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 1000),
          ),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(0.0, _isHovered ? -5.0 : 0.0, 0.0),
              padding: EdgeInsets.all(s.paddingXl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [DColors.cardBackground, DColors.cardBackground],
                ),
                borderRadius: BorderRadius.circular(s.borderRadiusLg),
                border: Border.all(
                  color: _isHovered
                      ? DColors.primaryButton
                      : DColors.primaryButton.withAlpha((255 * 0.5).round()),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: DColors.primaryButton.withAlpha((_isHovered ? 255 * 0.3 : 255 * 0.15).round()),
                    blurRadius: _isHovered ? 30 : 20,
                    offset: Offset(0, _isHovered ? 15 : 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Icon
                  _buildIcon(s),
                  SizedBox(height: s.spaceBtwItems),

                  // Heading
                  _buildHeading(fonts, s),
                  SizedBox(height: s.paddingMd),

                  // Description
                  _buildDescription(fonts, s),
                  SizedBox(height: s.spaceBtwItems),

                  // CTA Buttons
                  _buildCTAButtons(s),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, duration: 600.ms),
        ),
      ),
    );
  }

  /// Icon/Emoji
  Widget _buildIcon(DSizes s) {
    return Container(
          padding: EdgeInsets.all(s.paddingLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [DColors.primaryButton, DColors.primaryButton.withAlpha((255 * 0.7).round())],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            '💡',
            style: TextStyle(fontSize: context.responsiveValue(mobile: 36, tablet: 44, desktop: 48)),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 2000.ms, color: Colors.white.withAlpha((255 * 0.3).round()));
  }

  /// Heading
  Widget _buildHeading(AppFonts fonts, DSizes s) {
    return Text(
      'Need something different?',
      style: fonts.headlineLarge.rajdhani(
        fontSize: context.responsiveValue(mobile: 26, tablet: 30, desktop: 34),
        fontWeight: FontWeight.bold,
        color: DColors.textPrimary,
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Description
  Widget _buildDescription(AppFonts fonts, DSizes s) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
      ),
      child: Text(
        'These packages are starting points. If you need a custom solution tailored to your specific requirements, let\'s discuss how we can bring your vision to life!',
        style: fonts.bodyLarge.rubik(
          fontSize: context.responsiveValue(mobile: 15, tablet: 17, desktop: 18),
          color: DColors.textSecondary,
          height: 1.7,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// CTA Buttons
  Widget _buildCTAButtons(DSizes s) {
    if (context.isMobile) {
      return Column(
        children: [
          _buildContactButton(s),
          SizedBox(height: s.paddingMd),
          _buildScheduleButton(s),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildContactButton(s),
        SizedBox(width: s.paddingMd),
        _buildScheduleButton(s),
      ],
    );
  }

  Widget _buildContactButton(DSizes s) {
    return CustomButton(
      width: context.responsiveValue(mobile: double.infinity, tablet: 200, desktop: 220),
      height: 50,
      tittleText: '💬 Contact Us',
      onPressed: () {
        context.go(RouteNames.contact);
      },
    );
  }

  Widget _buildScheduleButton(DSizes s) {
    return CustomButton(
      width: context.responsiveValue(mobile: double.infinity, tablet: 200, desktop: 220),
      height: 50,
      tittleText: '📅 Schedule Call',
      onPressed: () {
        context.go(RouteNames.contact);
      },
    );
  }
}
