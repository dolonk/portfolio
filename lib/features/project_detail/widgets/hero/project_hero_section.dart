import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/route/route_name.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class ProjectHeroSection extends StatelessWidget {
  final ProjectModel project;

  const ProjectHeroSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SizedBox(
      width: double.infinity,
      height: context.responsiveValue(
        mobile: ResponsiveHelper.getHeight(context) * 0.2,
        tablet: ResponsiveHelper.getHeight(context) * 0.3,
        desktop: ResponsiveHelper.getHeight(context) * 0.4,
      ),
      child: Stack(
        children: [
          // Background Project Image
          _buildBackgroundImage(),

          // Dark Gradient Overlay
          _buildGradientOverlay(),

          // Back Button (Top-Left)
          Positioned(top: 2, left: s.paddingLg, child: _buildBackButton(context, s)),

          // Platform Badges (Bottom-Left)
          if (project.platforms.isNotEmpty)
            Positioned(bottom: s.paddingLg, left: s.paddingLg, child: _buildPlatformBadges(s)),
        ],
      ),
    );
  }

  /// Background Project Image
  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: Image.asset(
        project.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Placeholder if image not found
          return Container(
            color: DColors.cardBackground,
            child: Center(child: Icon(Icons.image_rounded, size: 100, color: DColors.textSecondary)),
          );
        },
      ),
    );
  }

  /// Dark Gradient Overlay (Bottom to Top)
  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withAlpha((255 * 0.7).round()),
              Colors.black.withAlpha((255 * 0.3).round()),
              Colors.black.withAlpha((255 * 0.1).round()),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }

  /// Back Button (Icon + Text)
  Widget _buildBackButton(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.go(RouteNames.portfolio);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha((255 * 0.5).round()),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withAlpha((255 * 0.3).round()), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                'Back to Portfolio',
                style: fonts.labelLarge.rubik(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Platform Badges (Bottom-Left Overlay)
  Widget _buildPlatformBadges(DSizes s) {
    return Wrap(
      spacing: s.paddingSm,
      runSpacing: s.paddingSm,
      children: project.platforms.map((platform) {
        return _PlatformBadge(platform: platform);
      }).toList(),
    );
  }
}

/// Platform Badge Widget (Reusable)
class _PlatformBadge extends StatelessWidget {
  final String platform;

  const _PlatformBadge({required this.platform});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final platformData = _getPlatformData(platform);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha((255 * 0.6).round()),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: platformData['color'].withAlpha((255 * 0.5).round()), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(platformData['icon'], size: 16, color: platformData['color']),
          SizedBox(width: s.paddingSm),
          Text(
            platform,
            style: context.fonts.labelSmall.rubik(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// Get platform icon and color
  Map<String, dynamic> _getPlatformData(String platform) {
    switch (platform.toLowerCase()) {
      case 'ios':
        return {
          'icon': Icons.apple,
          'color': const Color(0xFFFFFFFF), // White
        };
      case 'android':
        return {
          'icon': Icons.android_rounded,
          'color': const Color(0xFF3DDC84), // Android green
        };
      case 'web':
        return {
          'icon': Icons.language_rounded,
          'color': const Color(0xFF4285F4), // Blue
        };
      case 'windows':
        return {
          'icon': Icons.window_rounded,
          'color': const Color(0xFF0078D4), // Windows blue
        };
      case 'macos':
        return {
          'icon': Icons.laptop_mac_rounded,
          'color': const Color(0xFFFFFFFF), // White
        };
      case 'linux':
        return {
          'icon': Icons.computer_rounded,
          'color': const Color(0xFFFCC624), // Yellow
        };
      default:
        return {'icon': Icons.devices_rounded, 'color': DColors.primaryButton};
    }
  }
}
