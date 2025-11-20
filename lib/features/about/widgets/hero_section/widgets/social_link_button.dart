import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import '../../../../../utility/url_launcher_service/url_launcher_service.dart';
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
        onTap: () async {
          final urlLauncher = UrlLauncherService();
          await urlLauncher.launchWebsite(widget.social.url);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 50,
          height: 50,
          transform: Matrix4.diagonal3Values(_isHovered ? 1.1 : 1.0, _isHovered ? 1.1 : 1.0, 1.0),
          decoration: BoxDecoration(
            color: _isHovered ? widget.social.color.withAlpha((38)) : DColors.cardBackground,
            shape: BoxShape.circle,
            border: Border.all(color: _isHovered ? widget.social.color : DColors.cardBorder, width: 2),
            boxShadow: [
              if (_isHovered)
                BoxShadow(color: widget.social.color.withAlpha((76)), blurRadius: 12, offset: const Offset(0, 4)),
            ],
          ),
          child: Icon(widget.social.icon, size: 22, color: _isHovered ? widget.social.color : DColors.textPrimary),
        ),
      ),
    );
  }
}
