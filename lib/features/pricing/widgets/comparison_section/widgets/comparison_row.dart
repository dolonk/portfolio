import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/pricing/comparison_feature_model.dart';

class ComparisonRow extends StatelessWidget {
  final ComparisonRowModel row;
  final Color accentColor;

  const ComparisonRow({super.key, required this.row, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(vertical: s.paddingSm, horizontal: s.paddingMd),
      decoration: BoxDecoration(color: DColors.background, borderRadius: BorderRadius.circular(s.borderRadiusSm)),
      child: Row(
        children: [
          // Feature Name
          Expanded(
            flex: 2,
            child: Text(
              row.feature,
              style: fonts.bodyMedium.rubik(
                fontSize: context.responsiveValue(mobile: 12, tablet: 13, desktop: 14),
                color: DColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Starter Value
          Expanded(flex: 1, child: _buildValue(row.starter, row.starterIncluded, fonts, s)),

          // Pro Value (Highlighted)
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: s.paddingSm / 2, horizontal: s.paddingSm),
              decoration: BoxDecoration(
                color: Color(0xFFF59E0B).withAlpha((255 * 0.4).round()),
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
              ),
              child: _buildValue(row.pro, row.proIncluded, fonts, s, isHighlighted: true),
            ),
          ),

          // Enterprise Value
          Expanded(flex: 1, child: _buildValue(row.enterprise, row.enterpriseIncluded, fonts, s)),
        ],
      ),
    );
  }

  Widget _buildValue(String value, bool isIncluded, DFontSizes fonts, DSizes s, {bool isHighlighted = false}) {
    return Center(
      child: Text(
        value,
        style: fonts.bodySmall.rubik(
          color: isIncluded
              ? (isHighlighted ? Color(0xFFF59E0B) : DColors.textPrimary)
              : DColors.textSecondary.withAlpha((255 * 0.6).round()),
          fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
