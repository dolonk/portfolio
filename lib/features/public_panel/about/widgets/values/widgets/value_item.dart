import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/about/value_model.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ValueItem extends StatefulWidget {
  final ValueModel value;
  final int delay;

  const ValueItem({super.key, required this.value, this.delay = 0});

  @override
  State<ValueItem> createState() => _ValueItemState();
}

class _ValueItemState extends State<ValueItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: _buildAnimatedCard(context, s),
    );
  }

  Widget _buildAnimatedCard(BuildContext context, DSizes s) {
    final accentColor = widget.value.accentColor;
    final hoverColor = accentColor.withAlpha(76);
    final shadowColor = _isHovered ? accentColor.withAlpha(51) : Colors.black.withAlpha(13);

    return AnimatedContainer(
          duration: 300.ms,
          transform: Matrix4.identity()..translateByVector3(Vector3(_isHovered ? 8.0 : 0.0, 0.0, 0.0)),

          margin: EdgeInsets.only(bottom: s.spaceBtwItems),
          padding: EdgeInsets.all(
            context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
          ),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: _isHovered ? accentColor : hoverColor, width: 2),
            boxShadow: [
              BoxShadow(color: shadowColor, blurRadius: _isHovered ? 20 : 10, offset: Offset(0, _isHovered ? 6 : 3)),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(context, s),
              SizedBox(
                width: context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingXl),
              ),
              Expanded(child: _buildContent(context, s)),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: widget.delay.ms)
        .slideX(begin: -0.1, duration: 600.ms, delay: widget.delay.ms);
  }

  /// Icon with Pulse Animation
  Widget _buildIcon(BuildContext context, DSizes s) {
    final iconSize = context.responsiveValue(mobile: 50.0, tablet: 55.0, desktop: 60.0);

    return Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [widget.value.accentColor, widget.value.accentColor.withAlpha(178)],
            ),
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            boxShadow: [
              BoxShadow(
                color: widget.value.accentColor.withAlpha(102),
                blurRadius: _isHovered ? 15 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(widget.value.icon, color: Colors.white, size: iconSize * 0.55),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(duration: 2000.ms, curve: Curves.easeInOut, begin: const Offset(1, 1), end: const Offset(1.05, 1.05))
        .then()
        .scale(duration: 300.ms, begin: const Offset(1, 1), end: const Offset(1.1, 1.1));
  }

  /// Content (Title + Description)
  Widget _buildContent(BuildContext context, DSizes s) {
    final fonts = context.fonts;
    final titleSize = context.responsiveValue(mobile: 20.0, tablet: 22.0, desktop: 24.0);
    final descriptionSize = context.responsiveValue(mobile: 14.0, tablet: 15.0, desktop: 16.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.value.title,
          style: fonts.headlineSmall.rajdhani(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
        ),
        SizedBox(height: s.paddingSm),
        Text(
          widget.value.description,
          style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.7, fontSize: descriptionSize),
        ),
      ],
    );
  }
}
