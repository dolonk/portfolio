import 'package:flutter/material.dart';

enum AvailabilityStatus { available, limited, unavailable }

class AvailabilityStatusModel {
  final AvailabilityStatus status;
  final String statusText;
  final String description;
  final String? nextAvailableDate;
  final Color statusColor;
  final IconData icon;

  AvailabilityStatusModel({
    required this.status,
    required this.statusText,
    required this.description,
    this.nextAvailableDate,
    required this.statusColor,
    required this.icon,
  });

  /// Get current availability status (Modify this to update your status)
  static AvailabilityStatusModel getCurrentStatus() {
    return AvailabilityStatusModel.available();
  }

  /// Available Status
  factory AvailabilityStatusModel.available() {
    return AvailabilityStatusModel(
      status: AvailabilityStatus.available,
      statusText: 'Available for New Projects',
      description: 'I\'m currently accepting new projects and ready to start immediately',
      nextAvailableDate: null,
      statusColor: const Color(0xFF10B981),
      icon: Icons.check_circle_rounded,
    );
  }

  /// Limited Availability
  factory AvailabilityStatusModel.limited({String? nextDate}) {
    return AvailabilityStatusModel(
      status: AvailabilityStatus.limited,
      statusText: 'Limited Availability',
      description: 'I have limited capacity for new projects at the moment',
      nextAvailableDate: nextDate ?? 'December 2025',
      statusColor: const Color(0xFFF59E0B),
      icon: Icons.schedule_rounded,
    );
  }

  /// Unavailable
  factory AvailabilityStatusModel.unavailable({String? nextDate}) {
    return AvailabilityStatusModel(
      status: AvailabilityStatus.unavailable,
      statusText: 'Currently Unavailable',
      description: 'My schedule is fully booked at the moment',
      nextAvailableDate: nextDate ?? 'January 2026',
      statusColor: const Color(0xFFEF4444),
      icon: Icons.cancel_rounded,
    );
  }
}
