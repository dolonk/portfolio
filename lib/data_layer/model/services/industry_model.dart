import 'package:flutter/material.dart';

class IndustryModel {
  final String name;
  final String description;
  final IconData icon;
  final Color accentColor;

  IndustryModel({required this.name, required this.description, required this.icon, required this.accentColor});

  static List<IndustryModel> getAllIndustries() {
    return [
      // 1. E-commerce
      IndustryModel(
        name: 'E-commerce',
        description: 'Online stores, payment integration, inventory management',
        icon: Icons.shopping_cart_rounded,
        accentColor: const Color(0xFF8B5CF6), // Purple
      ),

      // 2. Healthcare
      IndustryModel(
        name: 'Healthcare',
        description: 'Patient management, telemedicine, health tracking apps',
        icon: Icons.medical_services_rounded,
        accentColor: const Color(0xFFEF4444), // Red
      ),

      // 3. Finance
      IndustryModel(
        name: 'Finance',
        description: 'Banking apps, payment gateways, financial analytics',
        icon: Icons.account_balance_rounded,
        accentColor: const Color(0xFF10B981), // Green
      ),

      // 4. Education
      IndustryModel(
        name: 'Education',
        description: 'E-learning platforms, LMS, student management systems',
        icon: Icons.school_rounded,
        accentColor: const Color(0xFF3B82F6), // Blue
      ),

      // 5. Entertainment
      IndustryModel(
        name: 'Entertainment',
        description: 'Streaming apps, gaming platforms, media content delivery',
        icon: Icons.movie_rounded,
        accentColor: const Color(0xFFEC4899), // Pink
      ),

      // 6. IoT
      IndustryModel(
        name: 'IoT',
        description: 'Smart home, device control, sensor data management',
        icon: Icons.devices_rounded,
        accentColor: const Color(0xFF06B6D4), // Cyan
      ),

      // 7. AI/ML Applications
      IndustryModel(
        name: 'AI/ML Applications',
        description: 'Machine learning models, predictive analytics, automation',
        icon: Icons.psychology_rounded,
        accentColor: const Color(0xFFF59E0B), // Amber
      ),

      // 8. Others
      IndustryModel(
        name: 'Others',
        description: 'Real estate, logistics, travel, and custom solutions',
        icon: Icons.category_rounded,
        accentColor: const Color(0xFF6366F1), // Indigo
      ),
    ];
  }
}
