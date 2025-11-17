import 'package:flutter/material.dart';
import '../../../../../data_layer/model/services/process_step_model.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';

class ProcessStepCard extends StatefulWidget {
  final ProcessStepModel step;
  final bool isLast;

  const ProcessStepCard({super.key, required this.step, this.isLast = false});

  @override
  State<ProcessStepCard> createState() => _ProcessStepCardState();
}

class _ProcessStepCardState extends State<ProcessStepCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    // Staggered animation
    Future.delayed(Duration(milliseconds: 200 * widget.step.stepNumber), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: context.isDesktop ? _buildDesktopLayout(context, s, fonts) : _buildMobileLayout(context, s, fonts),
          ),
        ),
      ),
    );
  }

  // 💻 Desktop Layout - Horizontal with connector
  Widget _buildDesktopLayout(BuildContext context, DSizes s, AppFonts fonts) {
    return Column(
      children: [
        // Step Card
        _buildStepCard(context, s, fonts),

        // Connector Line (if not last)
        if (!widget.isLast)
          Container(
            width: 2,
            height: 60,
            margin: EdgeInsets.symmetric(vertical: s.paddingSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [DColors.primaryButton, DColors.primaryButton.withAlpha((255 * 0.3).round())],
              ),
            ),
          ),
      ],
    );
  }

  // 📱 Mobile Layout - Vertical with side connector
  Widget _buildMobileLayout(BuildContext context, DSizes s, AppFonts fonts) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Number + Connector
        Column(
          children: [
            // Step Number Circle
            _buildStepNumber(s, fonts),

            // Connector Line
            if (!widget.isLast)
              Container(
                width: 2,
                height: 100,
                margin: EdgeInsets.only(top: s.paddingSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [DColors.primaryButton, DColors.primaryButton.withAlpha((255 * 0.3).round())],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: s.spaceBtwItems),

        // Right: Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: widget.isLast ? 0 : s.spaceBtwSections),
            child: _buildStepContent(context, s, fonts),
          ),
        ),
      ],
    );
  }

  // 🎴 Step Card (Desktop)
  Widget _buildStepCard(BuildContext context, DSizes s, AppFonts fonts) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: _isHovered ? DColors.primaryButton.withAlpha((255 * 0.1).round()) : DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: _isHovered ? DColors.primaryButton : DColors.cardBorder, width: 2),
        boxShadow: _isHovered
            ? [
                BoxShadow(
                  color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          // Step Number
          _buildStepNumber(s, fonts),
          SizedBox(height: s.spaceBtwItems),

          // Icon
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(s.paddingMd),
            decoration: BoxDecoration(
              color: _isHovered
                  ? DColors.primaryButton.withAlpha((255 * 0.2).round())
                  : DColors.primaryButton.withAlpha((255 * 0.1).round()),
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? DColors.primaryButton : DColors.primaryButton.withAlpha((255 * 0.3).round()),
                width: 2,
              ),
            ),
            child: Icon(
              widget.step.icon,
              size: context.responsiveValue(mobile: 32.0, tablet: 36.0, desktop: 40.0),
              color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Title
          Text(
            widget.step.title,
            style: fonts.titleLarge.rajdhani(
              fontWeight: FontWeight.bold,
              color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: s.paddingSm),

          // Description
          Text(
            widget.step.description,
            style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // 📝 Step Content (Mobile)
  Widget _buildStepContent(BuildContext context, DSizes s, AppFonts fonts) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: _isHovered ? DColors.primaryButton.withAlpha((255 * 0.1).round()) : DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: _isHovered ? DColors.primaryButton : DColors.cardBorder, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + Title Row
          Row(
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(s.paddingSm),
                decoration: BoxDecoration(
                  color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round()), width: 2),
                ),
                child: Icon(
                  widget.step.icon,
                  size: 24,
                  color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
                ),
              ),
              SizedBox(width: s.spaceBtwItems),

              // Title
              Expanded(
                child: Text(
                  widget.step.title,
                  style: fonts.titleMedium.rajdhani(
                    fontWeight: FontWeight.bold,
                    color: _isHovered ? DColors.primaryButton : DColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: s.spaceBtwItems),

          // Description
          Text(
            widget.step.description,
            style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.6),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // 🔢 Step Number Badge
  Widget _buildStepNumber(DSizes s, AppFonts fonts) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: context.responsiveValue(mobile: 48.0, tablet: 56.0, desktop: 64.0),
      height: context.responsiveValue(mobile: 48.0, tablet: 56.0, desktop: 64.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isHovered
              ? [DColors.primaryButton, DColors.primaryButton.withAlpha((255 * 0.7).round())]
              : [
                  DColors.primaryButton.withAlpha((255 * 0.8).round()),
                  DColors.primaryButton.withAlpha((255 * 0.5).round()),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: _isHovered
            ? [
                BoxShadow(
                  color: DColors.primaryButton.withAlpha((255 * 0.4).round()),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          '${widget.step.stepNumber}',
          style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ),
    );
  }
}
