import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import '../../utility/default_sizes/font_size.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utility/default_sizes/default_sizes.dart';

class DSectionHeader extends StatelessWidget {
  /// Main heading text (required)
  final String title;

  /// Optional subtitle/description text
  final String? subtitle;

  /// Optional small label above title (e.g., "ABOUT ME", "OUR SERVICES")
  final String? label;

  /// Text alignment (default: start)
  final TextAlign alignment;

  /// Title color (default: textPrimary)
  final Color? titleColor;

  /// Subtitle color (default: textSecondary)
  final Color? subtitleColor;

  /// Label color (default: primaryButton)
  final Color? labelColor;

  /// Show decorative underline below title
  final bool showUnderline;

  /// Underline color (default: primaryButton)
  final Color? underlineColor;

  /// Underline width (default: 100)
  final double? underlineWidth;

  /// Enable gradient effect on title
  final bool useGradient;

  /// Custom gradient colors (if useGradient is true)
  final List<Color>? gradientColors;

  /// Enable fade-in animation
  final bool animate;

  /// Animation delay in milliseconds
  final int animationDelay;

  /// Maximum width constraint for subtitle
  final double? maxWidth;

  /// Custom title text style (overrides default)
  final TextStyle? titleStyle;

  /// Custom subtitle text style (overrides default)
  final TextStyle? subtitleStyle;

  const DSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.label,
    this.alignment = TextAlign.start,
    this.titleColor,
    this.subtitleColor,
    this.labelColor,
    this.showUnderline = false,
    this.underlineColor,
    this.underlineWidth,
    this.useGradient = false,
    this.gradientColors,
    this.animate = true,
    this.animationDelay = 0,
    this.maxWidth,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final fonts = context.fonts;
    final s = context.sizes;

    Widget content = Column(
      crossAxisAlignment: _getCrossAxisAlignment(),
      children: [
        // Label (if provided)
        if (label != null) ...[
          Text(
            label!,
            style: fonts.bodyLarge.rubik(
              color: labelColor ?? DColors.primaryButton,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
            textAlign: alignment,
          ),
          SizedBox(height: s.paddingXs),
        ],

        // Title (with optional gradient)
        _buildTitle(context, fonts),

        // Underline (if enabled)
        if (showUnderline) ...[SizedBox(height: s.paddingXs), _buildUnderline()],

        // Subtitle (if provided)
        if (subtitle != null) ...[SizedBox(height: s.paddingXs), _buildSubtitle(context, fonts, s)],
      ],
    );

    // Add animation if enabled
    if (animate) {
      return content
          .animate()
          .fadeIn(duration: 600.ms, delay: animationDelay.ms)
          .slideY(begin: 0.1, duration: 600.ms, delay: animationDelay.ms);
    }

    return content;
  }

  /// Get CrossAxisAlignment based on TextAlign
  CrossAxisAlignment _getCrossAxisAlignment() {
    switch (alignment) {
      case TextAlign.center:
        return CrossAxisAlignment.center;
      case TextAlign.end:
      case TextAlign.right:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }

  /// Build title with optional gradient effect
  Widget _buildTitle(BuildContext context, AppFonts fonts) {
    final defaultStyle = titleStyle ?? fonts.displaySmall;

    final titleWidget = Text(
      title,
      style: defaultStyle.copyWith(color: useGradient ? Colors.white : (titleColor ?? DColors.textPrimary)),
      textAlign: alignment,
    );

    if (useGradient) {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: gradientColors ?? [DColors.textPrimary, DColors.primaryButton, const Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: titleWidget,
      );
    }

    return titleWidget;
  }

  /// Build decorative underline
  Widget _buildUnderline() {
    return Container(
      height: 4,
      width: underlineWidth ?? 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            underlineColor ?? DColors.primaryButton,
            (underlineColor ?? DColors.primaryButton).withAlpha((255 * 0.5).round()),
          ],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  /// Build subtitle text
  Widget _buildSubtitle(BuildContext context, AppFonts fonts, DSizes s) {
    Widget subtitleWidget = Text(
      subtitle!,
      style: subtitleStyle ?? fonts.bodyMedium.rubik(color: subtitleColor ?? DColors.textSecondary, height: 1.6),
      textAlign: alignment,
    );

    // Apply max width constraint if provided
    if (maxWidth != null) {
      return Container(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: subtitleWidget,
      );
    }

    return subtitleWidget;
  }
}
