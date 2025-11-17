import 'comparison_row.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import '../../../../../data_layer/model/pricing/comparison_feature_model.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class ComparisonCategoryCard extends StatefulWidget {
  final ComparisonCategory category;
  final bool isExpanded;
  final VoidCallback onToggle;

  const ComparisonCategoryCard({
    super.key,
    required this.category,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  State<ComparisonCategoryCard> createState() => _ComparisonCategoryCardState();
}

class _ComparisonCategoryCardState extends State<ComparisonCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: DColors.cardBackground,
          borderRadius: BorderRadius.circular(s.borderRadiusLg),
          border: Border.all(
            color: widget.isExpanded
                ? widget.category.accentColor
                : (_isHovered ? DColors.primaryButton : DColors.cardBorder),
            width: widget.isExpanded ? 2 : 1,
          ),
          boxShadow: widget.isExpanded
              ? [
                  BoxShadow(
                    color: widget.category.accentColor.withAlpha((255 * 0.2).round()),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            // Header (Always visible)
            _buildHeader(fonts, s),

            // Expanded Content
            if (widget.isExpanded) ...[
              Divider(color: DColors.cardBorder, height: 1),
              _buildExpandedContent(s),
            ],
          ],
        ),
      ),
    );
  }

  /// Category Header
  Widget _buildHeader(AppFonts fonts, DSizes s) {
    return InkWell(
      onTap: widget.onToggle,
      borderRadius: BorderRadius.circular(s.borderRadiusLg),
      child: Padding(
        padding: EdgeInsets.all(s.paddingMd),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(s.paddingMd),
              decoration: BoxDecoration(
                color: widget.category.accentColor.withAlpha((255 * 0.1).round()),
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
              ),
              child: Text(
                widget.category.emoji,
                style: TextStyle(fontSize: context.responsiveValue(mobile: 24, tablet: 28, desktop: 28)),
              ),
            ),
            SizedBox(width: s.paddingMd),

            // Title
            Expanded(
              child: Text(
                widget.category.title,
                style: fonts.titleLarge.rajdhani(
                  fontWeight: FontWeight.bold,
                  color: widget.isExpanded ? widget.category.accentColor : DColors.textPrimary,
                ),
              ),
            ),

            // Expand/Collapse Icon
            Icon(
              widget.isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              color: widget.category.accentColor,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  /// Expanded Content (Comparison Table)
  Widget _buildExpandedContent(DSizes s) {
    return Padding(
      padding: EdgeInsets.all(
        context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
      ),
      child: Column(
        children: [
          // Table Header
          _buildTableHeader(s),
          SizedBox(height: s.paddingMd),

          // Rows
          ...widget.category.rows.map((row) {
            return Padding(
              padding: EdgeInsets.only(bottom: s.paddingSm),
              child: ComparisonRow(row: row, accentColor: widget.category.accentColor),
            );
          }),
        ],
      ),
    );
  }

  /// Table Header (Starter | Pro | Enterprise)
  Widget _buildTableHeader(DSizes s) {
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(vertical: s.paddingSm, horizontal: s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.secondaryBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
      ),
      child: Row(
        children: [
          // Feature Column Header (Empty or "Feature")
          Expanded(
            flex: 2,
            child: Text(
              'Feature',
              style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: DColors.textSecondary),
            ),
          ),

          // Starter
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Starter',
                style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6)),
              ),
            ),
          ),

          // Pro
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Pro',
                style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: Color(0xFFF59E0B)),
              ),
            ),
          ),

          // Enterprise
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Enterprise',
                style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: Color(0xFF3B82F6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
