import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';

class TechCard extends StatefulWidget {
  final IconData icon;
  final String name;
  final String category;
  final Color iconColor;

  const TechCard({super.key, required this.icon, required this.name, required this.category, required this.iconColor});

  @override
  State<TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<TechCard> {
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
        curve: Curves.easeOut,
        transform: Matrix4.diagonal3Values(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0, 1.0),
        decoration: BoxDecoration(
          color: DColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? widget.iconColor.withAlpha((255 * 0.5).round()) : DColors.cardBorder,
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.iconColor.withAlpha((255 * 0.3).round())
                  : Colors.black.withAlpha((255 * 0.05).round()),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(s.paddingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: widget.iconColor.withAlpha((255 * 0.15).round()),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: FaIcon(widget.icon, size: 36, color: widget.iconColor)),
            ),
            SizedBox(height: s.paddingMd),

            // Tech Name
            Text(
              widget.name,
              style: fonts.bodyLarge.rubik(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: s.paddingSm),

            // Category Label
            Text(
              widget.category,
              style: fonts.labelMedium.rubik(color: DColors.textSecondary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
