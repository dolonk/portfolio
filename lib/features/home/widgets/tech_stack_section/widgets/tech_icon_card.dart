import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common_function/style/hoverable_card.dart';
import '../../../../../data_layer/model/home/tech_stack_model.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';

class TechIconCard extends StatefulWidget {
  final TechStackModel tech;
  final int index;

  const TechIconCard({super.key, required this.tech, required this.index});

  @override
  State<TechIconCard> createState() => _TechIconCardState();
}

class _TechIconCardState extends State<TechIconCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final iconSize = context.responsiveValue(mobile: 36.0, tablet: 48.0, desktop: 56.0);

    return HoverableCard(
      isBorderLine: false,

      padding: EdgeInsets.all(context.responsiveValue(mobile: 14, tablet: s.paddingMd, desktop: s.paddingLg)),
      onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tech Icon
          Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
              child: _buildTechIcon(iconSize),
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Tech Name
          Text(
            widget.tech.name,
            style: fonts.bodySmall.rubik(
              color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
              fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTechIcon(double size) {
    // Check if SVG or PNG
    final isSvg = widget.tech.iconPath.endsWith('.svg');

    if (isSvg) {
      return SvgPicture.asset(
        widget.tech.iconPath,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          _isHovered ? DColors.primaryButton : DColors.textPrimary,
          BlendMode.srcIn,
        ),
        placeholderBuilder: (context) => _buildPlaceholder(size),
      );
    } else {
      return Image.asset(
        widget.tech.iconPath,
        width: size,
        height: size,
        color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(size),
      );
    }
  }

  Widget _buildPlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: DColors.cardBorder.withAlpha((255 * 0.3).round()),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.code_rounded, size: size * 0.6, color: DColors.textSecondary),
    );
  }
}
