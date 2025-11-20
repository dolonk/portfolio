import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class PortfolioFilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const PortfolioFilterChip({super.key, required this.label, required this.isActive, required this.onTap});

  @override
  State<PortfolioFilterChip> createState() => _PortfolioFilterChipState();
}

class _PortfolioFilterChipState extends State<PortfolioFilterChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
          padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: widget.isActive
                ? DColors.primaryButton
                : _isHovered
                ? DColors.primaryButton.withAlpha((255 * 0.1).round())
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.isActive
                  ? DColors.primaryButton
                  : _isHovered
                  ? DColors.primaryButton.withAlpha((255 * 0.5).round())
                  : DColors.cardBorder,
              width: 2,
            ),
          ),
          child: Text(
            widget.label,
            style: fonts.labelLarge.rubik(
              color: widget.isActive ? Colors.white : DColors.textSecondary,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
