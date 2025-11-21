import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../route/route_name.dart';
import '../../../../../utility/constants/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../../../common_function/widgets/custom_button.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/common_function/widgets/animation_social_icon.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: context.isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: context.isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        // Greeting
        Text('Hello', style: fonts.bodyLarge.rubik(color: DColors.textPrimary)),
        SizedBox(height: s.paddingXs),

        // Name & Animated Title
        _buildNameWithAnimation(context, fonts),
        SizedBox(height: s.spaceBtwItems),

        // Description (responsive max width)
        _buildDescription(context, fonts),
        SizedBox(height: s.spaceBtwItems),

        // CTA Buttons
        _buildCTAButtons(context),
        SizedBox(height: s.spaceBtwItems),

        // Social Icons
        const AnimationSocialIcon(),
      ],
    );
  }

  /// Name with typewriter animation
  Widget _buildNameWithAnimation(BuildContext context, AppFonts fonts) {
    return Column(
      crossAxisAlignment: context.isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          "I'm Dolon km, an",
          style: fonts.displayMedium,
          textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
        ),
        AnimatedTextKit(
          isRepeatingAnimation: true,
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(
              'App Developer',
              textStyle: fonts.displayMedium.rajdhani(color: DColors.primaryButton),
              speed: const Duration(milliseconds: 150),
              cursor: '|',
            ),
            TypewriterAnimatedText(
              'Flutter Expert',
              textStyle: fonts.displayMedium.rajdhani(color: DColors.primaryButton),
              speed: const Duration(milliseconds: 150),
              cursor: '|',
            ),
          ],
        ),
      ],
    );
  }

  /// Description with proper constraints
  Widget _buildDescription(BuildContext context, AppFonts fonts) {
    const description =
        'Crafting sleek, high-performance apps with clean code and seamless user '
        'experiences. Explore my portfolio to see how I bring ideas to life through '
        'intuitive and scalable mobile applications.';

    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 500, desktop: 600),
      ),
      child: Text(
        description,
        style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
        textAlign: context.isDesktop ? TextAlign.start : TextAlign.center,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// CTA Buttons (no hover state needed, CustomButton handles it)
  Widget _buildCTAButtons(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: context.isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        // Primary CTA
        CustomButton(width: 160, height: 50, tittleText: 'Hire Me', onPressed: () => context.go(RouteNames.contact)),

        // Secondary CTA
        CustomButton(
          width: 160,
          height: 50,
          tittleText: 'My Works',
          isPrimary: false,
          onPressed: () => context.go(RouteNames.portfolio),
        ),
      ],
    );
  }
}
