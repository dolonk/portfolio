import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/data_layer/model/about/social_link_model.dart';
import 'package:responsive_website/utility/url_launcher_service/url_launcher_service.dart';

class SocialLinksWidget extends StatelessWidget {
  const SocialLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final socialLinks = SocialLinkModel.getSocialLinks();

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Row(
            children: [
              Icon(Icons.share_rounded, color: DColors.primaryButton, size: 20),
              SizedBox(width: s.paddingSm),
              Text('Follow Me', style: fonts.titleMedium),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Social Icons Grid
          Wrap(
            spacing: s.paddingSm,
            runSpacing: s.paddingSm,
            children: socialLinks.map((social) => _SocialIcon(social: social)).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 700.ms).slideX(begin: 0.1, duration: 600.ms, delay: 700.ms);
  }
}

class _SocialIcon extends StatefulWidget {
  final SocialLinkModel social;

  const _SocialIcon({required this.social});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final urlLauncher = UrlLauncherService();
          await urlLauncher.launchWebsite(widget.social.url);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(s.paddingMd),
          decoration: BoxDecoration(
            color: _isHovered
                ? DColors.primaryButton.withAlpha((255 * 0.2).round())
                : DColors.primaryButton.withAlpha((255 * 0.1).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: _isHovered ? DColors.primaryButton : DColors.cardBorder, width: 2),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(widget.social.icon, color: _isHovered ? DColors.primaryButton : DColors.textSecondary, size: 24),
        ),
      ),
    );
  }
}
