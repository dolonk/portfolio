import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/pricing/pricing_faq_model.dart';

class FaqCategoryTabs extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const FaqCategoryTabs({super.key, required this.selectedCategory, required this.onCategoryChanged});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final categories = PricingFaqModel.getAllCategories();

    return Center(
      child: Wrap(
        spacing: s.paddingSm,
        runSpacing: s.paddingSm,
        alignment: WrapAlignment.center,
        children: categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;

          return _CategoryChip(
            category: category,
            isSelected: selectedCategory == category,
            onTap: () => onCategoryChanged(category),
            delay: index * 80,
          );
        }).toList(),
      ),
    );
  }
}

class _CategoryChip extends StatefulWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;
  final int delay;

  const _CategoryChip({required this.category, required this.isSelected, required this.onTap, this.delay = 0});

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> {
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
                    : (_isHovered ? DColors.primaryButton.withAlpha(25) : DColors.cardBackground),
                borderRadius: BorderRadius.circular(s.borderRadiusLg),
                border: Border.all(
                  color: widget.isSelected
                      ? DColors.primaryButton
                      : (_isHovered ? DColors.primaryButton : DColors.cardBorder),
                  width: widget.isSelected ? 2 : 1,
                ),
                boxShadow: widget.isSelected
                    ? [BoxShadow(color: DColors.primaryButton.withAlpha(76), blurRadius: 12, offset: Offset(0, 4))]
                    : null,
              ),
              child: Text(
                widget.category,
                style: fonts.bodyMedium.rubik(
                  fontSize: context.responsiveValue(mobile: 13, tablet: 14, desktop: 14),
                  fontWeight: FontWeight.w600,
                  color: widget.isSelected ? Colors.white : DColors.textPrimary,
                ),
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: 600 + widget.delay))
        .fadeIn(duration: 600.ms)
        .scale(begin: Offset(0.8, 0.8), duration: 600.ms);
  }
}
