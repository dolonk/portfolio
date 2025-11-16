import 'package:flutter/material.dart';

class PricingFeature {
  final String text;
  final bool isIncluded;

  PricingFeature({required this.text, this.isIncluded = true});
}

class PricingTierModel {
  final String name;
  final String tagline;
  final String price;
  final String deliveryTime;
  final List<PricingFeature> features;
  final String ctaText;
  final bool isPopular;
  final Color accentColor;

  PricingTierModel({
    required this.name,
    required this.tagline,
    required this.price,
    required this.deliveryTime,
    required this.features,
    required this.ctaText,
    this.isPopular = false,
    required this.accentColor,
  });

  /// Get all pricing tiers
  static List<PricingTierModel> getAllTiers() {
    return [
      // STARTER PACKAGE
      PricingTierModel(
        name: 'Starter',
        tagline: 'Best for MVPs',
        price: '3,500',
        deliveryTime: '4-6 weeks',
        ctaText: 'Get Quote',
        isPopular: false,
        accentColor: Color(0xFF8B5CF6), // Purple
        features: [
          PricingFeature(text: 'Single platform (iOS OR Android)'),
          PricingFeature(text: '5-7 screens'),
          PricingFeature(text: 'Basic state management (Provider)'),
          PricingFeature(text: 'REST API integration'),
          PricingFeature(text: 'Basic UI/UX (Material/Cupertino)'),
          PricingFeature(text: '2 revisions'),
          PricingFeature(text: '1 month support'),
          PricingFeature(text: 'Custom backend', isIncluded: false),
          PricingFeature(text: 'Advanced animations', isIncluded: false),
        ],
      ),

      // PRO PACKAGE (POPULAR)
      PricingTierModel(
        name: 'Pro',
        tagline: 'Most Popular',
        price: '8,500',
        deliveryTime: '6-10 weeks',
        ctaText: 'Get Quote',
        isPopular: true,
        accentColor: Color(0xFFF59E0B), // Gold
        features: [
          PricingFeature(text: 'Two platforms (iOS + Android OR Web)'),
          PricingFeature(text: '10-15 screens'),
          PricingFeature(text: 'Advanced state management (BLoC/Riverpod)'),
          PricingFeature(text: 'Firebase/Backend integration'),
          PricingFeature(text: 'Custom UI/UX design'),
          PricingFeature(text: 'Push notifications'),
          PricingFeature(text: '5 revisions'),
          PricingFeature(text: '3 months support'),
          PricingFeature(text: 'Unit/Widget tests'),
          PricingFeature(text: 'Desktop platforms', isIncluded: false),
        ],
      ),

      // ENTERPRISE PACKAGE
      PricingTierModel(
        name: 'Enterprise',
        tagline: 'For Large Projects',
        price: '20,000',
        deliveryTime: '10-16 weeks',
        ctaText: 'Contact Us',
        isPopular: false,
        accentColor: Color(0xFF3B82F6), // Blue
        features: [
          PricingFeature(text: 'All platforms (mobile + Web + Desktop)'),
          PricingFeature(text: '15+ screens'),
          PricingFeature(text: 'Complex architecture (MVVM + Clean)'),
          PricingFeature(text: 'Custom backend development'),
          PricingFeature(text: 'Advanced animations'),
          PricingFeature(text: 'Real-time features'),
          PricingFeature(text: 'Unlimited revisions'),
          PricingFeature(text: '6 months support'),
          PricingFeature(text: 'Complete testing suite'),
          PricingFeature(text: 'CI/CD setup'),
          PricingFeature(text: 'Complete documentation'),
          PricingFeature(text: 'Team training'),
        ],
      ),
    ];
  }
}
