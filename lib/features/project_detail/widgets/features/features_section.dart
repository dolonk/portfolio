import 'widgets/feature_item.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/data_layer/model/portfolio/project_model.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class FeaturesSection extends StatelessWidget {
  final ProjectModel project;

  const FeaturesSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          _buildSectionHeading(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Features List
          Padding(
            padding: EdgeInsets.only(left: s.spaceBtwItems),
            child: _buildFeaturesList(context),
          ),
        ],
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Key Features Implemented', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text(
          'Core functionalities that make this project stand out',
          style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
        ),
      ],
    );
  }

  /// Features List
  Widget _buildFeaturesList(BuildContext context) {
    final features = _getFeaturesData();

    return Column(
      children: features.map((feature) {
        return FeatureItem(
          icon: feature['icon'] as IconData,
          title: feature['title'] as String,
          description: feature['description'] as String,
          iconColor: feature['color'] as Color,
        );
      }).toList(),
    );
  }

  /// Get Features Data with FontAwesome Icons
  List<Map<String, dynamic>> _getFeaturesData() {
    return [
      {
        'icon': FontAwesomeIcons.userCheck,
        'title': 'User Authentication',
        'description': 'Email/social login with secure password management and two-factor authentication',
        'color': const Color(0xFF8B5CF6), // Purple
      },
      {
        'icon': FontAwesomeIcons.magnifyingGlass,
        'title': 'Product Browsing',
        'description': 'Advanced filters and search with category navigation and smart recommendations',
        'color': const Color(0xFF3B82F6), // Blue
      },
      {
        'icon': FontAwesomeIcons.cartShopping,
        'title': 'Shopping Cart',
        'description': 'Real-time cart updates with quantity management and price calculations',
        'color': const Color(0xFF10B981), // Green
      },
      {
        'icon': FontAwesomeIcons.creditCard,
        'title': 'Payment Integration',
        'description': 'Secure Stripe payments with multiple methods including cards and wallets',
        'color': const Color(0xFFEF4444), // Red
      },
      {
        'icon': FontAwesomeIcons.truckFast,
        'title': 'Order Tracking',
        'description': 'Live order status updates and delivery tracking with notifications',
        'color': const Color(0xFFF59E0B), // Amber
      },
      {
        'icon': FontAwesomeIcons.bell,
        'title': 'Push Notifications',
        'description': 'Real-time alerts for offers, order updates, and personalized messages',
        'color': const Color(0xFFEC4899), // Pink
      },
      {
        'icon': FontAwesomeIcons.heart,
        'title': 'Wishlist & Favorites',
        'description': 'Save items for later with quick access and price drop alerts',
        'color': const Color(0xFFDC2626), // Red
      },
      {
        'icon': FontAwesomeIcons.language,
        'title': 'Multi-language Support',
        'description': 'Support for 5+ languages with RTL layout and automatic detection',
        'color': const Color(0xFF06B6D4), // Cyan
      },
    ];
  }
}
