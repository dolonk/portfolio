import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import '../../utility/default_sizes/font_size.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utility/default_sizes/default_sizes.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isRequired;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final double? borderRadius;
  final Color? fillColor;
  final bool showCounter;
  final bool useInlineLabel;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.borderRadius,
    this.fillColor,
    this.showCounter = false,
    this.useInlineLabel = false,
    this.contentPadding,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final borderRadius = widget.borderRadius ?? s.borderRadiusSm;
    final contentPadding = widget.contentPadding ?? EdgeInsets.all(16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.useInlineLabel && widget.label.isNotEmpty) ...[
          RichText(
            text: TextSpan(
              text: widget.label,
              style: fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
              children: [
                if (widget.isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red.shade400),
                  ),
              ],
            ),
          ),
          SizedBox(height: s.paddingSm),
        ],

        // Text Field with Focus Animation
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          obscureText: _obscureText,
          style: fonts.bodyMedium.rubik(color: widget.enabled ? DColors.textPrimary : DColors.textSecondary),
          decoration: InputDecoration(
            labelText: widget.useInlineLabel ? widget.label : null,
            labelStyle: widget.useInlineLabel ? TextStyle(color: DColors.textSecondary) : null,
            hintText: widget.hint,
            hintStyle: fonts.bodyMedium.rubik(color: DColors.textSecondary),
            filled: true,
            fillColor:
                widget.fillColor ?? (widget.enabled ? DColors.secondaryBackground : DColors.cardBorder.withAlpha(50)),
            counterText: widget.showCounter ? null : '',
            contentPadding: contentPadding,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                      color: DColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  )
                : widget.suffixIcon != null
                ? IconButton(icon: widget.suffixIcon!, onPressed: widget.onSuffixIconPressed)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: DColors.cardBorder, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: DColors.cardBorder, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: DColors.primaryButton, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            errorText: null,
            errorStyle: const TextStyle(height: 0),
          ),
          validator: (value) {
            final error = widget.validator?.call(value);
            setState(() => _errorText = error);
            return null;
          },
        ),

        // Error Message with Shake Animation
        if (_errorText != null)
          Text(
            _errorText!,
            style: fonts.bodySmall.rubik(fontSize: 14, color: Colors.red.shade400),
          ).animate(key: ValueKey(_errorText)).shake(duration: 500.ms, hz: 2, curve: Curves.easeInOut),
      ],
    );
  }
}
