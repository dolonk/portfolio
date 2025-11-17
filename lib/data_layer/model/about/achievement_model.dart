import 'package:flutter/material.dart';

class AchievementModel {
  final String title;
  final String description;
  final String date; // e.g., "April 2023", "2023 - Present"
  final IconData icon;
  final Color accentColor;
  final AchievementType type;

  AchievementModel({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.accentColor,
    required this.type,
  });

  /// Get all achievements (chronologically - most recent first)
  static List<AchievementModel> getAllAchievements() {
    return [
      // Achievement 1: Live Apps
      AchievementModel(
        title: 'Published 2 Live Applications',
        description:
            'Successfully launched and published 2 production-ready Flutter applications on both App Store and Play Store, serving thousands of active users with positive ratings and reviews.',
        date: 'April 2023 - Present',
        icon: Icons.rocket_launch_rounded,
        accentColor: const Color(0xFF8B5CF6), // Purple
        type: AchievementType.project,
      ),

      // Achievement 2: Open Source
      AchievementModel(
        title: 'Built 10+ Open Source Projects on GitHub',
        description:
            'Developed and maintained over 10 open-source Flutter projects on GitHub, demonstrating expertise in various Flutter features, state management patterns, and best practices.',
        date: 'January 2023 - Present',
        icon: Icons.code_rounded,
        accentColor: const Color(0xFF3B82F6), // Blue
        type: AchievementType.project,
      ),

      // Achievement 3: CI/CD Implementation
      AchievementModel(
        title: 'Implemented CI/CD Pipeline with GitHub Actions',
        description:
            'Successfully set up and optimized continuous integration and deployment pipelines, reducing deployment time by 60% and improving code quality through automated testing.',
        date: 'September 2024',
        icon: Icons.settings_applications_rounded,
        accentColor: const Color(0xFFF59E0B), // Orange
        type: AchievementType.technical,
      ),

      // Achievement 4: Test Coverage
      AchievementModel(
        title: 'Achieved 95%+ Test Coverage',
        description:
            'Implemented comprehensive testing strategy including unit tests, widget tests, and integration tests, ensuring high code quality and reliability across all projects.',
        date: 'August 2023',
        icon: Icons.verified_rounded,
        accentColor: const Color(0xFF10B981), // Green
        type: AchievementType.quality,
      ),

      // Achievement 5: Cross-Platform Mastery
      AchievementModel(
        title: 'Cross-Platform Development Expertise',
        description:
            'Mastered Flutter development across all platforms - iOS, Android, Web, and Desktop (Windows, macOS), delivering consistent user experiences everywhere.',
        date: 'July 2023',
        icon: Icons.devices_rounded,
        accentColor: const Color(0xFF6366F1), // Indigo
        type: AchievementType.skill,
      ),

      // Achievement 6: FFI Integration
      AchievementModel(
        title: 'Advanced FFI & Native Code Integration',
        description:
            'Successfully implemented Foreign Function Interface (FFI) for native code integration, optimizing performance-critical features and bridging Flutter with platform-specific APIs.',
        date: 'June 2023',
        icon: Icons.integration_instructions_rounded,
        accentColor: const Color(0xFFEF4444), // Red
        type: AchievementType.technical,
      ),

      // Achievement 7: State Management Mastery (Optional - Add if you want)
      // AchievementModel(
      //   title: 'Mastered Multiple State Management Solutions',
      //   description:
      //       'Gained expertise in Provider, GetX, and Bloc patterns, implementing scalable state management across large-scale applications.',
      //   date: 'May 2023',
      //   icon: Icons.account_tree_rounded,
      //   accentColor: const Color(0xFFEC4899), // Pink
      //   type: AchievementType.skill,
      // ),

      // Add certifications if you have any:
      // AchievementModel(
      //   title: 'Flutter Advanced Development Certification',
      //   description:
      //       'Completed comprehensive Flutter certification covering advanced topics including performance optimization, architecture patterns, and production deployment.',
      //   date: 'March 2023',
      //   icon: Icons.school_rounded,
      //   accentColor: const Color(0xFF14B8A6), // Teal
      //   type: AchievementType.certification,
      // ),
    ];
  }
}

/// Achievement Types for categorization
enum AchievementType { project, technical, certification, skill, quality, recognition }
