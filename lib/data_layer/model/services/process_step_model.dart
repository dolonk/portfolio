import 'package:flutter/material.dart';

class ProcessStepModel {
  final String title;
  final String timeline;
  final String description;
  final IconData icon;
  final int stepNumber;
  final List<String> clientReceives;

  ProcessStepModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.stepNumber,
    this.timeline = '',
    this.clientReceives = const [],
  });

  // Sample data for 5 process steps
  static List<ProcessStepModel> getAllSteps() {
    return [
      // Step 1: Discovery
      ProcessStepModel(
        stepNumber: 1,
        title: 'Discovery',
        timeline: '1-2 weeks',
        description:
            'Understanding your requirements, goals, target audience, and project scope through detailed consultation.',
        icon: Icons.search_rounded,
        clientReceives: ['Signed contract', 'Project timeline', 'Access to project management tool'],
      ),

      // Step 2: Design & Planning
      ProcessStepModel(
        stepNumber: 2,
        title: 'Design & Planning',
        timeline: '2-3 weeks',
        description:
            'Creating wireframes, UI/UX designs, technical architecture, and detailed project roadmap with milestones.',
        icon: Icons.architecture_rounded,
        clientReceives: ['Approved UI/UX designs', 'Technical architecture document', 'Development starts'],
      ),

      // Step 3: Development
      ProcessStepModel(
        stepNumber: 3,
        title: 'Development',
        timeline: '4-8 weeks',
        description:
            'Building robust, scalable applications with clean code, following MVVM architecture and best practices.',
        icon: Icons.code_rounded,
        clientReceives: ['Weekly progress updates', 'Demo builds for testing', 'Regular code commits'],
      ),

      // Step 4: Testing & QA
      ProcessStepModel(
        stepNumber: 4,
        title: 'Testing & QA',
        timeline: '1-2 weeks',
        description:
            'Comprehensive testing including unit tests, widget tests, integration tests, and manual quality assurance.',
        icon: Icons.bug_report_rounded,
        clientReceives: ['Test reports', 'Bug fix implementations', 'Performance optimization'],
      ),

      // Step 5: Deployment & Support
      ProcessStepModel(
        stepNumber: 5,
        title: 'Deployment & Support',
        timeline: '1 week + ongoing',
        description:
            'Launching your app to production, app stores deployment, and providing post-launch support and maintenance.',
        icon: Icons.rocket_launch_rounded,
        clientReceives: [
          'Complete source code',
          'Deployment to stores/hosting',
          'Documentation',
          'Support period begins',
        ],
      ),
    ];
  }
}
