import 'package:flutter/material.dart';

class PaymentMilestone {
  final String name;
  final String percentage;
  final String whenDue;
  final List<String> deliverables;
  final Color accentColor;

  PaymentMilestone({
    required this.name,
    required this.percentage,
    required this.whenDue,
    required this.deliverables,
    required this.accentColor,
  });

  /// Get all payment milestones
  static List<PaymentMilestone> getAllMilestones() {
    return [
      PaymentMilestone(
        name: 'Project Kickoff',
        percentage: '30%',
        whenDue: 'Before work begins',
        deliverables: ['Signed contract', 'Project timeline', 'Access to project management tool'],
        accentColor: Color(0xFF8B5CF6), // Purple
      ),
      PaymentMilestone(
        name: 'Design Approval',
        percentage: '40%',
        whenDue: 'After design/architecture approval',
        deliverables: ['Approved UI/UX designs', 'Technical architecture document', 'Development starts'],
        accentColor: Color(0xFFF59E0B), // Gold
      ),
      PaymentMilestone(
        name: 'Final Delivery',
        percentage: '30%',
        whenDue: 'Upon project completion',
        deliverables: [
          'Complete source code',
          'Deployment to stores/hosting',
          'Documentation',
          'Support period begins',
        ],
        accentColor: Color(0xFF10B981), // Green
      ),
    ];
  }
}

class PaymentMethod {
  final String name;
  final String icon;
  final String description;
  final bool isPreferred;
  final Color accentColor;

  PaymentMethod({
    required this.name,
    required this.icon,
    required this.description,
    this.isPreferred = false,
    required this.accentColor,
  });

  /// Get all payment methods
  static List<PaymentMethod> getAllMethods() {
    return [
      PaymentMethod(
        name: 'Bank Transfer',
        icon: '🏦',
        description: 'Preferred - no fees',
        isPreferred: true,
        accentColor: Color(0xFF10B981), // Green
      ),
      PaymentMethod(
        name: 'PayPal',
        icon: '💳',
        description: 'International clients',
        accentColor: Color(0xFF3B82F6), // Blue
      ),
      PaymentMethod(
        name: 'Wise/TransferWise',
        icon: '💸',
        description: 'Low fees',
        accentColor: Color(0xFF8B5CF6), // Purple
      ),
      PaymentMethod(
        name: 'Cryptocurrency',
        icon: '₿',
        description: 'Bitcoin, USDT - for \$10K+ projects',
        accentColor: Color(0xFFF59E0B), // Gold
      ),
      PaymentMethod(
        name: 'Payoneer',
        icon: '💼',
        description: 'Business transactions',
        accentColor: Color(0xFFEC4899), // Pink
      ),
    ];
  }
}

class PaymentPolicy {
  final String title;
  final String icon;
  final List<String> points;
  final Color accentColor;

  PaymentPolicy({required this.title, required this.icon, required this.points, required this.accentColor});

  /// Get all payment policies
  static List<PaymentPolicy> getAllPolicies() {
    return [
      PaymentPolicy(
        title: 'Refund Policy',
        icon: '🔄',
        accentColor: Color(0xFF10B981), // Green
        points: [
          '100% refund if work hasn\'t started (before day 1)',
          '50% refund if only design phase completed (before development)',
          'No refund after development begins (milestone-based ensures fairness)',
        ],
      ),
      PaymentPolicy(
        title: 'Late Payment',
        icon: '⚠️',
        accentColor: Color(0xFFF59E0B),
        points: [
          'Work pauses if milestone payment delayed 7+ days',
          '5% late fee after 14 days',
          'Contract termination possible after 30 days',
        ],
      ),
      PaymentPolicy(
        title: 'Currency & Invoicing',
        icon: '💵',
        accentColor: Color(0xFF3B82F6),
        points: [
          'All prices in USD (\$)',
          'Can invoice in BDT (৳) for local clients at current exchange rates',
          'Professional invoice sent for each milestone',
          'GST/VAT included where applicable',
        ],
      ),
      PaymentPolicy(
        title: 'Enterprise Terms',
        icon: '🏢',
        accentColor: Color(0xFF8B5CF6),
        points: [
          'Net-30 or Net-60 payment terms (for established companies)',
          'Purchase Order (PO) acceptance',
          'Retainer agreements for ongoing work',
          'Volume discounts for multiple projects',
        ],
      ),
    ];
  }
}
