import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/pricing/pricing_tier_model.dart';

class FeaturesExpandable extends StatefulWidget {
  final PricingTierModel tier;

  const FeaturesExpandable({super.key, required this.tier});

  @override
  State<FeaturesExpandable> createState() => _FeaturesExpandableState();
}

class _FeaturesExpandableState extends State<FeaturesExpandable> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final remainingFeatures = widget.tier.features.skip(5).toList();

    if (remainingFeatures.isEmpty) return SizedBox.shrink();

    return Column(
      children: [
        // View All Button
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
            decoration: BoxDecoration(
              border: Border.all(color: widget.tier.accentColor.withAlpha((255 * 0.3).round()), width: 1),
              borderRadius: BorderRadius.circular(s.borderRadiusMd),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isExpanded ? 'Hide Features' : 'View All Features',
                  style: fonts.bodyMedium.rubik(
                    fontSize: context.responsiveValue(mobile: 13, tablet: 14, desktop: 14),
                    fontWeight: FontWeight.w600,
                    color: widget.tier.accentColor,
                  ),
                ),
                SizedBox(width: s.paddingSm),
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: widget.tier.accentColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),

        // Expanded Features List
        if (_isExpanded) ...[
          SizedBox(height: s.paddingMd),
          ...remainingFeatures.map((feature) {
            return Padding(
              padding: EdgeInsets.only(bottom: s.paddingSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    feature.isIncluded ? Icons.check_circle_rounded : Icons.cancel_rounded,
                    color: feature.isIncluded
                        ? widget.tier.accentColor
                        : DColors.textSecondary.withAlpha((255 * 0.5).round()),
                    size: context.responsiveValue(mobile: 16, tablet: 18, desktop: 18),
                  ),
                  SizedBox(width: s.paddingSm),
                  Expanded(
                    child: Text(
                      feature.text,
                      style: fonts.bodySmall.rubik(
                        color: feature.isIncluded
                            ? DColors.textPrimary
                            : DColors.textSecondary.withAlpha((255 * 0.5).round()),
                        decoration: feature.isIncluded ? null : TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }
}
