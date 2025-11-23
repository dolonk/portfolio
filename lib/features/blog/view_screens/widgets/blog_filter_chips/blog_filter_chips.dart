import 'package:flutter/material.dart';
import '../../../view_models/blog_view_model.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/section_container.dart';

class BlogFilterChips extends StatelessWidget {
  const BlogFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    // Get both ViewModels
    final blogViewModel = BlogViewModel(context);
    final filterViewModel = BlogViewModel(context);

    final s = context.sizes;
    final tags = blogViewModel.allTags;
    final selectedTag = blogViewModel.selectedTag;

    // Hide if no tags
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with clear button
          _buildHeader(context, s, filterViewModel),

          SizedBox(height: s.paddingSm),

          // Filter Chips
          Wrap(
            spacing: s.paddingSm,
            runSpacing: s.paddingSm,
            children: [
              // "All" chip
              _FilterChip(label: 'All', isSelected: selectedTag == null, onTap: () => blogViewModel.filterByTag(null)),

              // Tag chips
              ...tags.map(
                (tag) => _FilterChip(
                  label: tag,
                  isSelected: selectedTag == tag,
                  count: blogViewModel.getPostCountByTag(tag),
                  onTap: () => blogViewModel.filterByTag(tag),
                ),
              ),
            ],
          ),

          // Active filter summary (optional)
          if (filterViewModel.hasActiveFilters) ...[
            SizedBox(height: s.paddingSm),
            _buildFilterSummary(context, s, filterViewModel),
          ],
        ],
      ),
    );
  }

  /// Build header with label and clear button
  Widget _buildHeader(BuildContext context, DSizes s, BlogViewModel filterViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Label
        Text('Filter by topic:', style: context.fonts.labelLarge.rubik(color: DColors.textSecondary)),

        // Clear filters button (only show if filters active)
        if (filterViewModel.hasActiveFilters)
          TextButton.icon(
            onPressed: () => filterViewModel.clearFilters(),
            icon: Icon(Icons.clear_all_rounded, size: 18, color: DColors.primaryButton),
            label: Text(
              'Clear',
              style: context.fonts.labelSmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: s.paddingSm / 2),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
      ],
    );
  }

  /// Build filter summary
  Widget _buildFilterSummary(BuildContext context, DSizes s, BlogViewModel filterViewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusSm),
        border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round())),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.filter_alt_rounded, size: 16, color: DColors.primaryButton),
          SizedBox(width: s.paddingSm / 2),
          Flexible(
            child: Text(
              filterViewModel.getFilterSummaryText(),
              style: context.fonts.labelSmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Filter Chip Widget
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final int? count;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isSelected, this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s.borderRadiusLg),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
        decoration: BoxDecoration(
          color: isSelected ? DColors.primaryButton : DColors.cardBackground,
          borderRadius: BorderRadius.circular(s.borderRadiusLg),
          border: Border.all(color: isSelected ? DColors.primaryButton : DColors.cardBorder, width: 1),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label
            Text(
              label,
              style: fonts.labelMedium.rubik(
                color: isSelected ? Colors.white : DColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),

            // Count badge (optional)
            if (count != null && count! > 0) ...[
              SizedBox(width: s.paddingSm / 2),
              Container(
                padding: EdgeInsets.symmetric(horizontal: s.paddingSm / 1.5, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white.withAlpha((255 * 0.3).round()) : DColors.cardBorder,
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                ),
                child: Text(
                  '$count',
                  style: fonts.labelSmall.rubik(
                    color: isSelected ? Colors.white : DColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
