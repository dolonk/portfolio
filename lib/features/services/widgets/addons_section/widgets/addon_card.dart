import 'package:flutter/material.dart';
import 'package:portfolio/data_layer/model/services/addon_model.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';

class AddonCard extends StatefulWidget {
  final AddonModel addon;

  const AddonCard({super.key, required this.addon});

  @override
  State<AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends State<AddonCard> {
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
        transform: Matrix4.diagonal3Values(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0, 1.0),
        child: Container(
          padding: EdgeInsets.all(s.paddingLg),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? widget.addon.accentColor.withAlpha((255 * 0.5).round()) : DColors.cardBorder,
              width: 2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.addon.accentColor.withAlpha((255 * 0.2).round()),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Circle
              _buildIconCircle(s),
              SizedBox(height: s.spaceBtwItems),

              // Add-on Name
              Text(widget.addon.name, style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold)),
              SizedBox(height: s.paddingSm),

              // Description
              Text(
                widget.addon.description,
                style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Divider
              Divider(color: DColors.cardBorder),
              SizedBox(height: s.paddingSm),

              // Price Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
                decoration: BoxDecoration(
                  color: widget.addon.accentColor.withAlpha((255 * 0.1).round()),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: widget.addon.accentColor.withAlpha((255 * 0.3).round()), width: 1),
                ),
                child: Text(
                  widget.addon.priceRange,
                  style: fonts.labelLarge.rubik(color: widget.addon.accentColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Icon Circle with accent color
  Widget _buildIconCircle(DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.addon.accentColor.withAlpha((255 * 0.2).round()),
            widget.addon.accentColor.withAlpha((255 * 0.1).round()),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          if (_isHovered)
            BoxShadow(
              color: widget.addon.accentColor.withAlpha((255 * 0.4).round()),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Icon(widget.addon.icon, color: widget.addon.accentColor, size: 32),
    );
  }
}
