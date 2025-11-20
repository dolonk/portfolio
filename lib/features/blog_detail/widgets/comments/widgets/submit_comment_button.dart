import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';

class SubmitCommentButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isSubmitting;

  const SubmitCommentButton({super.key, required this.onPressed, required this.isSubmitting});

  @override
  State<SubmitCommentButton> createState() => _SubmitCommentButtonState();
}

class _SubmitCommentButtonState extends State<SubmitCommentButton> {
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
        onTap: widget.isSubmitting ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? const LinearGradient(colors: [DColors.primaryButton, Color(0xFFD4003D)])
                : null,
            color: _isHovered ? null : DColors.primaryButton,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.4).round()),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: widget.isSubmitting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Post Comment',
                  style: fonts.bodyMedium.rubik(color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
