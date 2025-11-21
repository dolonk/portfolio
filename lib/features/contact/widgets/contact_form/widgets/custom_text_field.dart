import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

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
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
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

        // Text Field with Focus Animation
        Focus(
          onFocusChange: (hasFocus) {
            setState(() => _isFocused = hasFocus);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              boxShadow: [
                if (_isFocused)
                  BoxShadow(
                    color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: fonts.bodyMedium.rubik(color: DColors.textSecondary),
                filled: true,
                fillColor: widget.enabled ? DColors.secondaryBackground : DColors.cardBorder.withAlpha(50),
                counterText: '', // Hide character counter
                contentPadding: EdgeInsets.all(s.paddingMd),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  borderSide: BorderSide(color: DColors.cardBorder, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  borderSide: BorderSide(color: DColors.cardBorder, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  borderSide: BorderSide(color: DColors.primaryButton, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  borderSide: BorderSide(color: Colors.red.shade400, width: 2),
                ),
                errorStyle: const TextStyle(height: 0), // Hide default error
              ),
              validator: (value) {
                final error = widget.validator?.call(value);
                setState(() => _errorText = error);
                return error;
              },
            ),
          ),
        ),

        // Error Message with Shake Animation
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: s.paddingSm, left: s.paddingSm),
            child: Text(
              _errorText!,
              style: fonts.bodySmall.rubik(color: Colors.red.shade400),
            ).animate(key: ValueKey(_errorText)).shake(duration: 500.ms, hz: 2, curve: Curves.easeInOut),
          ),
      ],
    );
  }
}
