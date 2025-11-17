import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/services/faq_model.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class FaqItem extends StatefulWidget {
  final FaqModel faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqItem({super.key, required this.faq, required this.isExpanded, required this.onTap});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconRotation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _iconRotation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Set initial state
    if (widget.isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(FaqItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: EdgeInsets.only(bottom: s.paddingMd),
        decoration: BoxDecoration(
          color: widget.isExpanded
              ? DColors.cardBackground
              : _isHovered
              ? DColors.cardBackground
              : DColors.cardBackground.withAlpha((255 * 0.5).round()),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isExpanded
                ? DColors.primaryButton.withAlpha((255 * 0.5).round())
                : _isHovered
                ? DColors.cardBorder
                : DColors.cardBorder.withAlpha((255 * 0.5).round()),
            width: widget.isExpanded ? 2 : 1,
          ),
          boxShadow: [
            if (widget.isExpanded)
              BoxShadow(
                color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          children: [
            // Question Header (Clickable)
            InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.all(s.paddingLg),
                child: Row(
                  children: [
                    // Question Text
                    Expanded(
                      child: Text(
                        widget.faq.question,
                        style: fonts.bodyLarge.rubik(
                          fontWeight: FontWeight.w600,
                          color: widget.isExpanded ? DColors.primaryButton : DColors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: s.paddingMd),

                    // Chevron Icon (Rotates)
                    RotationTransition(
                      turns: _iconRotation,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: widget.isExpanded ? DColors.primaryButton : DColors.textSecondary,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Answer (Expandable)
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: EdgeInsets.only(left: s.paddingLg, right: s.paddingLg, bottom: s.paddingLg),
                child: Column(
                  children: [
                    // Divider
                    Divider(color: DColors.cardBorder),
                    SizedBox(height: s.paddingMd),

                    // Answer Text
                    Text(
                      widget.faq.answer,
                      style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.7),
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
