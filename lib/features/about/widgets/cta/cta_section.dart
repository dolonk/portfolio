import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../route/route_name.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common_function/widgets/custom_button.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/common_function/widgets/animation_social_icon.dart';
import 'package:portfolio/features/about/widgets/cta/widgets/floating_shapes.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  Future<void> _downloadCV(BuildContext context) async {
    const String cvUrl = 'assets/files/dolon_kumar_cv.pdf';

    try {
      final Uri url = Uri.parse(cvUrl);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('CV download coming soon!'), backgroundColor: Colors.orange));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to download CV. Please try again later.'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return SectionContainer(
      padding: EdgeInsets.only(top: s.spaceBtwSections),
      child: Stack(
        children: [
          // Floating Shapes Background
          const Positioned.fill(child: FloatingShapes()),

          // Main Content
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF8B5CF6).withAlpha((255 * 0.15).round()),
                  const Color(0xFF3B82F6).withAlpha((255 * 0.15).round()),
                ],
              ),
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
                ),
                child: Column(
                  children: [
                    // Heading
                    Text(
                      'Let\'s Work Together',
                      style: fonts.displayMedium.rajdhani(
                        fontSize: context.responsiveValue(mobile: 32, tablet: 40, desktop: 48),
                        fontWeight: FontWeight.bold,
                        color: DColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: s.spaceBtwItems),

                    // Subtitle
                    Text(
                      'Ready to turn your ideas into reality? Let\'s discuss how I can help you achieve your goals.',
                      style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: s.spaceBtwSections),

                    // CTA Buttons
                    _buildCTAButtons(context, s),
                    SizedBox(height: s.spaceBtwSections),

                    // Social Links
                    AnimationSocialIcon(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// CTA Buttons
  Widget _buildCTAButtons(BuildContext context, DSizes s) {
    if (context.isMobile) {
      return Column(
        children: [
          // Primary Button
          CustomButton(
            width: double.infinity,
            height: 52,
            tittleText: 'Get In Touch',
            icon: Icons.email_rounded,
            isPrimary: true,
            onPressed: () => context.go(RouteNames.contact),
          ),
          SizedBox(height: s.paddingMd),

          // Secondary Button
          CustomButton(
            width: double.infinity,
            height: 52,
            isPrimary: false,
            tittleText: 'Download CV',
            icon: Icons.download_rounded,

            onPressed: () => _downloadCV(context),
          ),
        ],
      );
    } else {
      return Wrap(
        spacing: s.paddingLg,
        runSpacing: s.paddingMd,
        alignment: WrapAlignment.center,
        children: [
          // Primary Button
          CustomButton(
            width: 200,
            height: 52,
            tittleText: 'Get In Touch',
            icon: Icons.email_rounded,
            isPrimary: true,
            onPressed: () => context.go(RouteNames.contact),
          ),

          // Secondary Button
          CustomButton(
            width: 200,
            height: 52,
            tittleText: 'Download CV',
            icon: Icons.download_rounded,
            isPrimary: false,
            onPressed: () => _downloadCV(context),
          ),
        ],
      );
    }
  }
}
