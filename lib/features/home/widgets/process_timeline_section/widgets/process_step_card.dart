import 'package:flutter/material.dart';
import '../../../../../data_layer/model/services/process_step_model.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProcessStepCard extends StatefulWidget {
  final ProcessStepModel step;
  final bool isLast;

  const ProcessStepCard({super.key, required this.step, this.isLast = false});

  @override
  State<ProcessStepCard> createState() => _ProcessStepCardState();
}

class _ProcessStepCardState extends State<ProcessStepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: _mainCard(context, s, fonts)
          .animate(delay: Duration(milliseconds: 200 * widget.step.stepNumber))
          .fadeIn(duration: 600.ms)
          .slideY(begin: 0.3, end: 0, curve: Curves.easeOut)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
    );
  }

  Widget _mainCard(BuildContext context, DSizes s, AppFonts fonts) {
    return AnimatedContainer(
          duration: 250.ms,
          curve: Curves.easeOut,
          padding: EdgeInsets.all(s.paddingMd),
          decoration: BoxDecoration(
            color: _isHovered ? DColors.primaryButton.withAlpha(25) : DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(color: _isHovered ? DColors.primaryButton : DColors.cardBorder, width: 2),
            boxShadow: _isHovered
                ? [BoxShadow(color: DColors.primaryButton.withAlpha(80), blurRadius: 25, offset: const Offset(0, 12))]
                : [],
          ),
          child: Column(
            children: [
              // Number
              _stepNumber(s, fonts),
              SizedBox(height: s.spaceBtwItems),

              // ICON + LOOP ANIMATION
              _animatedIcon(context, s),
              SizedBox(height: s.spaceBtwItems),

              // Title
              Text(
                widget.step.title,
                style: fonts.titleLarge.rajdhani(
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: s.paddingSm),

              // Desc
              Text(
                widget.step.description,
                style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.6),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
        // 🪩 Hover scale feels premium
        .animate(target: _isHovered ? 1 : 0)
        .scaleXY(begin: 1, end: 1.05, duration: 180.ms, curve: Curves.easeOutBack);
  }

  // NUMBER BADGE
  Widget _stepNumber(DSizes s, AppFonts fonts) {
    return AnimatedContainer(
      duration: 250.ms,
      width: context.responsiveValue(mobile: 48.0, tablet: 56.0, desktop: 64.0),
      height: context.responsiveValue(mobile: 48.0, tablet: 56.0, desktop: 64.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: _isHovered
              ? [DColors.primaryButton, DColors.primaryButton.withAlpha(200)]
              : [DColors.primaryButton.withAlpha(200), DColors.primaryButton.withAlpha(120)],
        ),
        boxShadow: _isHovered
            ? [BoxShadow(color: DColors.primaryButton.withAlpha(80), blurRadius: 18, offset: const Offset(0, 6))]
            : [],
      ),
      child: Center(
        child: Text(
          "${widget.step.stepNumber}",
          style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ),
    );
  }

  // ICON (auto pulse loop)
  Widget _animatedIcon(BuildContext context, DSizes s) {
    return Icon(
          widget.step.icon,
          size: context.responsiveValue(mobile: 32.0, tablet: 36.0, desktop: 40.0),
          color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(begin: const Offset(1, 1), end: const Offset(1.15, 1.15), duration: 2000.ms, curve: Curves.easeInOut)
        .then()
        .scale(begin: const Offset(1.15, 1.15), end: const Offset(1, 1), duration: 2200.ms, curve: Curves.easeInOut);
  }
}
