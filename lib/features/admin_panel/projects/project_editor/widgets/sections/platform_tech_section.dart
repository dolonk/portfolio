import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';

class PlatformTechSection extends StatelessWidget {
  final List<String> selectedPlatforms;
  final List<String> selectedTechStack;
  final ValueChanged<List<String>> onPlatformsChanged;
  final ValueChanged<List<String>> onTechStackChanged;

  const PlatformTechSection({
    super.key,
    required this.selectedPlatforms,
    required this.selectedTechStack,
    required this.onPlatformsChanged,
    required this.onTechStackChanged,
  });

  static const List<String> availablePlatforms = ['iOS', 'Android', 'Web', 'Windows', 'macOS', 'Linux'];

  static const List<String> availableTechStack = [
    'Flutter',
    'Dart',
    'Firebase',
    'Supabase',
    'Provider',
    'BLoC',
    'Riverpod',
    'GetX',
    'REST API',
    'GraphQL',
    'SQLite',
    'Hive',
    'Shared Preferences',
    'Go Router',
    'Dio',
    'WebSocket',
    'Google Maps',
    'Push Notifications',
    'OAuth',
    'Payment Gateway',
  ];

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

          // Platform Selection
          _buildPlatformSelection(context, s),
          SizedBox(height: s.paddingLg),

          Divider(color: DColors.cardBorder),
          SizedBox(height: s.paddingLg),

          // Tech Stack Selection
          _buildTechStackSelection(context, s),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.layers_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Platform & Technology',
          style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildPlatformSelection(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Platforms',
            style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red.shade400),
              ),
            ],
          ),
        ),
        SizedBox(height: s.paddingSm),
        Text(
          'Select all platforms where this project runs',
          style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
        ),
        SizedBox(height: s.paddingMd),

        // Platform Checkboxes
        Wrap(
          spacing: s.paddingMd,
          runSpacing: s.paddingMd,
          children: availablePlatforms.map((platform) {
            final isSelected = selectedPlatforms.contains(platform);
            return _buildCheckboxTile(
              context,
              s,
              label: platform,
              isSelected: isSelected,
              onTap: () {
                final updated = List<String>.from(selectedPlatforms);
                if (isSelected) {
                  updated.remove(platform);
                } else {
                  updated.add(platform);
                }
                onPlatformsChanged(updated);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTechStackSelection(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Tech Stack',
            style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red.shade400),
              ),
            ],
          ),
        ),
        SizedBox(height: s.paddingSm),
        Text(
          'Select technologies used in this project',
          style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
        ),
        SizedBox(height: s.paddingMd),

        // Tech Stack Chips
        Wrap(
          spacing: s.paddingSm,
          runSpacing: s.paddingSm,
          children: availableTechStack.map((tech) {
            final isSelected = selectedTechStack.contains(tech);
            return _buildTechChip(
              context,
              s,
              label: tech,
              isSelected: isSelected,
              onTap: () {
                final updated = List<String>.from(selectedTechStack);
                if (isSelected) {
                  updated.remove(tech);
                } else {
                  updated.add(tech);
                }
                onTechStackChanged(updated);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckboxTile(
    BuildContext context,
    DSizes s, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s.borderRadiusSm),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
        decoration: BoxDecoration(
          color: isSelected ? DColors.primaryButton.withAlpha((255 * 0.1).round()) : DColors.background,
          borderRadius: BorderRadius.circular(s.borderRadiusSm),
          border: Border.all(
            color: isSelected ? DColors.primaryButton : DColors.cardBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? DColors.primaryButton : Colors.transparent,
                border: Border.all(color: isSelected ? DColors.primaryButton : DColors.cardBorder, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected ? Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
            SizedBox(width: s.paddingSm),
            Text(
              label,
              style: context.fonts.bodyMedium.rubik(
                color: isSelected ? DColors.primaryButton : DColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechChip(
    BuildContext context,
    DSizes s, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s.borderRadiusSm),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
        decoration: BoxDecoration(
          color: isSelected ? DColors.primaryButton : DColors.background,
          borderRadius: BorderRadius.circular(s.borderRadiusSm),
          border: Border.all(color: isSelected ? DColors.primaryButton : DColors.cardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.fonts.bodySmall.rubik(
                color: isSelected ? Colors.white : DColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (isSelected) ...[SizedBox(width: 4), Icon(Icons.check_circle, size: 14, color: Colors.white)],
          ],
        ),
      ),
    );
  }
}
