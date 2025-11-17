import 'package:flutter/material.dart';

class TimelineStepModel {
  final int step;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  TimelineStepModel({
    required this.step,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  /// Get all timeline steps
  static List<TimelineStepModel> getAllSteps() {
    return [
      // Step 1: Initial Consultation
      TimelineStepModel(
        step: 1,
        title: 'Initial Consultation',
        description: 'Free 30-minute call to discuss your needs, goals, and project vision',
        icon: Icons.phone_in_talk_rounded,
        accentColor: const Color(0xFF8B5CF6),
      ),

      // Step 2: Proposal & Quote
      TimelineStepModel(
        step: 2,
        title: 'Proposal & Quote',
        description: 'Detailed proposal with timeline, milestones, and pricing within 48 hours',
        icon: Icons.description_rounded,
        accentColor: const Color(0xFF3B82F6),
      ),

      // Step 3: Agreement & Kickoff
      TimelineStepModel(
        step: 3,
        title: 'Agreement & Kickoff',
        description: 'Sign contract, set up communication channels, and officially start the project',
        icon: Icons.handshake_rounded,
        accentColor: const Color(0xFF10B981),
      ),

      // Step 4: Development & Updates
      TimelineStepModel(
        step: 4,
        title: 'Development & Updates',
        description: 'Regular progress updates, milestone reviews, and continuous feedback integration',
        icon: Icons.code_rounded,
        accentColor: const Color(0xFFF59E0B),
      ),

      // Step 5: Delivery & Support
      TimelineStepModel(
        step: 5,
        title: 'Delivery & Support',
        description: 'Final delivery with documentation, deployment, and 30-day post-launch support',
        icon: Icons.rocket_launch_rounded,
        accentColor: const Color(0xFFEF4444),
      ),
    ];
  }
}
