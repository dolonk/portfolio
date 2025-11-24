import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

enum CalloutType { tip, warning, note, success }

class CalloutBox extends StatelessWidget {
  final String text;
  final CalloutType type;

  const CalloutBox({super.key, required this.text, this.type = CalloutType.tip});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final config = _getConfig(type);

    return Container(
      margin: EdgeInsets.symmetric(vertical: s.paddingMd),
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: config['bgColor'],
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: config['borderColor'], width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(s.paddingSm),
            decoration: BoxDecoration(color: config['iconBgColor'], shape: BoxShape.circle),
            child: Icon(config['icon'], color: config['iconColor'], size: 20),
          ),
          SizedBox(width: s.paddingMd),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config['title'],
                  style: fonts.titleSmall.rajdhani(fontWeight: FontWeight.bold, color: config['titleColor']),
                ),
                SizedBox(height: 4),
                Text(text, style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getConfig(CalloutType type) {
    switch (type) {
      case CalloutType.tip:
        return {
          'icon': Icons.lightbulb_rounded,
          'title': '💡 Pro Tip',
          'bgColor': const Color(0xFF8B5CF6).withAlpha((255 * 0.1).round()),
          'borderColor': const Color(0xFF8B5CF6).withAlpha((255 * 0.5).round()),
          'iconColor': const Color(0xFF8B5CF6),
          'iconBgColor': const Color(0xFF8B5CF6).withAlpha((255 * 0.2).round()),
          'titleColor': const Color(0xFF8B5CF6),
        };
      case CalloutType.warning:
        return {
          'icon': Icons.warning_rounded,
          'title': '⚠️ Warning',
          'bgColor': const Color(0xFFF59E0B).withAlpha((255 * 0.1).round()),
          'borderColor': const Color(0xFFF59E0B).withAlpha((255 * 0.5).round()),
          'iconColor': const Color(0xFFF59E0B),
          'iconBgColor': const Color(0xFFF59E0B).withAlpha((255 * 0.2).round()),
          'titleColor': const Color(0xFFF59E0B),
        };
      case CalloutType.note:
        return {
          'icon': Icons.info_rounded,
          'title': '📝 Note',
          'bgColor': const Color(0xFF3B82F6).withAlpha((255 * 0.1).round()),
          'borderColor': const Color(0xFF3B82F6).withAlpha((255 * 0.5).round()),
          'iconColor': const Color(0xFF3B82F6),
          'iconBgColor': const Color(0xFF3B82F6).withAlpha((255 * 0.2).round()),
          'titleColor': const Color(0xFF3B82F6),
        };
      case CalloutType.success:
        return {
          'icon': Icons.check_circle_rounded,
          'title': '✅ Success',
          'bgColor': const Color(0xFF10B981).withAlpha((255 * 0.1).round()),
          'borderColor': const Color(0xFF10B981).withAlpha((255 * 0.5).round()),
          'iconColor': const Color(0xFF10B981),
          'iconBgColor': const Color(0xFF10B981).withAlpha((255 * 0.2).round()),
          'titleColor': const Color(0xFF10B981),
        };
    }
  }
}
