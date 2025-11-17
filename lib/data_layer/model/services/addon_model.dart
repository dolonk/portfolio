import 'package:flutter/material.dart';

class AddonModel {
  final String name;
  final String description;
  final String priceRange;
  final IconData icon;
  final Color accentColor;

  AddonModel({
    required this.name,
    required this.description,
    required this.priceRange,
    required this.icon,
    required this.accentColor,
  });

  // Sample data for 7 add-ons
  static List<AddonModel> getAllAddons() {
    return [
      // 1. Backend Development
      AddonModel(
        name: 'Backend Development',
        description: 'Custom API, database design, server setup, admin panel',
        priceRange: '\$2,500 - \$30,000',
        icon: Icons.dns_rounded,
        accentColor: const Color(0xFF8B5CF6),
      ),

      // 2. App Store Optimization
      AddonModel(
        name: 'App Store Optimization',
        description: 'Keyword research, listing optimization, screenshot design',
        priceRange: '\$500 - \$800 (one-time)',
        icon: Icons.trending_up_rounded,
        accentColor: const Color(0xFF10B981),
      ),

      // 3. Marketing Materials
      AddonModel(
        name: 'Marketing Materials',
        description: 'Landing page, promo video, social media graphics',
        priceRange: '\$600 - \$4,000',
        icon: Icons.campaign_rounded,
        accentColor: const Color(0xFFF59E0B),
      ),

      // 4. Extended Support
      AddonModel(
        name: 'Extended Support',
        description: 'Monthly maintenance, bug fixes, feature updates',
        priceRange: '\$400 - \$1,500/month',
        icon: Icons.headset_mic_rounded,
        accentColor: const Color(0xFF3B82F6),
      ),

      // 5. Code Documentation
      AddonModel(
        name: 'Code Documentation',
        description: 'Complete technical documentation, API docs, setup guides',
        priceRange: '\$400 - \$3,500',
        icon: Icons.description_rounded,
        accentColor: const Color(0xFF06B6D4),
      ),

      // 6. Team Training
      AddonModel(
        name: 'Team Training',
        description: 'Flutter workshops, code reviews, mentorship sessions',
        priceRange: '\$100/hour',
        icon: Icons.school_rounded,
        accentColor: const Color(0xFFEF4444),
      ),
    ];
  }
}
