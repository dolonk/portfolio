import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/data_layer/model/services/faq_model.dart';

class FaqItem extends StatefulWidget {
  final FaqModel faq;
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
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: s.spaceBtwItems),
          decoration: BoxDecoration(
            color: _isHovered || widget.isExpanded ? DColors.cardBackground : DColors.secondaryBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(
              color: widget.isExpanded
                  ? DColors.primaryButton
                  : (_isHovered ? DColors.primaryButton.withAlpha((255 * 0.5).round()) : DColors.cardBorder),
              width: widget.isExpanded ? 2 : 1.5,
            ),
            boxShadow: [
              if (widget.isExpanded)
                BoxShadow(
                  color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Row
              Padding(
                padding: EdgeInsets.all(s.paddingLg),
                child: Row(
                  children: [
                    // Question Text
                    Expanded(
                      child: Text(
                        widget.faq.question,
                        style: fonts.bodyLarge.rubik(
                          fontWeight: FontWeight.bold,
                          color: widget.isExpanded ? DColors.primaryButton : DColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: s.paddingMd),

                    // Chevron Icon (Rotates on expand)
                    AnimatedRotation(
                      turns: widget.isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: widget.isExpanded ? DColors.primaryButton : DColors.textSecondary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),

              // Answer (Animated Size)
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: widget.isExpanded
                    ? Container(
                        padding: EdgeInsets.only(left: s.paddingLg, right: s.paddingLg, bottom: s.paddingLg, top: 0),
                        child: Text(
                          widget.faq.answer,
                          style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6),
                        ),
                      ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1, end: 0, duration: 300.ms)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
