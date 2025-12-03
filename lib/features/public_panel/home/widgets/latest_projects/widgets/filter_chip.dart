import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class DFilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const DFilterChip({super.key, required this.label, required this.isActive, required this.onTap});

  @override
  State<DFilterChip> createState() => _DFilterChipState();
}

class _DFilterChipState extends State<DFilterChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(mobile: 16, tablet: 18, desktop: 20),
            vertical: context.responsiveValue(mobile: 10, tablet: 12, desktop: 12),
          ),
          decoration: BoxDecoration(
            color: widget.isActive ? DColors.primaryButton : DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(
              color: widget.isActive
                  ? DColors.primaryButton
                  : _isHovered
                  ? DColors.primaryButton.withAlpha((255 * 0.5).round())
                  : DColors.cardBorder,
              width: 1.5,
            ),
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.label,
            style: fonts.bodySmall.rubik(
              color: widget.isActive ? DColors.textPrimary : DColors.textSecondary,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
