import 'widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class ProjectOverviewSection extends StatelessWidget {
  final ProjectModel project;

  const ProjectOverviewSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Name with Underline
            _buildProjectName(context, s),
            SizedBox(height: s.spaceBtwSections),

            // Two-Column Layout (Responsive)
            context.isDesktop ? _buildDesktopLayout(context, s) : _buildMobileTabletLayout(context, s),
          ],
        ),
      ),
    );
  }

  /// Project Name with Underline
  Widget _buildProjectName(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: fonts.displayMedium.rajdhani(
            fontSize: context.responsiveValue(mobile: 32, tablet: 40, desktop: 48),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: s.paddingSm),
        Container(
          height: 4,
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [DColors.primaryButton, DColors.primaryButton.withAlpha((255 * 0.5).round())],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  /// Desktop Layout - Two Columns Side by Side
  Widget _buildDesktopLayout(BuildContext context, DSizes s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Info Cards
        SizedBox(width: 350, child: _buildInfoCards(context, s)),
        SizedBox(width: s.spaceBtwSections),

        // Right Column: Description
        Expanded(child: _buildDescription(context, s)),
      ],
    );
  }

  /// Mobile/Tablet Layout - Stacked Vertically
  Widget _buildMobileTabletLayout(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info Cards
        _buildInfoCards(context, s),
        SizedBox(height: s.spaceBtwSections),

        // Description
        _buildDescription(context, s),
      ],
    );
  }

  /// Info Cards Column
  Widget _buildInfoCards(BuildContext context, DSizes s) {
    return Column(
      children: [
        // Launch Date Card
        InfoCard(
          icon: Icons.calendar_today_rounded,
          label: 'Launch Date',
          value: project.launchDate,
          iconColor: const Color(0xFF3B82F6),
        ),
        SizedBox(height: s.spaceBtwItems),

        // Platforms Card
        _buildPlatformsCard(context, s),
      ],
    );
  }

  /// Platforms Card with Badges
  Widget _buildPlatformsCard(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DColors.cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + Label
          Row(
            children: [
              Icon(
                Icons.devices_rounded,
                color: const Color(0xFF10B981), // Green
                size: 20,
              ),
              SizedBox(width: s.paddingSm),
              Text(
                'PLATFORMS',
                style: fonts.labelSmall.rubik(
                  color: DColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Platform Badges
          Wrap(
            spacing: s.paddingSm,
            runSpacing: s.paddingSm,
            children: project.platforms.map((platform) {
              return _PlatformBadge(platform: platform);
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Description Content
  Widget _buildDescription(BuildContext context, DSizes s) {
    final fonts = context.fonts;
    final paragraphs = project.description.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "About This Project" Label
        Text('About This Project', style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold)),
        SizedBox(height: s.spaceBtwItems),

        // Description Paragraphs
        ...paragraphs.map((paragraph) {
          return Column(
            children: [
              Text(
                paragraph.trim(),
                style: fonts.bodyLarge.rubik(
                  color: DColors.textSecondary,
                  height: 1.8,
                  fontSize: context.responsiveValue(mobile: 15, tablet: 16, desktop: 17),
                ),
              ),
              SizedBox(height: s.spaceBtwItems),
            ],
          );
        }),
      ],
    );
  }
}

/// Platform Badge (Pill Style)
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: platformData['color'].withAlpha((255 * 0.4).round()), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(platformData['icon'], size: 16, color: platformData['color']),
          SizedBox(width: s.paddingSm),
          Text(
            platform,
            style: fonts.labelMedium.rubik(color: platformData['color'], fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// Get platform icon and color
  Map<String, dynamic> _getPlatformData(String platform) {
    switch (platform.toLowerCase()) {
      case 'ios':
        return {'icon': Icons.apple, 'color': const Color(0xFF8A1212)};
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
