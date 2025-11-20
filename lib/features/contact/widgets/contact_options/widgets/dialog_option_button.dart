import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';

class DialogOptionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const DialogOptionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<DialogOptionButton> createState() => _DialogOptionButtonState();
}

class _DialogOptionButtonState extends State<DialogOptionButton> {
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
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: s.paddingMd, horizontal: s.paddingLg),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withAlpha((255 * 0.15).round()) : DColors.secondaryBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: _isHovered ? widget.color : DColors.cardBorder, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.color, size: 24),
              SizedBox(width: s.paddingMd),
              Text(
                widget.label,
                style: fonts.bodyLarge.rubik(
                  color: _isHovered ? widget.color : DColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
