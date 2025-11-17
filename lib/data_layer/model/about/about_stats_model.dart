import 'package:flutter/material.dart';

class AboutStatsModel {
  final String value;
  final String label;
  final IconData icon;
  final Color accentColor;

  AboutStatsModel({required this.value, required this.label, required this.icon, required this.accentColor});

  /// Get all stats for About Hero Section
  static List<AboutStatsModel> getAllStats() {
    return [
      AboutStatsModel(
        value: '2+',
        label: 'Years Experience',
        icon: Icons.work_history_rounded,
        accentColor: const Color(0xFF8B5CF6), // Purple
      ),
      AboutStatsModel(
        value: '10+',
        label: 'Projects Completed',
        icon: Icons.folder_rounded,
        accentColor: const Color(0xFF3B82F6), // Blue
      ),
      AboutStatsModel(
        value: '2',
        label: 'Live Apps, play & app store',
        icon: Icons.smartphone_rounded,
        accentColor: const Color(0xFF10B981), // Green
      ),
      AboutStatsModel(
        value: '15+',
        label: 'Technologies',
        icon: Icons.code_rounded,
        accentColor: const Color(0xFFF59E0B), // Orange
      ),
    ];
  }
}
