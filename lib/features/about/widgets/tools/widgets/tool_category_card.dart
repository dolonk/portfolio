import 'package:flutter/material.dart';
import 'package:portfolio/data_layer/model/about/tool_model.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

import 'tool_icon.dart';

class ToolCategoryCard extends StatelessWidget {
  final ToolCategoryModel category;

  const ToolCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg)),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: category.accentColor.withAlpha((255 * 0.3).round()), width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha((255 * 0.05).round()), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header
          _buildCategoryHeader(context, s, fonts),
          SizedBox(height: s.spaceBtwItems),

          // Divider
          Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [category.accentColor, category.accentColor.withAlpha(0)]),
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Tool Icons Grid
          _buildToolsGrid(s),
        ],
      ),
    );
  }

  /// Category Header
  Widget _buildCategoryHeader(BuildContext context, DSizes s, AppFonts fonts) {
    return Row(
      children: [
        // Category Icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: category.accentColor.withAlpha((255 * 0.15).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
          ),
          child: Icon(category.categoryIcon, color: category.accentColor, size: 22),
        ),
        SizedBox(width: s.paddingMd),

        // Category Name
        Expanded(
          child: Text(
            category.categoryName,
            style: fonts.headlineSmall.rajdhani(
              fontSize: context.responsiveValue(mobile: 18.0, tablet: 20.0, desktop: 22.0),
              fontWeight: FontWeight.bold,
              color: DColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  /// Tools Grid
  Widget _buildToolsGrid(DSizes s) {
    return Wrap(
      spacing: s.paddingMd,
      runSpacing: s.paddingMd,
      children: List.generate(category.tools.length, (index) => ToolIcon(tool: category.tools[index])),
    );
  }
}
