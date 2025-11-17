import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/about/value_model.dart';

class ValueItem extends StatefulWidget {
  final ValueModel value;
  final int delay;

  const ValueItem({super.key, required this.value, this.delay = 0});

  @override
  State<ValueItem> createState() => _ValueItemState();
}

class _ValueItemState extends State<ValueItem> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Icon pulse animation
    _pulseController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this)
      ..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.identity()..translate(_isHovered ? 8.0 : 0.0, 0.0),
                margin: EdgeInsets.only(bottom: s.spaceBtwItems),
                padding: EdgeInsets.all(
                  context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
                ),
                decoration: BoxDecoration(
                  color: DColors.cardBackground,
                  borderRadius: BorderRadius.circular(s.borderRadiusMd),
                  border: Border.all(
                    color: _isHovered
                        ? widget.value.accentColor
                        : widget.value.accentColor.withAlpha((255 * 0.3).round()),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? widget.value.accentColor.withAlpha((255 * 0.2).round())
                          : Colors.black.withAlpha((255 * 0.05).round()),
                      blurRadius: _isHovered ? 20 : 10,
                      offset: Offset(0, _isHovered ? 6 : 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: Icon
                    _buildIcon(context, s),
                    SizedBox(
                      width: context.responsiveValue(
                        mobile: s.paddingMd,
                        tablet: s.paddingLg,
                        desktop: s.paddingXl,
                      ),
                    ),

                    // Right: Content
                    Expanded(child: _buildContent(context, s)),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: widget.delay.ms)
              .slideX(begin: -0.1, duration: 600.ms, delay: widget.delay.ms),
    );
  }

  /// Icon with Pulse Animation
  Widget _buildIcon(BuildContext context, DSizes s) {
    final iconSize = context.responsiveValue(mobile: 50.0, tablet: 55.0, desktop: 60.0);

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isHovered ? 1.1 : _pulseAnimation.value,
          child: Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [widget.value.accentColor, widget.value.accentColor.withAlpha((255 * 0.7).round())],
              ),
              borderRadius: BorderRadius.circular(s.borderRadiusMd),
              boxShadow: [
                BoxShadow(
                  color: widget.value.accentColor.withAlpha((255 * 0.4).round()),
                  blurRadius: _isHovered ? 15 : 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(widget.value.icon, color: Colors.white, size: iconSize * 0.55),
          ),
        );
      },
    );
  }

  /// Content (Title + Description)
  Widget _buildContent(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          widget.value.title,
          style: fonts.headlineSmall.rajdhani(
            fontSize: context.responsiveValue(mobile: 20.0, tablet: 22.0, desktop: 24.0),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
        ),
        SizedBox(height: s.paddingSm),

        // Description
        Text(
          widget.value.description,
          style: fonts.bodyMedium.rubik(
            color: DColors.textSecondary,
            height: 1.7,
            fontSize: context.responsiveValue(mobile: 14.0, tablet: 15.0, desktop: 16.0),
          ),
        ),
      ],
    );
  }
}
