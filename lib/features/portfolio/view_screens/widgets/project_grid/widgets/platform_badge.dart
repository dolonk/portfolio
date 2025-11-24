import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';

class PlatformBadge extends StatelessWidget {
  final String platform;

  const PlatformBadge({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    final platformData = _getPlatformData(platform);

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: platformData['color'].withAlpha((255 * 0.15).round()),
        shape: BoxShape.circle,
        border: Border.all(color: platformData['color'].withAlpha((255 * 0.3).round()), width: 1.5),
      ),
      child: Icon(platformData['icon'], size: 16, color: platformData['color']),
    );
  }

  /// Get platform icon and color
  Map<String, dynamic> _getPlatformData(String platform) {
    switch (platform.toLowerCase()) {
      case 'ios':
        return {'icon': Icons.apple, 'color': const Color(0xFF000000)};
      case 'android':
        return {'icon': Icons.android_rounded, 'color': const Color(0xFF3DDC84)};
      case 'web':
        return {'icon': Icons.language_rounded, 'color': const Color(0xFF4285F4)};
      case 'windows':
        return {'icon': Icons.window_rounded, 'color': const Color(0xFF0078D4)};
      case 'macos':
        return {'icon': Icons.laptop_mac_rounded, 'color': const Color(0xFF000000)};
      default:
        return {'icon': Icons.devices_rounded, 'color': DColors.primaryButton};
    }
  }
}
