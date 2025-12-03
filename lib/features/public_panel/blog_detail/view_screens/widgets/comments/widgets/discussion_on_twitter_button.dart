import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../../data_layer/domain/entities/blog/blog_post.dart';
import '../../../../../../../utility/constants/colors.dart';
import '../../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../../utility/url_launcher_service/url_launcher_service.dart';


class DiscussOnTwitterButton extends StatefulWidget {
  final BlogPost post;

  const DiscussOnTwitterButton({super.key, required this.post});

  @override
  State<DiscussOnTwitterButton> createState() => _DiscussOnTwitterButtonState();
}

class _DiscussOnTwitterButtonState extends State<DiscussOnTwitterButton> {
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
        onTap: _openTwitterDiscussion,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
          decoration: BoxDecoration(
            gradient: _isHovered ? const LinearGradient(colors: [Color(0xFF1DA1F2), Color(0xFF0C85D0)]) : null,
            color: _isHovered ? null : const Color(0xFF1DA1F2).withAlpha((255 * 0.1).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: _isHovered ? const Color(0xFF1DA1F2) : DColors.cardBorder, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.xTwitter, color: _isHovered ? Colors.white : const Color(0xFF1DA1F2), size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                'Discuss on Twitter',
                style: fonts.bodyMedium.rubik(
                  color: _isHovered ? Colors.white : const Color(0xFF1DA1F2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openTwitterDiscussion() async {
    final tweetText = 'Just read "${widget.post.title}"\n\nThoughts:';
    final postUrl = 'https://yourwebsite.com/blog/${widget.post.id}';
    final twitterUrl =
        'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(tweetText)}&url=${Uri.encodeComponent(postUrl)}';

    final urlLauncher = UrlLauncherService();
    await urlLauncher.launchWebsite(twitterUrl);
  }
}
