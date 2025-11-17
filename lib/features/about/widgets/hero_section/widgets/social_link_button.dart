import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/about/social_link_model.dart';

class SocialLinkButton extends StatefulWidget {
  final SocialLinkModel social;

  const SocialLinkButton({super.key, required this.social});

  @override
  State<SocialLinkButton> createState() => _SocialLinkButtonState();
}

class _SocialLinkButtonState extends State<SocialLinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(widget.social.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 50,
          height: 50,
          transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
          decoration: BoxDecoration(
            color: _isHovered ? widget.social.color.withAlpha((255 * 0.15).round()) : DColors.cardBackground,
            shape: BoxShape.circle,
            border: Border.all(color: _isHovered ? widget.social.color : DColors.cardBorder, width: 2),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.social.color.withAlpha((255 * 0.3).round()),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Icon(
            widget.social.icon,
            size: 22,
            color: _isHovered ? widget.social.color : DColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch URL: $urlString');
    }
  }
}
