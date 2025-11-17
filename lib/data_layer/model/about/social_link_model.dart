import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLinkModel {
  final String platform;
  final String url;
  final IconData icon;
  final Color color;

  SocialLinkModel({required this.platform, required this.url, required this.icon, required this.color});

  /// Get Social Links Data
  static List<SocialLinkModel> getSocialLinks() {
    return [
      // GitHub
      SocialLinkModel(
        platform: 'GitHub',
        url: 'https://github.com/your-username',
        icon: FontAwesomeIcons.github,
        color: const Color(0xB3424040),
      ),

      // LinkedIn
      SocialLinkModel(
        platform: 'LinkedIn',
        url: 'https://www.linkedin.com/in/your-profile',
        icon: FontAwesomeIcons.linkedin,
        color: const Color(0xFF0A66C2),
      ),

      // Twitter/X
      SocialLinkModel(
        platform: 'Twitter',
        url: 'https://twitter.com/your-handle',
        icon: FontAwesomeIcons.twitter,
        color: const Color(0xFF1DA1F2),
      ),

      // YouTube
      SocialLinkModel(
        platform: 'YouTube',
        url: 'https://www.youtube.com/@your-channel',
        icon: FontAwesomeIcons.youtube,
        color: const Color(0xFFFF0000),
      ),

      // Medium or Dev.to (Choose one or add both)
      SocialLinkModel(
        platform: 'Medium',
        url: 'https://medium.com/@your-username',
        icon: FontAwesomeIcons.medium,
        color: const Color(0xFFFFFFFF),
      ),
    ];
  }
}
