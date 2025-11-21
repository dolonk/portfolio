import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class FormSubmitButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const FormSubmitButton({super.key, required this.isLoading, required this.onPressed});

  @override
  State<FormSubmitButton> createState() => _FormSubmitButtonState();
}

class _FormSubmitButtonState extends State<FormSubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: context.isMobile ? double.infinity : 300,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(s.borderRadiusSm),
          boxShadow: [
            if (_isHovered && !widget.isLoading)
              BoxShadow(
                color: DColors.primaryButton.withAlpha((255 * 0.4).round()),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isLoading
                ? DColors.cardBorder
                : (_isHovered ? DColors.primaryButton.withAlpha((255 * 0.9).round()) : DColors.primaryButton),
            foregroundColor: Colors.white,
            elevation: _isHovered ? 8 : 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusSm)),
            padding: EdgeInsets.symmetric(vertical: s.paddingMd),
          ),
          child: widget.isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withAlpha((255 * 0.7).round())),
                      ),
                    ),
                    SizedBox(width: s.paddingMd),
                    Text(
                      'Sending...',
                      style: fonts.bodyLarge.rubik(
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withAlpha((255 * 0.7).round()),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.send_rounded, size: 20),
                    SizedBox(width: s.paddingSm),
                    Text('Send Message', style: fonts.bodyLarge.rubik(fontWeight: FontWeight.bold)),
                  ],
                ),
        ),
      ),
    );
  }
}
