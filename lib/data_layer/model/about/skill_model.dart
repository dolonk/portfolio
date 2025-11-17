import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final double percentage;

  SkillModel({required this.name, required this.percentage});
}

class SkillCategoryModel {
  final String categoryName;
  final IconData icon;
  final Color accentColor;
  final List<SkillModel> skills;

  SkillCategoryModel({
    required this.categoryName,
    required this.icon,
    required this.accentColor,
    required this.skills,
  });

  /// Get all skill categories
  static List<SkillCategoryModel> getAllCategories() {
    return [
      // Category 1: Languages
      SkillCategoryModel(
        categoryName: 'Programming Languages',
        icon: Icons.code_rounded,
        accentColor: const Color(0xFFEF4444), // Red
        skills: [
          SkillModel(name: 'Dart', percentage: 95),
          SkillModel(name: 'Kotlin & Java', percentage: 85),
          SkillModel(name: 'Swift', percentage: 80),
          SkillModel(name: 'Python', percentage: 70),
          SkillModel(name: 'JavaScript', percentage: 70),
          SkillModel(name: 'C++', percentage: 70),
        ],
      ),

      // Category 2: Core Development
      SkillCategoryModel(
        categoryName: 'Core Development',
        icon: Icons.flutter_dash_rounded,
        accentColor: const Color(0xFF8B5CF6), // Purple
        skills: [
          SkillModel(name: 'Flutter & Dart', percentage: 95),
          SkillModel(name: 'State Management (Provider, GetX, Bloc)', percentage: 90),
          SkillModel(name: 'Native Android (Kotlin, Java)', percentage: 85),
          SkillModel(name: 'Native iOS (Swift)', percentage: 80),
        ],
      ),

      // Category 3: Backend & API
      SkillCategoryModel(
        categoryName: 'Backend & API',
        icon: Icons.storage_rounded,
        accentColor: const Color(0xFF3B82F6), // Blue
        skills: [
          SkillModel(name: 'REST API & WebSocket', percentage: 90),
          SkillModel(name: 'Firebase Integration', percentage: 85),
          SkillModel(name: 'SQLite & Hive', percentage: 80),
          SkillModel(name: 'MongoDB & SQL', percentage: 75),
        ],
      ),

      // Category 4: Advanced Skills
      SkillCategoryModel(
        categoryName: 'Advanced Skills',
        icon: Icons.rocket_launch_rounded,
        accentColor: const Color(0xFFF59E0B), // Orange
        skills: [
          SkillModel(name: 'Multi-threading (Isolates)', percentage: 85),
          SkillModel(name: 'FFI (Native Code Integration)', percentage: 80),
          SkillModel(name: 'Custom Animations', percentage: 85),
          SkillModel(name: 'Custom Painting & Widgets', percentage: 80),
          SkillModel(name: 'CI/CD (GitHub Actions)', percentage: 75),
        ],
      ),

      // Category 5: Testing & Quality
      SkillCategoryModel(
        categoryName: 'Testing & Quality Assurance',
        icon: Icons.verified_rounded,
        accentColor: const Color(0xFF10B981), // Green
        skills: [
          SkillModel(name: 'Unit Testing', percentage: 80),
          SkillModel(name: 'Widget Testing', percentage: 80),
          SkillModel(name: 'Integration Testing', percentage: 75),
          SkillModel(name: 'App Performance Analysis (Flutter DevTools)', percentage: 70),
          SkillModel(name: 'Git & Version Control', percentage: 90),
        ],
      ),
    ];
  }
}
