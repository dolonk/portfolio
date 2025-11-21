import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/data_layer/model/services/faq_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class ReusableFaqItem extends StatefulWidget {
  final FaqModel faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const ReusableFaqItem({super.key, required this.faq, required this.isExpanded, required this.onTap});

  @override
  State<ReusableFaqItem> createState() => _ReusableFaqItemState();
}

class _ReusableFaqItemState extends State<ReusableFaqItem> with TickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    final bgColor = widget.isExpanded
        ? DColors.cardBackground
        : _isHovered
        ? DColors.cardBackground
        : DColors.cardBackground.withAlpha(120);

    final borderColor = widget.isExpanded
        ? DColors.primaryButton.withAlpha(120)
        : _isHovered
        ? DColors.cardBorder
        : DColors.cardBorder.withAlpha(120);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: s.paddingMd),
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: widget.isExpanded ? 2 : 1),
          boxShadow: widget.isExpanded
              ? [BoxShadow(color: DColors.primaryButton.withAlpha(25), blurRadius: 15, offset: const Offset(0, 4))]
              : [],
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // HEADER SECTION
            InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.all(s.paddingLg),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.faq.question,
                        style: fonts.bodyLarge.rubik(
                          fontWeight: FontWeight.w600,
                          color: widget.isExpanded ? DColors.primaryButton : DColors.textPrimary,
                        ),
                      ),
                    ),

                    // ROTATING CHEVRON
                    Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: widget.isExpanded ? DColors.primaryButton : DColors.textSecondary,
                          size: 28,
                        )
                        .animate(target: widget.isExpanded ? 1 : 0)
                        .rotate(begin: 0, end: 0.5, duration: 300.ms, curve: Curves.easeInOut),
                  ],
                ),
              ),
            ),

            // EXPANDING BODY
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: widget.isExpanded
                  ? Padding(
                      padding: EdgeInsets.only(left: s.paddingLg, right: s.paddingLg, bottom: s.paddingLg),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Divider(color: DColors.cardBorder),
                          SizedBox(height: s.paddingMd),
                          Text(
                            widget.faq.answer,
                            style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.7),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
