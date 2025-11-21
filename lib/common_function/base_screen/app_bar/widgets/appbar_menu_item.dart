import 'package:flutter/material.dart';
import '../../../../utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';

class AppBarMenuItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const AppBarMenuItem({super.key, required this.title, required this.isActive, required this.onTap});

  @override
  State<AppBarMenuItem> createState() => _AppBarMenuItemState();
}

class _AppBarMenuItemState extends State<AppBarMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive
                    ? DColors.primaryButton
                    : _isHovered
                    ? DColors.primaryButton.withAlpha((255 * 0.5).round())
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.title,
            style: fonts.bodySmall.copyWith(
              color: widget.isActive
                  ? DColors.primaryButton
                  : _isHovered
                  ? DColors.textPrimary
                  : DColors.textSecondary,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}