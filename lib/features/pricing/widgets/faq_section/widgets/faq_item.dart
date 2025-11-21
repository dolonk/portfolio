import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import '../../../../../data_layer/model/pricing/pricing_faq_model.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class FaqItem extends StatefulWidget {
  final PricingFaqModel faq;
  final bool isExpanded;
  final VoidCallback onToggle;

  const FaqItem({super.key, required this.faq, required this.isExpanded, required this.onToggle});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
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
                ? DColors.primaryButton
                : (_isHovered ? DColors.primaryButton.withAlpha(76) : DColors.cardBorder),
            width: widget.isExpanded ? 2 : 1.5,
          ),
          boxShadow: widget.isExpanded
              ? [BoxShadow(color: DColors.primaryButton.withAlpha(38), blurRadius: 15, offset: Offset(0, 5))]
              : null,
        ),
        child: Column(
          children: [
            // Question (Header)
            InkWell(
              onTap: widget.onToggle,
              borderRadius: BorderRadius.circular(s.borderRadiusLg),
              child: Padding(
                padding: EdgeInsets.all(s.paddingLg),
                child: Row(
                  children: [
                    // Question Icon
                    Container(
                      padding: EdgeInsets.all(s.paddingSm),
                      decoration: BoxDecoration(
                        color: DColors.primaryButton.withAlpha(25),
                        borderRadius: BorderRadius.circular(s.borderRadiusMd),
                      ),
                      child: Icon(
                        Icons.help_outline_rounded,
                        color: DColors.primaryButton,
                        size: context.responsiveValue(mobile: 20, tablet: 22, desktop: 24),
                      ),
                    ),
                    SizedBox(width: s.paddingMd),

                    // Question Text
                    Expanded(
                      child: Text(
                        widget.faq.question,
                        style: fonts.titleMedium.rajdhani(
                          fontSize: context.responsiveValue(mobile: 16, tablet: 18, desktop: 19),
                          fontWeight: FontWeight.bold,
                          color: widget.isExpanded ? DColors.primaryButton : DColors.textPrimary,
                        ),
                      ),
                    ),

                    // Expand/Collapse Icon
                    Icon(
                      widget.isExpanded ? Icons.remove_rounded : Icons.add_rounded,
                      color: DColors.primaryButton,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),

            // Answer (Expandable)
            AnimatedCrossFade(
              firstChild: SizedBox.shrink(),
              secondChild: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: context.responsiveValue(mobile: s.paddingLg, desktop: s.paddingXl),
                  right: context.responsiveValue(mobile: s.paddingLg, desktop: s.paddingXl),
                  bottom: context.responsiveValue(mobile: s.paddingLg, desktop: s.paddingXl),
                  top: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: DColors.cardBorder, height: 1),
                    SizedBox(height: s.paddingMd),

                    // Category Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm / 2),
                      decoration: BoxDecoration(
                        color: DColors.primaryButton.withAlpha(25),
                        borderRadius: BorderRadius.circular(s.borderRadiusSm),
                      ),
                      child: Text(
                        widget.faq.category,
                        style: fonts.labelSmall.rubik(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: DColors.primaryButton,
                        ),
                      ),
                    ),
                    SizedBox(height: s.paddingMd),

                    // Answer Text
                    Text(
                      widget.faq.answer,
                      style: fonts.bodyMedium.rubik(
                        fontSize: context.responsiveValue(mobile: 14, tablet: 15, desktop: 16),
                        color: DColors.textSecondary,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: widget.isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
