import 'package:flutter/material.dart';

class ColorHelper {
  static Color fromHex(String? hexString) {
    if (hexString == null || hexString.isEmpty) {
      return const Color(0xFF6366F1);
    }

    try {
      // Remove # if present
      String hexColor = hexString.replaceAll('#', '').trim();

      // Validate hex string length
      if (hexColor.length != 6 && hexColor.length != 8) {
        return const Color(0xFF6366F1);
      }

      // Add alpha channel if not present (6 digit hex)
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }

      // Parse and return color
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      // Return default color on any error
      return const Color(0xFF6366F1);
    }
  }

  static Color fromHexWithAlpha(String? hexString, double alpha) {
    final color = fromHex(hexString);
    return color.withAlpha((255 * alpha.clamp(0.0, 1.0)).toInt());
  }

  static String toHex(Color color, {bool includeAlpha = false}) {
    if (includeAlpha) {
      return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    } else {
      return '#${color.toARGB32().toRadixString(16).substring(2).padLeft(6, '0').toUpperCase()}';
    }
  }

  /// Predefined color palette for fallback/default usage
  static const Map<String, Color> colorPalette = {
    'purple': Color(0xFF8B5CF6),
    'blue': Color(0xFF3B82F6),
    'green': Color(0xFF10B981),
    'red': Color(0xFFEF4444),
    'amber': Color(0xFFF59E0B),
    'pink': Color(0xFFEC4899),
    'cyan': Color(0xFF06B6D4),
    'indigo': Color(0xFF6366F1),
    'orange': Color(0xFFF97316),
    'teal': Color(0xFF14B8A6),
  };

  /// Get color from palette by name
  static Color fromPalette(String colorName) {
    return colorPalette[colorName.toLowerCase()] ?? colorPalette['indigo']!;
  }
}
