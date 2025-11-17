import 'package:flutter/material.dart';

class ComparisonRowModel {
  final String feature;
  final String starter;
  final String pro;
  final String enterprise;
  final bool starterIncluded;
  final bool proIncluded;
  final bool enterpriseIncluded;

  ComparisonRowModel({
    required this.feature,
    required this.starter,
    required this.pro,
    required this.enterprise,
    this.starterIncluded = true,
    this.proIncluded = true,
    this.enterpriseIncluded = true,
  });
}

class ComparisonCategory {
  final String id;
  final String title;
  final IconData icon;
  final String emoji;
  final Color accentColor;
  final List<ComparisonRowModel> rows;

  ComparisonCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.emoji,
    required this.accentColor,
    required this.rows,
  });

  /// Get all comparison categories
  static List<ComparisonCategory> getAllCategories() {
    return [
      // Category 1: Platforms
      ComparisonCategory(
        id: 'platforms',
        title: 'Platforms Coverage',
        icon: Icons.smartphone_rounded,
        emoji: '📱',
        accentColor: Color(0xFF8B5CF6), // Purple
        rows: [
          ComparisonRowModel(feature: 'iOS', starter: '✅ OR', pro: '✅', enterprise: '✅'),
          ComparisonRowModel(feature: 'Android', starter: '✅ OR', pro: '✅', enterprise: '✅'),
          ComparisonRowModel(feature: 'Web', starter: '❌', pro: '✅ OR', enterprise: '✅', starterIncluded: false),
          ComparisonRowModel(
            feature: 'Desktop (Win/Mac/Linux)',
            starter: '❌',
            pro: '❌',
            enterprise: '✅',
            starterIncluded: false,
            proIncluded: false,
          ),
          ComparisonRowModel(
            feature: 'Total Platforms',
            starter: '1 Platform',
            pro: '2 Platforms',
            enterprise: 'All 4',
          ),
        ],
      ),

      // Category 2: Technical Features
      ComparisonCategory(
        id: 'technical',
        title: 'Technical Features',
        icon: Icons.settings_rounded,
        emoji: '⚙️',
        accentColor: Color(0xFF3B82F6), // Blue
        rows: [
          ComparisonRowModel(
            feature: 'Number of Screens',
            starter: '5-7 screens',
            pro: '10-15 screens',
            enterprise: '15+ screens',
          ),
          ComparisonRowModel(
            feature: 'State Management',
            starter: 'Basic (Provider)',
            pro: 'Advanced (BLoC/Riverpod)',
            enterprise: 'Enterprise (MVVM+Clean)',
          ),
          ComparisonRowModel(
            feature: 'Backend Integration',
            starter: '❌ Not included',
            pro: 'Firebase (Auth, Firestore)',
            enterprise: 'Custom Backend',
            starterIncluded: false,
          ),
          ComparisonRowModel(
            feature: 'Testing Coverage',
            starter: 'Basic validation',
            pro: 'Unit + Widget tests',
            enterprise: 'Full coverage (Unit+Widget+Integration)',
          ),
          ComparisonRowModel(
            feature: 'API Integration',
            starter: 'REST API',
            pro: 'REST + GraphQL',
            enterprise: 'REST + GraphQL + WebSocket',
          ),
        ],
      ),

      // Category 3: Design & UX
      ComparisonCategory(
        id: 'design',
        title: 'Design & UI/UX',
        icon: Icons.palette_rounded,
        emoji: '🎨',
        accentColor: Color(0xFFEC4899), // Pink
        rows: [
          ComparisonRowModel(
            feature: 'UI/UX Design',
            starter: 'Basic (Material/Cupertino)',
            pro: 'Custom Design System',
            enterprise: 'Premium Design + Branding',
          ),
          ComparisonRowModel(
            feature: 'Animations',
            starter: '❌ Basic transitions only',
            pro: 'Standard animations',
            enterprise: 'Advanced custom animations',
            starterIncluded: false,
          ),
          ComparisonRowModel(feature: 'Responsive Design', starter: '✅', pro: '✅', enterprise: '✅'),
          ComparisonRowModel(feature: 'Dark Mode', starter: '✅', pro: '✅', enterprise: '✅'),
          ComparisonRowModel(
            feature: 'Custom Branding',
            starter: '❌',
            pro: 'Basic',
            enterprise: 'Complete',
            starterIncluded: false,
          ),
        ],
      ),

      // Category 4: Development & Support
      ComparisonCategory(
        id: 'support',
        title: 'Support & Delivery',
        icon: Icons.support_agent_rounded,
        emoji: '🛠️',
        accentColor: Color(0xFF10B981), // Green
        rows: [
          ComparisonRowModel(
            feature: 'Revisions Included',
            starter: '2 revision rounds',
            pro: '5 revision rounds',
            enterprise: '♾️ Unlimited revisions',
          ),
          ComparisonRowModel(
            feature: 'Post-Launch Support',
            starter: '1 month support',
            pro: '3 months support',
            enterprise: '6 months support',
          ),
          ComparisonRowModel(
            feature: 'CI/CD Pipeline',
            starter: '❌ Not included',
            pro: '❌ Not included',
            enterprise: '✅ Included',
            starterIncluded: false,
            proIncluded: false,
          ),
          ComparisonRowModel(
            feature: 'Documentation',
            starter: 'Basic README',
            pro: 'Standard docs',
            enterprise: 'Complete technical docs',
          ),
          ComparisonRowModel(
            feature: 'Team Training',
            starter: '❌',
            pro: '❌',
            enterprise: '✅ Included',
            starterIncluded: false,
            proIncluded: false,
          ),
          ComparisonRowModel(
            feature: 'Estimated Delivery',
            starter: '4-6 weeks',
            pro: '6-10 weeks',
            enterprise: '10-16 weeks',
          ),
        ],
      ),

      // Category 5: Pricing
      ComparisonCategory(
        id: 'pricing',
        title: 'Pricing & Value',
        icon: Icons.payments_rounded,
        emoji: '💰',
        accentColor: Color(0xFFF59E0B), // Gold
        rows: [
          ComparisonRowModel(feature: 'Starting Price', starter: '\$3,500', pro: '\$8,500', enterprise: '\$20,000'),
          ComparisonRowModel(
            feature: 'Source Code Ownership',
            starter: '✅ Full ownership',
            pro: '✅ Full ownership',
            enterprise: '✅ Full ownership',
          ),
          ComparisonRowModel(
            feature: 'Payment Terms',
            starter: '30% - 40% - 30%',
            pro: '30% - 40% - 30%',
            enterprise: 'Custom terms available',
          ),
          ComparisonRowModel(
            feature: 'Refund Policy',
            starter: '50% before dev',
            pro: '50% before dev',
            enterprise: 'Custom agreement',
          ),
        ],
      ),
    ];
  }

  /// Get category by ID
  static ComparisonCategory? getCategoryById(String id) {
    try {
      return getAllCategories().firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }
}
