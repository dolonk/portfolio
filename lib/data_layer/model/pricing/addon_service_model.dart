import 'package:flutter/material.dart';

class AddonServiceModel {
  final String id;
  final String name;
  final String emoji;
  final IconData icon;
  final String description;
  final String priceRange;
  final List<String> features;
  final Color accentColor;
  final bool isPopular;

  AddonServiceModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.icon,
    required this.description,
    required this.priceRange,
    required this.features,
    required this.accentColor,
    this.isPopular = false,
  });

  /// Get all add-on services
  static List<AddonServiceModel> getAllAddons() {
    return [
      // 1. UI/UX Design
      AddonServiceModel(
        id: 'uiux-design',
        name: 'UI/UX Design',
        emoji: '🎨',
        icon: Icons.palette_rounded,
        description: 'Custom design system, wireframes, high-fidelity mockups',
        priceRange: '\$800 - \$10,000',
        accentColor: Color(0xFFEC4899), // Pink
        isPopular: true,
        features: [
          'User research & personas',
          'Wireframing & prototyping',
          'High-fidelity mockups',
          'Design system creation',
          'Usability testing',
        ],
      ),

      // 2. Backend Development
      AddonServiceModel(
        id: 'backend-dev',
        name: 'Backend Development',
        emoji: '⚙️',
        icon: Icons.dns_rounded,
        description: 'Custom API, database design, server setup, admin panel',
        priceRange: '\$2,500 - \$30,000',
        accentColor: Color(0xFF3B82F6), // Blue
        isPopular: true,
        features: [
          'Custom REST/GraphQL API',
          'Database design & optimization',
          'Server infrastructure setup',
          'Admin panel development',
          'API documentation',
        ],
      ),

      // 3. App Store Optimization
      AddonServiceModel(
        id: 'aso',
        name: 'App Store Optimization',
        emoji: '📱',
        icon: Icons.trending_up_rounded,
        description: 'Keyword research, listing optimization, screenshot design',
        priceRange: '\$500 - \$800',
        accentColor: Color(0xFF10B981), // Green
        features: [
          'Keyword research & analysis',
          'App title & description optimization',
          'Screenshot & preview design',
          'App icon optimization',
          'Competitive analysis',
        ],
      ),

      // 4. Marketing Materials
      AddonServiceModel(
        id: 'marketing',
        name: 'Marketing Materials',
        emoji: '📊',
        icon: Icons.campaign_rounded,
        description: 'Landing page, promo video, social media graphics',
        priceRange: '\$600 - \$4,000',
        accentColor: Color(0xFFF59E0B), // Gold
        isPopular: true,
        features: [
          'Landing page design & development',
          'Promotional video creation',
          'Social media graphics',
          'Email templates',
          'Marketing collateral',
        ],
      ),

      // 5. Extended Support
      AddonServiceModel(
        id: 'extended-support',
        name: 'Extended Support',
        emoji: '🛠️',
        icon: Icons.support_agent_rounded,
        description: 'Monthly maintenance, bug fixes, feature updates',
        priceRange: '\$400 - \$1,500/month',
        accentColor: Color(0xFF8B5CF6), // Purple
        features: [
          'Bug fixes & hotfixes',
          'Feature updates & enhancements',
          'OS compatibility updates',
          'Performance monitoring',
          '24/7 support options',
        ],
      ),

      // 6. Code Documentation
      AddonServiceModel(
        id: 'documentation',
        name: 'Code Documentation',
        emoji: '📚',
        icon: Icons.description_rounded,
        description: 'Complete technical documentation, API docs, setup guides',
        priceRange: '\$400 - \$3,500',
        accentColor: Color(0xFF06B6D4), // Cyan
        features: [
          'Technical architecture docs',
          'API documentation',
          'Setup & deployment guides',
          'Code comments & structure',
          'User manuals',
        ],
      ),

      // 7. Team Training
      AddonServiceModel(
        id: 'training',
        name: 'Team Training',
        emoji: '👨‍💻',
        icon: Icons.school_rounded,
        description: 'Flutter workshops, code reviews, mentorship sessions',
        priceRange: '\$100/hour',
        accentColor: Color(0xFFEF4444), // Red
        features: [
          'Flutter best practices workshops',
          'Code review sessions',
          'Architecture guidance',
          'One-on-one mentorship',
          'Team onboarding support',
        ],
      ),
    ];
  }

  /// Get popular add-ons
  static List<AddonServiceModel> getPopularAddons() {
    return getAllAddons().where((addon) => addon.isPopular).toList();
  }

  /// Get addon by ID
  static AddonServiceModel? getAddonById(String id) {
    try {
      return getAllAddons().firstWhere((addon) => addon.id == id);
    } catch (e) {
      return null;
    }
  }
}
