import 'package:flutter/material.dart';
import '../../../../../common_function/style/hoverable_card.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../data_layer/model/home/benefit_model.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';

class BenefitCard extends StatefulWidget {
  final BenefitModel benefit;
  final int index;

  const BenefitCard({super.key, required this.benefit, required this.index});

  @override
  State<BenefitCard> createState() => _BenefitCardState();
}

class _BenefitCardState extends State<BenefitCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return HoverableCard(
      isBorderLine: false,
      isBoxShadow: false,
      padding: EdgeInsets.all(20),
      onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
      backgroundColor: _isHovered ? DColors.cardBackground : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _isHovered
                  ? DColors.primaryButton.withAlpha((255 * 0.2).round())
                  : DColors.primaryButton.withAlpha((255 * 0.1).round()),
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              border: Border.all(
                color: _isHovered ? DColors.primaryButton : DColors.primaryButton.withAlpha((255 * 0.3).round()),
                width: 2,
              ),
            ),
            child: Icon(widget.benefit.icon, size: 28, color: _isHovered ? DColors.primaryButton : DColors.textPrimary),
          ),
          SizedBox(width: s.spaceBtwItems),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.benefit.title,
                  style: fonts.titleMedium.rajdhani(
                    fontWeight: FontWeight.bold,
                    color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: s.paddingXs),

                // Description
                Text(
                  widget.benefit.description,
                  style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.6),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
