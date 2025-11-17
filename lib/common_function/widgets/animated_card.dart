import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';

enum DAnimationType {
  /// Zoom effect (scale up on hover)
  scale,

  /// Lift effect (move up + shadow on hover)
  lift,

  /// Glow effect (border glow on hover)
  glow,

  /// Combined (scale + lift + glow)
  combined,

  /// No animation (static card)
  none,
}

class DAnimatedCard extends StatefulWidget {
  /// Card content (required)
  final Widget child;

  /// Animation type
  final DAnimationType animationType;

  /// Border color when hovered
  final Color? hoverBorderColor;

  /// Border color when not hovered
  final Color? defaultBorderColor;

  /// Background color
  final Color? backgroundColor;

  /// Glow/shadow color
  final Color? glowColor;

  /// Tap callback
  final VoidCallback? onTap;

  /// Hover state change callback
  final void Function(bool isHovered)? onHoverChanged;

  /// Card padding
  final EdgeInsets? padding;

  /// Border radius
  final double? borderRadius;

  /// Border width
  final double? borderWidth;

  /// Scale amount for scale animation (default: 1.02)
  final double scaleAmount;

  /// Lift amount in pixels for lift animation (default: -8.0)
  final double liftAmount;

  /// Animation duration
  final Duration animationDuration;

  /// Enable hover effect
  final bool enableHover;

  /// Show border
  final bool showBorder;

  /// Show shadow when hovered
  final bool showShadow;

  /// Card width (null = auto)
  final double? width;

  /// Card height (null = auto)
  final double? height;

  const DAnimatedCard({
    super.key,
    required this.child,
    this.animationType = DAnimationType.scale,
    this.hoverBorderColor,
    this.defaultBorderColor,
    this.backgroundColor,
    this.glowColor,
    this.onTap,
    this.onHoverChanged,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.scaleAmount = 1.02,
    this.liftAmount = -8.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.enableHover = true,
    this.showBorder = true,
    this.showShadow = true,
    this.width,
    this.height,
  });

  @override
  State<DAnimatedCard> createState() => _DAnimatedCardState();
}

class _DAnimatedCardState extends State<DAnimatedCard> {
  bool _isHovered = false;

  void _updateHoverState(bool isHovered) {
    if (_isHovered != isHovered) {
      setState(() => _isHovered = isHovered);
      widget.onHoverChanged?.call(isHovered);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget card = AnimatedContainer(
      duration: widget.animationDuration,
      curve: Curves.easeOut,
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      transform: _getTransform(),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? DColors.cardBackground,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 16),
        border: widget.showBorder
            ? Border.all(
                color: _isHovered
                    ? (widget.hoverBorderColor ?? DColors.primaryButton)
                    : (widget.defaultBorderColor ?? DColors.cardBorder),
                width: widget.borderWidth ?? (_isHovered ? 2 : 1),
              )
            : null,
        boxShadow: _isHovered && widget.showShadow ? _getBoxShadow() : null,
      ),
      child: widget.child,
    );

    if (!widget.enableHover) return card;

    return MouseRegion(
      onEnter: (_) => _updateHoverState(true),
      onExit: (_) => _updateHoverState(false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(onTap: widget.onTap, child: card),
    );
  }

  /// Get transformation matrix based on animation type
  Matrix4 _getTransform() {
    if (!_isHovered || widget.animationType == DAnimationType.none) {
      return Matrix4.identity();
    }

    switch (widget.animationType) {
      case DAnimationType.scale:
        return Matrix4.identity()..scale(widget.scaleAmount);

      case DAnimationType.lift:
        return Matrix4.identity()..translate(0.0, widget.liftAmount);

      case DAnimationType.combined:
        return Matrix4.identity()
          ..translate(0.0, widget.liftAmount)
          ..scale(widget.scaleAmount);

      case DAnimationType.glow:
      case DAnimationType.none:
        return Matrix4.identity();
    }
  }

  /// Get box shadow based on animation type
  List<BoxShadow> _getBoxShadow() {
    final color = widget.glowColor ?? DColors.primaryButton;

    switch (widget.animationType) {
      case DAnimationType.scale:
        return [BoxShadow(color: color.withAlpha((255 * 0.3).round()), blurRadius: 20, offset: const Offset(0, 8))];

      case DAnimationType.lift:
        return [BoxShadow(color: color.withAlpha((255 * 0.2).round()), blurRadius: 25, offset: const Offset(0, 12))];

      case DAnimationType.glow:
        return [
          BoxShadow(
            color: color.withAlpha((255 * 0.4).round()),
            blurRadius: 30,
            offset: const Offset(0, 0),
            spreadRadius: 2,
          ),
        ];

      case DAnimationType.combined:
        return [BoxShadow(color: color.withAlpha((255 * 0.3).round()), blurRadius: 25, offset: const Offset(0, 10))];

      case DAnimationType.none:
        return [];
    }
  }
}
