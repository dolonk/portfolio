import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import '../../../../../data_layer/model/contact/contact_info_model.dart';

class ContactOptionCard extends StatefulWidget {
  final ContactInfoModel option;

  const ContactOptionCard({super.key, required this.option});

  @override
  State<ContactOptionCard> createState() => _ContactOptionCardState();
}

class _ContactOptionCardState extends State<ContactOptionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.option.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(
              color: _isHovered ? widget.option.accentColor.withAlpha((255 * 0.5).round()) : DColors.cardBorder,
              width: _isHovered ? 2 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.option.accentColor.withAlpha((255 * 0.2).round())
                    : Colors.black.withAlpha((255 * 0.05).round()),
                blurRadius: _isHovered ? 20 : 8,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(s.paddingMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon with colored background
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.option.accentColor.withAlpha((255 * 0.15).round()),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.option.icon, size: 36, color: widget.option.accentColor),
              ),
              SizedBox(height: s.spaceBtwItems),

              // Title
              Text(
                widget.option.title,
                style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: s.paddingSm),

              // Description
              Text(
                widget.option.description,
                style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.5),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Action text with arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_forward_rounded, size: 18, color: widget.option.accentColor),
                  const SizedBox(width: 6),
                  Text(
                    widget.option.actionText,
                    style: fonts.labelMedium.rubik(color: widget.option.accentColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
