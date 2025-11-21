import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/contact/timeline_step_model.dart';

class TimelineStep extends StatefulWidget {
  final TimelineStepModel step;
  final bool isLast;

  const TimelineStep({super.key, required this.step, this.isLast = false});

  @override
  State<TimelineStep> createState() => _TimelineStepState();
}

class _TimelineStepState extends State<TimelineStep> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Circle + Line
          Column(
            children: [
              // Circle with Icon + Number
              _buildCircle(context, s),

              // Connecting Line (if not last step)
              if (!widget.isLast) _buildConnectingLine(s),
            ],
          ),

          SizedBox(
            width: context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingXl),
          ),

          // Right Side: Content
          Expanded(child: _buildContent(context, s)),
        ],
      ),
    );
  }

  /// Circle with Icon + Number
  Widget _buildCircle(BuildContext context, DSizes s) {
    final circleSize = context.responsiveValue(mobile: 70.0, tablet: 80.0, desktop: 90.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: circleSize,
      height: circleSize,
      transform: Matrix4.diagonal3Values(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0, 1.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [widget.step.accentColor, widget.step.accentColor.withAlpha((255 * 0.7).round())],
        ),
        boxShadow: [
          BoxShadow(
            color: widget.step.accentColor.withAlpha((255 * (_isHovered ? 0.4 : 0.2)).round()),
            blurRadius: _isHovered ? 20 : 12,
            offset: Offset(0, _isHovered ? 6 : 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Icon
          Icon(
            widget.step.icon,
            size: context.responsiveValue(mobile: 28.0, tablet: 32.0, desktop: 36.0),
            color: Colors.white,
          ),

          // Step Number (Bottom Right)
          Positioned(
            bottom: context.responsiveValue(mobile: 8.0, tablet: 10.0, desktop: 12.0),
            right: context.responsiveValue(mobile: 8.0, tablet: 10.0, desktop: 12.0),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: widget.step.accentColor, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '${widget.step.step}',
                style: context.fonts.bodySmall.rubik(
                  fontWeight: FontWeight.bold,
                  color: widget.step.accentColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Connecting Line Between Steps
  Widget _buildConnectingLine(DSizes s) {
    return Container(
      width: 3,
      height: context.responsiveValue(mobile: 60.0, tablet: 70.0, desktop: 80.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.step.accentColor.withAlpha((255 * 0.6).round()),
            widget.step.accentColor.withAlpha((255 * 0.2).round()),
          ],
        ),
      ),
    );
  }

  /// Content (Title + Description)
  Widget _buildContent(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(bottom: widget.isLast ? 0 : s.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.step.title,
            style: fonts.headlineSmall.rajdhani(
              fontWeight: FontWeight.bold,
              color: _isHovered ? widget.step.accentColor : DColors.textPrimary,
            ),
          ),
          SizedBox(height: s.paddingSm),

          // Description
          Text(widget.step.description, style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6)),
        ],
      ),
    );
  }
}
