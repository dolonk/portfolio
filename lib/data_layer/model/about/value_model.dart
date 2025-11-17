import 'package:flutter/material.dart';

class ValueModel {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  ValueModel({required this.title, required this.description, required this.icon, required this.accentColor});

  /// Get all values/strengths
  static List<ValueModel> getAllValues() {
    return [
      ValueModel(
        title: 'Clean Code Architecture',
        description:
            'Writing maintainable, scalable, and well-documented code following industry best practices and SOLID principles. Every line of code is crafted with future developers in mind.',
        icon: Icons.architecture_rounded,
        accentColor: const Color(0xFF8B5CF6), // Purple
      ),
      ValueModel(
        title: 'Fast & Reliable Delivery',
        description:
            'Meeting deadlines consistently while maintaining high quality standards and clear communication throughout the project. Delivering on promises, every single time.',
        icon: Icons.rocket_launch_rounded,
        accentColor: const Color(0xFF3B82F6), // Blue
      ),
      ValueModel(
        title: 'Problem-Solving Mindset',
        description:
            'Finding elegant and efficient solutions to complex technical challenges with creative thinking and analytical approach. No problem is too difficult to solve.',
        icon: Icons.psychology_rounded,
        accentColor: const Color(0xFFF59E0B), // Orange
      ),
      ValueModel(
        title: 'Clear Communication',
        description:
            'Providing regular updates, transparent progress reports, and maintaining open channels for feedback and collaboration. Keeping stakeholders informed at every step.',
        icon: Icons.forum_rounded,
        accentColor: const Color(0xFF10B981), // Green
      ),
      ValueModel(
        title: 'Performance Optimization',
        description:
            'Ensuring applications run smoothly with optimized code, efficient resource usage, and excellent user experience. Speed and efficiency are never compromised.',
        icon: Icons.speed_rounded,
        accentColor: const Color(0xFFEC4899), // Pink
      ),
      ValueModel(
        title: 'Quality Assurance',
        description:
            'Comprehensive testing approach with 95%+ code coverage, ensuring bug-free and reliable applications. Quality is not an afterthought, it\'s built-in from day one.',
        icon: Icons.verified_user_rounded,
        accentColor: const Color(0xFF14B8A6), // Teal
      ),
    ];
  }
}
