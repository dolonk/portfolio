import 'package:flutter/material.dart';

class ToolModel {
  final String name;
  final IconData icon;
  final Color iconColor;

  ToolModel({required this.name, required this.icon, required this.iconColor});
}

class ToolCategoryModel {
  final String categoryName;
  final IconData categoryIcon;
  final Color accentColor;
  final List<ToolModel> tools;

  ToolCategoryModel({
    required this.categoryName,
    required this.categoryIcon,
    required this.accentColor,
    required this.tools,
  });

  /// Get all tool categories
  static List<ToolCategoryModel> getAllCategories() {
    return [
      // Category 1: IDEs & Code Editors
      ToolCategoryModel(
        categoryName: 'IDEs & Code Editors',
        categoryIcon: Icons.code_rounded,
        accentColor: const Color(0xFF8B5CF6), // Purple
        tools: [
          ToolModel(name: 'VS Code', icon: Icons.code_rounded, iconColor: const Color(0xFF007ACC)),
          ToolModel(name: 'Android Studio', icon: Icons.android_rounded, iconColor: const Color(0xFF3DDC84)),
          ToolModel(name: 'Xcode', icon: Icons.apple_rounded, iconColor: const Color(0xFF147EFB)),
        ],
      ),

      // Category 2: Design Tools
      ToolCategoryModel(
        categoryName: 'Design Tools',
        categoryIcon: Icons.palette_rounded,
        accentColor: const Color(0xFFEC4899), // Pink
        tools: [
          ToolModel(name: 'Figma', icon: Icons.design_services_rounded, iconColor: const Color(0xFFF24E1E)),
          ToolModel(name: 'Adobe XD', icon: Icons.brush_rounded, iconColor: const Color(0xFFFF61F6)),
          ToolModel(name: 'Canva', icon: Icons.image_rounded, iconColor: const Color(0xFF00C4CC)),
        ],
      ),

      // Category 3: Development Tools
      ToolCategoryModel(
        categoryName: 'Development Tools',
        categoryIcon: Icons.build_rounded,
        accentColor: const Color(0xFF3B82F6), // Blue
        tools: [
          ToolModel(name: 'Git', icon: Icons.source_rounded, iconColor: const Color(0xFFF05032)),
          ToolModel(name: 'GitHub', icon: Icons.code_rounded, iconColor: const Color(0xFF220909)),
          ToolModel(name: 'Postman', icon: Icons.api_rounded, iconColor: const Color(0xFFFF6C37)),
          ToolModel(name: 'Firebase Console', icon: Icons.cloud_rounded, iconColor: const Color(0xFFFFCA28)),
        ],
      ),

      // Category 4: Project Management
      ToolCategoryModel(
        categoryName: 'Project Management',
        categoryIcon: Icons.assignment_rounded,
        accentColor: const Color(0xFF10B981), // Green
        tools: [
          ToolModel(name: 'Notion', icon: Icons.note_rounded, iconColor: const Color(0xFF61273C)),
          ToolModel(name: 'Trello', icon: Icons.dashboard_rounded, iconColor: const Color(0xFF0079BF)),
          ToolModel(name: 'Slack', icon: Icons.chat_bubble_rounded, iconColor: const Color(0xFF4A154B)),
        ],
      ),
    ];
  }
}
