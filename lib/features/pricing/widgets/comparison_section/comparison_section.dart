import 'package:flutter/material.dart';
import 'widgets/category_filter_tabs.dart';
import 'widgets/comparison_category_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_website/data_layer/model/comparison_feature_model.dart';

class ComparisonSection extends StatefulWidget {
  const ComparisonSection({super.key});

  @override
  State<ComparisonSection> createState() => _ComparisonSectionState();
}

class _ComparisonSectionState extends State<ComparisonSection> {
  String _selectedFilter = 'all';
  final Map<String, bool> _expandedCategories = {};

  @override
  void initState() {
    super.initState();
    // First category expanded by default
    final categories = ComparisonCategory.getAllCategories();
    if (categories.isNotEmpty) {
      _expandedCategories[categories.first.id] = true;
    }
  }

  void _handleFilterChange(String filterId) {
    setState(() {
      _selectedFilter = filterId;

      // If specific category selected, expand it
      if (filterId != 'all') {
        _expandedCategories.clear();
        _expandedCategories[filterId] = true;
      }
    });
  }

  void _toggleCategory(String categoryId) {
    setState(() {
      _expandedCategories[categoryId] = !(_expandedCategories[categoryId] ?? false);
    });
  }

  void _expandAll() {
    setState(() {
      final categories = ComparisonCategory.getAllCategories();
      for (var category in categories) {
        _expandedCategories[category.id] = true;
      }
    });
  }

  void _collapseAll() {
    setState(() {
      _expandedCategories.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final categories = ComparisonCategory.getAllCategories();

    // Filter categories if specific filter selected
    final displayedCategories = _selectedFilter == 'all'
        ? categories
        : categories.where((c) => c.id == _selectedFilter).toList();

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 1000, desktop: 1400),
          ),
          child: Column(
            children: [
              // Section Heading
              _buildSectionHeading(fonts, s),
              SizedBox(height: s.spaceBtwItems),

              // Filter Tabs
              CategoryFilterTabs(selectedFilter: _selectedFilter, onFilterChanged: _handleFilterChange),
              SizedBox(height: s.spaceBtwItems),

              // Expand/Collapse All Button
              if (!context.isMobile) _buildExpandCollapseButton(fonts, s),
              if (!context.isMobile) SizedBox(height: s.spaceBtwItems),

              // Category Cards
              _buildCategoryCards(displayedCategories, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(AppFonts fonts, DSizes s) {
    return Column(
      children: [
        Text(
          'Compare All Features',
          style: fonts.headlineLarge.rajdhani(
            fontSize: context.responsiveValue(mobile: 28, tablet: 32, desktop: 36),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms),
        SizedBox(height: s.paddingSm),
        Text(
          'See what\'s included in each package at a glance',
          style: fonts.bodyLarge.rubik(
            fontSize: context.responsiveValue(mobile: 14, tablet: 16, desktop: 18),
            color: DColors.textSecondary,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms),
      ],
    );
  }

  /// Expand/Collapse All Button
  Widget _buildExpandCollapseButton(AppFonts fonts, DSizes s) {
    final allExpanded =
        _expandedCategories.values.where((v) => v).length == ComparisonCategory.getAllCategories().length;

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: allExpanded ? _collapseAll : _expandAll,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round()), width: 1),
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                allExpanded ? Icons.unfold_less_rounded : Icons.unfold_more_rounded,
                color: DColors.primaryButton,
                size: 18,
              ),
              SizedBox(width: s.paddingSm),
              Text(
                allExpanded ? 'Collapse All' : 'Expand All',
                style: fonts.bodyMedium.rubik(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: DColors.primaryButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Category Cards List
  Widget _buildCategoryCards(List<ComparisonCategory> categories, DSizes s) {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) =>
              SlideAnimation(verticalOffset: 50.0, child: FadeInAnimation(child: widget)),
          children: categories.map((category) {
            final isExpanded = _expandedCategories[category.id] ?? false;

            return Padding(
              padding: EdgeInsets.only(bottom: s.spaceBtwItems),
              child: ComparisonCategoryCard(
                category: category,
                isExpanded: isExpanded,
                onToggle: () => _toggleCategory(category.id),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
