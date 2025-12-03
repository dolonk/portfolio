import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/pricing/comparison_feature_model.dart';

class CategoryFilterTabs extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const CategoryFilterTabs({super.key, required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final categories = ComparisonCategory.getAllCategories();

    final filters = [
      {'id': 'all', 'label': 'All Features', 'emoji': '📊'},
      ...categories.map((c) => {'id': c.id, 'label': c.title.split(' ')[0], 'emoji': c.emoji}),
    ];

    return Center(
      child: Wrap(
        spacing: s.paddingSm,
        runSpacing: s.paddingSm,
        alignment: WrapAlignment.center,
        children: filters.asMap().entries.map((entry) {
          final index = entry.key;
          final filter = entry.value;
          final isSelected = selectedFilter == filter['id'];

          return _FilterChip(
            label: filter['label'] as String,
            emoji: filter['emoji'] as String,
            isSelected: isSelected,
            onTap: () => onFilterChanged(filter['id'] as String),
            delay: index * 100,
          );
        }).toList(),
      ),
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;
  final int delay;

  const _FilterChip({
    required this.label,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
    this.delay = 0,
  });

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveValue(mobile: s.paddingMd, desktop: s.paddingLg),
                vertical: s.paddingSm,
              ),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? DColors.primaryButton
                    : (_isHovered ? DColors.primaryButton.withAlpha((255 * 0.1).round()) : DColors.cardBackground),
                borderRadius: BorderRadius.circular(s.borderRadiusLg),
                border: Border.all(
                  color: widget.isSelected
                      ? DColors.primaryButton
                      : (_isHovered ? DColors.primaryButton : DColors.cardBorder),
                  width: widget.isSelected ? 2 : 1,
                ),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.emoji,
                    style: TextStyle(fontSize: context.responsiveValue(mobile: 16, tablet: 18, desktop: 18)),
                  ),
                  SizedBox(width: s.paddingSm),
                  Text(
                    widget.label,
                    style: fonts.bodyMedium.rubik(
                      fontWeight: FontWeight.w600,
                      color: widget.isSelected ? Colors.white : DColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: widget.delay))
        .fadeIn(duration: 600.ms)
        .scale(begin: Offset(0.8, 0.8), duration: 600.ms);
  }
}
