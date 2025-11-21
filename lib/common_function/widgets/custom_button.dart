import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class CustomButton extends StatefulWidget {
  /// Button text (required)
  final String tittleText;

  /// Button click handler (required)
  final VoidCallback onPressed;

  /// Button width (null = auto)
  final double? width;

  /// Button height (default: 50)
  final double height;

  /// Button style - true: filled, false: outline (default: true)
  final bool isPrimary;

  /// Optional icon
  final IconData? icon;

  /// Icon position - true: right, false: left (default: false)
  final bool iconRight;

  /// Icon size (default: 18)
  final double? iconSize;

  /// Custom background color (primary buttons only)
  final Color? backgroundColor;

  /// Custom text/border color
  final Color? foregroundColor;

  /// Custom hover color
  final Color? hoverColor;

  /// Button padding
  final EdgeInsetsGeometry? padding;

  /// Border radius (default: from DSizes)
  final double? borderRadius;

  /// Border width (for outline buttons, default: 2)
  final double borderWidth;

  /// Show loading indicator
  final bool isLoading;

  /// Disable button
  final bool isDisabled;

  /// Text style override
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.tittleText,
    required this.onPressed,
    this.width,
    this.height = 50,
    this.isPrimary = true,
    this.icon,
    this.iconRight = false,
    this.iconSize,
    this.backgroundColor,
    this.foregroundColor,
    this.hoverColor,
    this.padding,
    this.borderRadius,
    this.borderWidth = 2,
    this.isLoading = false,
    this.isDisabled = false,
    this.textStyle,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    // Determine colors based on variant
    final bgColor = widget.backgroundColor ?? DColors.primaryButton;
    final fgColor = widget.foregroundColor ?? Colors.white;
    final hColor =
        widget.hoverColor ??
        (widget.isPrimary ? DColors.cardBorder : DColors.primaryButton.withAlpha((255 * 0.1).round()));

    // Check if button should be disabled
    final isDisabled = widget.isDisabled || widget.isLoading;

    // Create icon widget if available
    final iconWidget = widget.icon != null && !widget.isLoading
        ? Icon(
            widget.icon,
            size: widget.iconSize ?? 18,
            color: widget.isPrimary ? fgColor : (_isHovered ? DColors.primaryButton : fgColor),
          )
        : null;

    // Create loading indicator
    final loadingWidget = widget.isLoading
        ? SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(widget.isPrimary ? Colors.white : DColors.primaryButton),
            ),
          )
        : null;

    // Create text widget
    final textWidget = Text(
      widget.tittleText,
      style:
          widget.textStyle ??
          fonts.bodyMedium.rubik(
            color: widget.isPrimary ? fgColor : (_isHovered ? DColors.primaryButton : fgColor),
            fontWeight: FontWeight.w600,
          ),
    );

    // Build children based on icon position
    List<Widget> buildChildren() {
      final children = <Widget>[];

      // Add loading indicator
      if (loadingWidget != null) {
        children.addAll([loadingWidget, const SizedBox(width: 8)]);
      }

      if (widget.iconRight) {
        // Icon on right: Text -> Icon
        children.add(textWidget);
        if (iconWidget != null) {
          children.addAll([const SizedBox(width: 8), iconWidget]);
        }
      } else {
        // Icon on left (default): Icon -> Text
        if (iconWidget != null) {
          children.addAll([iconWidget, const SizedBox(width: 8)]);
        }
        children.add(textWidget);
      }

      return children;
    }

    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildChildren(),
    );

    return MouseRegion(
      onEnter: isDisabled ? null : (_) => setState(() => _isHovered = true),
      onExit: isDisabled ? null : (_) => setState(() => _isHovered = false),
      cursor: isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        child: widget.isPrimary
            ? _buildPrimaryButton(context, s, bgColor, fgColor, hColor, isDisabled, buttonContent)
            : _buildOutlineButton(context, s, fgColor, hColor, isDisabled, buttonContent),
      ),
    );
  }

  /// Primary (Filled) Button
  Widget _buildPrimaryButton(
    BuildContext context,
    DSizes s,
    Color bgColor,
    Color fgColor,
    Color hColor,
    bool isDisabled,
    Widget content,
  ) {
    return ElevatedButton(
      onPressed: isDisabled ? null : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled
            ? DColors.cardBorder.withAlpha((255 * 0.3).round())
            : (_isHovered ? hColor : bgColor),
        foregroundColor: fgColor,
        disabledBackgroundColor: DColors.cardBorder.withAlpha((255 * 0.3).round()),
        disabledForegroundColor: DColors.textSecondary,
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: s.paddingMd),
        elevation: _isHovered ? 8 : 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius ?? s.borderRadiusSm)),
      ),
      child: content,
    );
  }

  /// Outline (Secondary) Button
  Widget _buildOutlineButton(
    BuildContext context,
    DSizes s,
    Color fgColor,
    Color hColor,
    bool isDisabled,
    Widget content,
  ) {
    return OutlinedButton(
      onPressed: isDisabled ? null : widget.onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isDisabled ? Colors.transparent : (_isHovered ? hColor : Colors.transparent),
        foregroundColor: fgColor,
        disabledForegroundColor: DColors.textSecondary,
        side: BorderSide(
          color: isDisabled
              ? DColors.cardBorder.withAlpha((255 * 0.3).round())
              : (_isHovered ? DColors.primaryButton : DColors.buttonBorder),
          width: widget.borderWidth,
        ),
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: s.paddingMd),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius ?? s.borderRadiusSm)),
      ),
      child: content,
    );
  }
}
