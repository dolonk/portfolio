import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';

class PublishingSection extends StatelessWidget {
  final bool isPublished;
  final bool isFeatured;
  final ValueChanged<bool> onPublishedChanged;
  final ValueChanged<bool> onFeaturedChanged;

  const PublishingSection({
    super.key,
    required this.isPublished,
    required this.isFeatured,
    required this.onPublishedChanged,
    required this.onFeaturedChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(context),
          SizedBox(height: s.paddingLg),

          // Published Toggle
          _buildToggleTile(
            context,
            s,
            title: 'Publish Project',
            subtitle: 'Make this project visible on your portfolio',
            value: isPublished,
            onChanged: onPublishedChanged,
            icon: Icons.visibility_rounded,
          ),
          SizedBox(height: s.paddingMd),

          // Featured Toggle
          _buildToggleTile(
            context,
            s,
            title: 'Featured Project',
            subtitle: 'Show this project in the featured section',
            value: isFeatured,
            onChanged: onFeaturedChanged,
            icon: Icons.star_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.publish_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Publishing Options',
          style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildToggleTile(
    BuildContext context,
    DSizes s, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: value ? DColors.primaryButton.withAlpha((255 * 0.05).round()) : DColors.background,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(
          color: value ? DColors.primaryButton.withAlpha((255 * 0.3).round()) : DColors.cardBorder,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(s.paddingSm),
            decoration: BoxDecoration(
              color: value
                  ? DColors.primaryButton.withAlpha((255 * 0.1).round())
                  : DColors.cardBorder.withAlpha((255 * 0.3).round()),
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
            ),
            child: Icon(icon, color: value ? DColors.primaryButton : DColors.textSecondary, size: 20),
          ),
          SizedBox(width: s.paddingMd),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.fonts.bodyMedium.rubik(
                    fontWeight: FontWeight.w600,
                    color: DColors.textPrimary,
                  ),
                ),
                Text(subtitle, style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
              ],
            ),
          ),

          // Switch
          Switch(value: value, onChanged: onChanged, activeThumbColor: DColors.primaryButton),
        ],
      ),
    );
  }
}
