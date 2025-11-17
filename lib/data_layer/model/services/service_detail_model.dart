import 'package:flutter/material.dart';

class ServiceDetailModel {
  final String id;
  final String title;
  final String? subtitle;
  final String description;
  final String? iconPath;
  final List<String>? features;
  final List<String> technologies;
  final String? deliveryTime;
  final int? projectsCompleted;
  final double? rating;
  final List<ServiceProcess>? process;
  final IconData? icon;
  final List<String>? deliverables;
  final String? pricing;
  final String? buttonText;

  ServiceDetailModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    this.iconPath,
    this.features,
    this.technologies = const [],
    this.deliveryTime,
    this.projectsCompleted,
    this.rating,
    this.process,
    this.icon,
    this.deliverables,
    this.pricing,
    this.buttonText,
  });

  static List<ServiceDetailModel> getAllServices() {
    return [
      // 1. Mobile App Development
      ServiceDetailModel(
        id: 'mobile-development',
        title: 'Mobile App Development',
        description:
        'Native iOS & Android apps with Material Design and Cupertino category_badge, state management, and seamless API integration.',
        icon: Icons.phone_android_rounded,
        deliverables: [
          'Native iOS & Android apps',
          'Material Design + Cupertino',
          'State management implementation',
          'API integration',
          'App store deployment',
        ],
        //technologies: ['Flutter', 'Dart', 'Firebase', 'Provider', 'BLoC'],
        pricing: 'From \$3,500',
        buttonText: 'Get a Quote',
      ),

      // 2. Web Application Development
      ServiceDetailModel(
        id: 'web-development',
        title: 'Web Development',
        description:
        'Responsive web applications with PWA support, SEO optimization, and cross-browser compatibility for modern web experiences.',
        icon: Icons.web_rounded,
        deliverables: [
          'Responsive web apps',
          'PWA support',
          'SEO optimization',
          'Cross-browser compatibility',
          'Firebase/AWS hosting',
        ],
        //technologies: ['Flutter Web', 'HTML5', 'CSS3', 'Firebase', 'AWS'],
        pricing: 'From \$4,000',
        buttonText: 'Get a Quote',
      ),

      // 3. Desktop Application Development
      ServiceDetailModel(
        id: 'desktop-development',
        title: 'Desktop Development',
        description:
        'Cross-platform desktop applications for Windows, macOS, and Linux with native platform integration and auto-update support.',
        icon: Icons.laptop_mac_rounded,
        deliverables: [
          'Windows, macOS, Linux apps',
          'Native platform integration',
          'File system access',
          'System tray functionality',
          'Auto-update support',
        ],
        //technologies: ['Flutter Desktop', 'C++', 'SQLite', 'Platform Channels'],
        pricing: 'From \$5,000',
        buttonText: 'Get a Quote',
      ),

      // 4. UI/UX Design Services
      ServiceDetailModel(
        id: 'uiux-design',
        title: 'UI/UX Design Services',
        description:
        'User-centered design solutions from research to high-fidelity mockups, creating intuitive and beautiful user experiences.',
        icon: Icons.design_services_rounded,
        deliverables: [
          'User research & personas',
          'Wireframing & prototyping',
          'High-fidelity mockups',
          'Design system creation',
          'Usability testing',
        ],
        //technologies: ['Figma', 'Adobe XD', 'Sketch', 'InVision'],
        pricing: 'From \$800',
        buttonText: 'Get a Quote',
      ),

      // 5. Consulting & Code Review
      ServiceDetailModel(
        id: 'consulting',
        title: 'Consulting & Code Review',
        description:
        'Expert guidance on architecture, performance optimization, and best practices to elevate your development process.',
        icon: Icons.psychology_rounded,
        deliverables: [
          'Architecture review',
          'Performance optimization',
          'Code refactoring guidance',
          'Team training',
          'Best practices implementation',
        ],
        //technologies: ['Flutter', 'Dart', 'Clean Architecture', 'MVVM', 'Testing'],
        pricing: '\$100/hour',
        buttonText: 'Book a Session',
      ),

      // 6. Maintenance & Support
      ServiceDetailModel(
        id: 'maintenance',
        title: 'Maintenance & Support',
        description:
        'Ongoing support and maintenance to keep your applications running smoothly with bug fixes, updates, and monitoring.',
        icon: Icons.support_agent_rounded,
        deliverables: [
          'Bug fixes',
          'Feature updates',
          'OS compatibility updates',
          'Performance monitoring',
          '24/7 support options',
        ],
        //technologies: ['CI/CD', 'Analytics', 'Firebase', 'Monitoring Tools'],
        pricing: '\$400 /month',
        buttonText: 'Discuss Plans',
      ),
    ];
  }
}

/// 🔄 Service Process Step
class ServiceProcess {
  final String title;
  final String description;
  final String icon;

  ServiceProcess({required this.title, required this.description, required this.icon});
}

