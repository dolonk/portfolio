import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/url_launcher_service/url_launcher_service.dart';

class ShareButtons extends StatelessWidget {
  final String postTitle;
  final String postUrl;

  const ShareButtons({super.key, required this.postTitle, required this.postUrl});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Wrap(
      spacing: s.paddingSm,
      runSpacing: s.paddingSm,
      alignment: WrapAlignment.center,
      children: [
        // Twitter Share
        _ShareButton(
          icon: FontAwesomeIcons.xTwitter,
          label: 'Tweet',
          color: const Color(0xFF000000),
          onTap: () => _shareOnTwitter(),
        ),

        // LinkedIn Share
        _ShareButton(
          icon: FontAwesomeIcons.linkedin,
          label: 'Linkedin',
          color: const Color(0xFF0077B5),
          onTap: () => _shareOnLinkedIn(),
        ),

        // Facebook Share
        _ShareButton(
          icon: FontAwesomeIcons.facebook,
          label: 'Facebook',
          color: const Color(0xFF1877F2),
          onTap: () => _shareOnFacebook(),
        ),

        // Copy Link
        _ShareButton(
          icon: Icons.link_rounded,
          label: 'Copy',
          color: DColors.primaryButton,
          onTap: () => _copyLink(context),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.1, duration: 600.ms, delay: 400.ms);
  }

  void _shareOnTwitter() async {
    final url =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(postTitle)}&url=${Uri.encodeComponent(postUrl)}';
    final urlLauncher = UrlLauncherService();
    await urlLauncher.launchWebsite(url);
  }

  void _shareOnLinkedIn() async {
    final url = 'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(postUrl)}';
    final urlLauncher = UrlLauncherService();
    await urlLauncher.launchWebsite(url);
  }

  void _shareOnFacebook() async {
    final url = 'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(postUrl)}';
    final urlLauncher = UrlLauncherService();
    await urlLauncher.launchWebsite(url);
  }

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: postUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Text('Link copied to clipboard!', style: context.fonts.bodyMedium.rubik(color: Colors.white)),
          ],
        ),
        backgroundColor: DColors.primaryButton,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _ShareButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ShareButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  State<_ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<_ShareButton> {
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
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withAlpha((255 * 0.2).round()) : DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: _isHovered ? widget.color : DColors.cardBorder, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: _isHovered ? widget.color : DColors.textSecondary, size: 16),
              SizedBox(width: s.paddingXs),
              Text(
                widget.label,
                style: fonts.labelSmall.rubik(
                  color: _isHovered ? widget.color : DColors.textSecondary,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
