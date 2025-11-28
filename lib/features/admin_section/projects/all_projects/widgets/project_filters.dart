import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';

class ProjectFilters extends StatelessWidget {
  final String statusFilter;
  final String searchQuery;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onSearchChanged;

  const ProjectFilters({
    super.key,
    required this.statusFilter,
    required this.searchQuery,
    required this.onStatusChanged,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: isMobile
          ? Column(
              children: [
                _buildSearchField(context, s),
                SizedBox(height: s.paddingMd),
                _buildStatusFilter(context, s),
              ],
            )
          : Row(
              children: [
                Expanded(child: _buildSearchField(context, s)),
                SizedBox(width: s.paddingMd),
                _buildStatusFilter(context, s),
              ],
            ),
    );
  }

  /// Search Field
  Widget _buildSearchField(BuildContext context, DSizes s) {
    return TextField(
      onChanged: onSearchChanged,
      style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary),
      decoration: InputDecoration(
        hintText: 'Search projects...',
        hintStyle: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
        prefixIcon: Icon(Icons.search_rounded, color: DColors.textSecondary),
        filled: true,
        fillColor: DColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
          borderSide: BorderSide(color: DColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
          borderSide: BorderSide(color: DColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
          borderSide: BorderSide(color: DColors.primaryButton, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingMd),
      ),
    );
  }

  /// Status Filter
  Widget _buildStatusFilter(BuildContext context, DSizes s) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildFilterChip(context, s, 'all', 'All'),
        SizedBox(width: s.paddingSm),
        _buildFilterChip(context, s, 'published', 'Published'),
        SizedBox(width: s.paddingSm),
        _buildFilterChip(context, s, 'draft', 'Draft'),
      ],
    );
  }

  /// Filter Chip
  Widget _buildFilterChip(BuildContext context, DSizes s, String value, String label) {
    final isSelected = statusFilter == value;

    return InkWell(
      onTap: () => onStatusChanged(value),
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
        child: Text(
          label,
          style: context.fonts.bodyMedium.rubik(
            color: isSelected ? DColors.primaryButton : DColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
