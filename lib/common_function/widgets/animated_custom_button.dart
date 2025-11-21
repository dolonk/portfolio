import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

/*class AnimatedCustomButton extends StatefulWidget {
  final String text;
  final Widget icon;
  final double? width;
  final double height;
  final Duration animationDuration;
  final VoidCallback onPressed;

  const AnimatedCustomButton({
    super.key,
    required this.text,
    required this.icon,
    this.width = double.infinity,
    this.height = 44,
    this.animationDuration = const Duration(milliseconds: 300),
    required this.onPressed,
  });

  @override
  State<AnimatedCustomButton> createState() => _AnimatedCustomButtonState();
}

class _AnimatedCustomButtonState extends State<AnimatedCustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    // Define styles based on the hover state for clarity
    final effectiveBackgroundColor = _isHovered ? DColors.cardBorder : Colors.transparent;
    final effectiveForegroundColor = _isHovered ? Colors.white : DColors.textSecondary;
    final effectiveBorderColor = _isHovered ? DColors.primaryButton : DColors.cardBorder;
    final effectiveBoxShadow = _isHovered
        ? [
            BoxShadow(
              color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
        : null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: effectiveBorderColor, width: 2),
            boxShadow: effectiveBoxShadow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button Text
              Text(
                widget.text,
                style: fonts.bodyMedium.copyWith(color: effectiveForegroundColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),

              // Animated Icon
              widget.icon
                  .animate(target: _isHovered ? 1 : 0)
                  .slideX(begin: 0, end: 5, curve: Curves.easeOut)
                  .tint(color: effectiveForegroundColor),
            ],
          ),
        ),
      ),
    );
  }
}*/

class AnimatedCustomButton extends StatefulWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final double borderWidth;
  final Color? textColor;
  final Color? hoverTextColor;
  final Color? iconColor;
  final Color? hoverIconColor;
  final Duration animationDuration;
  final double iconSlideDistance;

  const AnimatedCustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 44,
    this.padding,
    this.borderWidth = 2.0,
    this.textColor,
    this.hoverTextColor,
    this.iconColor,
    this.hoverIconColor,
    this.iconSlideDistance = 5.0,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedCustomButton> createState() => _AnimatedCustomButtonState();
}

class _AnimatedCustomButtonState extends State<AnimatedCustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    final effectiveBackgroundColor = _isHovered ? DColors.primaryButton : Colors.transparent;
    final effectiveTextColor = _isHovered
        ? (widget.hoverTextColor ?? Colors.white)
        : (widget.textColor ?? DColors.textSecondary);
    final effectiveIconColor = _isHovered
        ? (widget.hoverIconColor ?? Colors.white)
        : (widget.iconColor ?? DColors.textSecondary);

    final effectiveBorderColor = _isHovered ? DColors.primaryButton : DColors.cardBorder;
    final effectiveBoxShadow = _isHovered
        ? [
            BoxShadow(
              color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
        : null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: effectiveBorderColor, width: widget.borderWidth),
            boxShadow: effectiveBoxShadow,
          ),
          child: Row(
            mainAxisSize: widget.width == null ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: fonts.bodyMedium.copyWith(color: effectiveTextColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),

              widget.icon
                  .animate(target: _isHovered ? 1 : 0)
                  .slideX(begin: 0, end: widget.iconSlideDistance, curve: Curves.easeOut)
                  .tint(color: effectiveIconColor),
            ],
          ),
        ),
      ),
    );
  }
}
