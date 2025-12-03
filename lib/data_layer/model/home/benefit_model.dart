import 'package:flutter/material.dart';

class BenefitModel {
  final String title;
  final String description;
  final IconData icon;

  BenefitModel({required this.title, required this.description, required this.icon});

  static List<BenefitModel> getBenefitsData() {
    return [
      BenefitModel(
        title: 'Production-Ready Code',
        description:
            'Every project follows MVVM architecture, clean code principles, and industry best practices for long-term maintainability.',
        icon: Icons.code_rounded,
      ),
      BenefitModel(
        title: 'Cross-Platform Expertise',
        description:
            'Master of Flutter across iOS, Android, Web, Windows, macOS, and Linux - one codebase, all platforms.',
        icon: Icons.devices_rounded,
      ),
      BenefitModel(
        title: 'Clean Architecture & Testing',
        description:
            'Structured code with proper separation of concerns, dependency injection, and comprehensive unit/widget testing.',
        icon: Icons.architecture_rounded,
      ),
      BenefitModel(
        title: 'On-Time Delivery Guarantee',
        description:
            'Milestone-based development with transparent communication. 95% of portfolio delivered on or before deadline.',
        icon: Icons.schedule_rounded,
      ),
      BenefitModel(
        title: 'Post-Launch Support',
        description: 'Every project includes support period. Bug fixes, updates, and guidance even after deployment.',
        icon: Icons.support_agent_rounded,
      ),
    ];
  }
}
