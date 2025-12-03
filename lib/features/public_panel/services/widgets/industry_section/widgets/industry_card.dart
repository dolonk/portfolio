import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/services/industry_model.dart';

class IndustryCard extends StatefulWidget {
  final IndustryModel industry;

  const IndustryCard({super.key, required this.industry});

  @override
  State<IndustryCard> createState() => _IndustryCardState();
}

class _IndustryCardState extends State<IndustryCard> {
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
        child: Container(
          padding: EdgeInsets.all(s.paddingMd),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? widget.industry.accentColor.withAlpha((255 * 0.5).round())
                  : DColors.cardBorder,
              width: 2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.industry.accentColor.withAlpha((255 * 0.2).round()),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Circle with accent color
              _buildIconCircle(s),
              SizedBox(height: s.spaceBtwItems),

              // Industry Name
              Text(
                widget.industry.name,
                style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: s.paddingSm),

              // Description
              Text(
                widget.industry.description,
                style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.5),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Icon Circle with accent color background
  Widget _buildIconCircle(DSizes s) {
    return Container(
      padding: EdgeInsets.all(
        context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.industry.accentColor.withAlpha((255 * 0.2).round()),
            widget.industry.accentColor.withAlpha((255 * 0.1).round()),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          if (_isHovered)
            BoxShadow(
              color: widget.industry.accentColor.withAlpha((255 * 0.4).round()),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Icon(
        widget.industry.icon,
        color: widget.industry.accentColor,
        size: context.responsiveValue(mobile: 32, tablet: 36, desktop: 40),
      ),
    );
  }
}
