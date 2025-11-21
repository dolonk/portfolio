import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/data_layer/model/portfolio/project_model.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

import '../../../../../route/route_name.dart';

class RelatedProjectCard extends StatefulWidget {
  final ProjectModel project;

  const RelatedProjectCard({super.key, required this.project});

  @override
  State<RelatedProjectCard> createState() => _RelatedProjectCardState();
}

class _RelatedProjectCardState extends State<RelatedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => context.go('${RouteNames.portfolio}/${widget.project.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -10.0 : 0.0),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: DColors.cardBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? Colors.black.withAlpha((255 * 0.15).round())
                    : Colors.black.withAlpha((255 * 0.05).round()),
                blurRadius: _isHovered ? 25 : 10,
                offset: Offset(0, _isHovered ? 12 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: Image.asset(
                    widget.project.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: DColors.cardBackground,
                        child: Center(child: Icon(Icons.image_rounded, size: 64, color: DColors.textSecondary)),
                      );
                    },
                  ),
                ),
              ),

              // Content (Title + Platforms)
              Padding(
                padding: EdgeInsets.all(s.paddingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Title
                    Text(
                      widget.project.title,
                      style: fonts.headlineSmall.rajdhani(
                        fontWeight: FontWeight.bold,
                        fontSize: context.responsiveValue(mobile: 18, tablet: 20, desktop: 22),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: s.paddingMd),

                    // Platform Badges
                    if (widget.project.platforms.isNotEmpty)
                      Wrap(
                        spacing: s.paddingSm,
                        runSpacing: s.paddingSm,
                        children: widget.project.platforms
                            .map((platform) => _PlatformBadge(platform: platform))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Platform Badge (Simple Pill)
class _PlatformBadge extends StatelessWidget {
  final String platform;

  const _PlatformBadge({required this.platform});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final platformData = _getPlatformData(platform);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: platformData['color'].withAlpha((255 * 0.15).round()),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: platformData['color'].withAlpha((255 * 0.3).round()), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(platformData['icon'], size: 14, color: platformData['color']),
          SizedBox(width: s.paddingSm),
          Text(
            platform,
            style: fonts.labelSmall.rubik(color: platformData['color'], fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
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
      case 'linux':
        return {'icon': Icons.computer_rounded, 'color': const Color(0xFFFCC624)};
      default:
        return {'icon': Icons.devices_rounded, 'color': DColors.primaryButton};
    }
  }
}
