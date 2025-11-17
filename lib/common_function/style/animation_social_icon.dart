import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data_layer/model/about/social_link_model.dart';
import '../../utility/url_launcher_service/url_launcher_service.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class AnimationSocialIcon extends StatelessWidget {
  const AnimationSocialIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final socialLinks = SocialLinkModel.getSocialLinks();
    final spacing = context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg);

    return AnimationLimiter(
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        alignment: WrapAlignment.center,
        children: List.generate(socialLinks.length, (index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: ScaleAnimation(
              scale: 0.5,
              child: FadeInAnimation(child: SocialIconButton(social: socialLinks[index])),
            ),
          );
        }),
      ),
    ).animate(delay: 300.ms).fadeIn(duration: 600.ms);
  }
}

class SocialIconButton extends StatefulWidget {
  final SocialLinkModel social;

  const SocialIconButton({super.key, required this.social});

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final urlLauncher = UrlLauncherService();
          await urlLauncher.launchWebsite(widget.social.url);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Button with Glow Effect
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(_isHovered ? 1.15 : 1.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  if (_isHovered)
                    BoxShadow(
                      color: widget.social.color.withAlpha((255 * 0.4).round()),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                ],
              ),
              child: Container(
                width: context.responsiveValue(mobile: 60, tablet: 65, desktop: 70),
                height: context.responsiveValue(mobile: 60, tablet: 65, desktop: 70),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? widget.social.color.withAlpha((255 * 0.15).round())
                      : DColors.cardBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: _isHovered ? widget.social.color : DColors.cardBorder, width: 2),
                ),
                child: Icon(
                  widget.social.icon,
                  size: context.responsiveValue(mobile: 28, tablet: 28, desktop: 32),
                  color: _isHovered ? widget.social.color : DColors.textPrimary,
                ),
              ),
            ),
            SizedBox(height: s.paddingSm),

            // Platform Label
            Text(
              widget.social.platform,
              style: fonts.bodySmall.rubik(
                color: _isHovered ? widget.social.color : DColors.textSecondary,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
