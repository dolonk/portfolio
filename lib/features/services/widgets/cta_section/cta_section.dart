import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../route/route_name.dart';
import '../../../../common_function/style/custom_button.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      width: double.infinity,
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
          _buildContentCard(context, s),
        ],
      ),
    );
  }

  /// Main Content Card
  Widget _buildContentCard(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Heading
        Text(
          'Ready to Start Your Project?',
          style: fonts.displayLarge.rajdhani(
            fontSize: context.responsiveValue(mobile: 28, tablet: 40, desktop: 48),
            color: Colors.white,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.spaceBtwItems),

        // Subheading
        Text(
          'Let\'s discuss your ideas and turn them into reality',
          style: fonts.bodyLarge.rubik(
            color: Colors.white.withAlpha((255 * 0.9).round()),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.spaceBtwItems),

        // Additional info badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: DColors.primaryButton.withAlpha((255 * 0.15).round()),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.schedule_rounded, color: DColors.primaryButton, size: 18),
              SizedBox(width: s.paddingSm),
              Flexible(
                child: Text(
                  'Free 30-minute consultation • No commitment required',
                  style: fonts.labelMedium.rubik(
                    color: Colors.white.withAlpha((255 * 0.95).round()),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: s.spaceBtwSections),

        // BUTTONS
        _buildButtons(context, s),
        SizedBox(height: s.spaceBtwSections),

        // Trust note
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_rounded, color: DColors.serviceGreen, size: 18),
            SizedBox(width: s.paddingSm),
            Text(
              'Trusted by 30+ clients worldwide',
              style: fonts.labelSmall.rubik(color: Colors.white.withAlpha((255 * 0.7).round())),
            ),
          ],
        ),
      ],
    );
  }

  /// CTA Buttons
  Widget _buildButtons(BuildContext context, DSizes s) {
    if (context.isMobile) {
      // Mobile: Stacked vertically
      return Column(
        children: [
          // Primary Button
          CustomButton(
            width: double.infinity,
            height: 52,
            tittleText: 'Schedule Free Call',
            icon: Icons.calendar_today_rounded,
            isPrimary: true,
            backgroundColor: DColors.primaryButton,
            foregroundColor: Colors.white,
            onPressed: () => context.go(RouteNames.contact),
          ),
          SizedBox(height: s.paddingMd),

          // Secondary Button
          CustomButton(
            width: double.infinity,
            height: 52,
            tittleText: 'Contact Us',
            icon: Icons.email_rounded,
            isPrimary: false,
            foregroundColor: Colors.white,
            onPressed: () => context.go(RouteNames.contact),
          ),
        ],
      );
    } else {
      // Tablet & Desktop: Side by side
      return Wrap(
        spacing: s.paddingLg,
        runSpacing: s.paddingMd,
        alignment: WrapAlignment.center,
        children: [
          // Primary Button
          CustomButton(
            width: 240,
            height: 52,
            isPrimary: true,
            tittleText: 'Schedule Free Call',
            icon: Icons.calendar_today_rounded,
            backgroundColor: DColors.primaryButton,
            onPressed: () => context.go(RouteNames.contact),
          ),

          // Secondary Button
          CustomButton(
            width: 200,
            height: 52,
            isPrimary: false,
            tittleText: 'Contact Us',
            icon: Icons.email_rounded,
            onPressed: () => context.go(RouteNames.contact),
          ),
        ],
      );
    }
  }
}
