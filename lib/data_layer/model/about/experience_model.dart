import 'package:flutter/material.dart';

class ExperienceModel {
  final String company;
  final String role;
  final String startDate;
  final String? endDate;
  final List<String> responsibilities;
  final List<String> technologies;
  final String? companyLogo;
  final Color accentColor;

  ExperienceModel({
    required this.company,
    required this.role,
    required this.startDate,
    this.endDate,
    required this.responsibilities,
    required this.technologies,
    this.companyLogo,
    required this.accentColor,
  });

  /// Check if this is current position
  bool get isCurrent => endDate == null;

  /// Get duration string
  String get duration {
    final end = endDate ?? 'Present';
    return '$startDate - $end';
  }

  /// Get all experiences
  static List<ExperienceModel> getAllExperiences() {
    return [
      // Current Position
      ExperienceModel(
        company: 'THT Space Electrical Company LTD (EPZ)',
        role: 'Software Engineer',
        startDate: 'April 2023',
        endDate: null,
        responsibilities: [
          'Developed and maintained multiple cross-platform applications using Flutter for mobile, web, and desktop',
          'Implemented complex state management solutions using Provider, GetX, and Bloc patterns for scalable architecture',
          'Integrated RESTful APIs and WebSocket communication for real-time features and seamless data synchronization',
          'Built custom animations and category_badge to enhance user experience and brand identity',
          'Utilized native code integration (FFI) for performance-critical features and platform-specific optimizations',
          'Implemented CI/CD pipelines using GitHub Actions, reducing deployment time by 60%',
          'Conducted comprehensive testing (Unit, Widget, Integration tests) ensuring 95%+ code coverage',
          'Collaborated with cross-functional teams to deliver high-quality applications on time and within budget',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'Kotlin',
          'Java',
          'Swift',
          'Firebase',
          'REST API',
          'WebSocket',
          'Provider',
          'GetX',
          'Bloc',
          'SQLite',
          'Hive',
          'GitHub Actions',
          'Stripe',
        ],
        companyLogo: null,
        accentColor: const Color(0xFF8B5CF6), // Purple
      ),

      // Add more experiences here if you have previous roles
      // ExperienceModel(
      //   company: 'Previous Company Name',
      //   role: 'Flutter Developer Intern',
      //   startDate: 'Jan 2022',
      //   endDate: 'March 2023',
      //   responsibilities: [
      //     'Assisted in mobile app development',
      //     'Fixed bugs and implemented features',
      //   ],
      //   technologies: ['Flutter', 'Dart', 'Firebase'],
      //   companyLogo: null,
      //   accentColor: const Color(0xFF3B82F6),
      // ),
    ];
  }
}
