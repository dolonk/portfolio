import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';

class HoverableCard extends StatefulWidget {
  final EdgeInsets? padding;
  final bool isBoxShadow;
  final Color backgroundColor;
  final bool isBorderLine;
  final Widget child;
  final void Function(bool isHovered)? onHoverChanged;

  const HoverableCard({
    super.key,
    this.padding,
    this.onHoverChanged,
    this.isBoxShadow = true,
    this.isBorderLine = true,
    this.backgroundColor = DColors.cardBackground,
    required this.child,
  });

  @override
  State<HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard> {
  bool _isHovered = false;

  void _updateHoverState(bool isHovered) {
    if (_isHovered != isHovered) {
      setState(() => _isHovered = isHovered);
      widget.onHoverChanged?.call(isHovered);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHoverState(true),
      onExit: (_) => _updateHoverState(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? DColors.primaryButton.withAlpha((255 * 0.5).round())
                : widget.isBorderLine
                ? DColors.cardBorder
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: widget.isBoxShadow
              ? _isHovered
                    ? [
                        BoxShadow(
                          color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null
              : null,
        ),
        child: widget.child,
      ),
    );
  }
}
