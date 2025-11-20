import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/url_launcher_service/url_launcher_service.dart';

class LinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? url;
  final Color color;
  final VoidCallback? onPressed;

  const LinkButton({super.key, required this.icon, required this.label, required this.color, this.url, this.onPressed});

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.onPressed != null) {
            widget.onPressed!();
          } else if (widget.url != null) {
            final link = UrlLauncherService();
            link.launchWebsite(widget.url!);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          padding: EdgeInsets.all(s.paddingXl),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? widget.color.withAlpha((255 * 0.5).round()) : DColors.cardBorder,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.color.withAlpha((255 * 0.2).round())
                    : Colors.black.withAlpha((255 * 0.05).round()),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(color: widget.color.withAlpha((255 * 0.15).round()), shape: BoxShape.circle),
                child: Center(child: FaIcon(widget.icon, size: 32, color: widget.color)),
              ),
              SizedBox(height: s.spaceBtwItems),

              // Label
              Text(
                widget.label,
                style: fonts.bodyLarge.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: context.responsiveValue(mobile: 15, tablet: 16, desktop: 17),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: s.paddingSm),

              // "Visit" Text with Arrow
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Visit',
                    style: fonts.labelMedium.rubik(color: widget.color, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: s.paddingSm),
                  Icon(Icons.arrow_forward_rounded, size: 16, color: widget.color),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
