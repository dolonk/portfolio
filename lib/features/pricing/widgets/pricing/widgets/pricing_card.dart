import 'popular_badge.dart';
import 'gradient_header.dart';
import 'features_expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/route/route_name.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/common_function/style/custom_button.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/pricing/pricing_tier_model.dart';

class PricingCard extends StatefulWidget {
  final PricingTierModel tier;

  const PricingCard({super.key, required this.tier});

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse animation for popular card border
    if (widget.tier.isPopular) {
      _pulseController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this)
        ..repeat(reverse: true);

      _pulseAnimation = Tween<double>(
        begin: 1.0,
        end: 1.2,
      ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    }
  }

  @override
  void dispose() {
    if (widget.tier.isPopular) {
      _pulseController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final isPopular = widget.tier.isPopular;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..scale(isPopular && !context.isMobile ? (_isHovered ? 1.04 : 1.02) : (_isHovered ? 1.03 : 0.99))
          ..translate(0.0, _isHovered ? -10.0 : 0.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main card
            Container(
              decoration: BoxDecoration(
                color: DColors.cardBackground,
                borderRadius: BorderRadius.circular(s.borderRadiusLg),
                border: widget.tier.isPopular
                    ? Border.fromBorderSide(
                        BorderSide(
                          color: widget.tier.accentColor.withOpacity(
                            _isHovered ? 1.0 : (_pulseAnimation.value * 0.5).clamp(0.2, 0.7),
                          ),
                          width: 2,
                        ),
                      )
                    : Border.all(
                        color: _isHovered ? widget.tier.accentColor : DColors.cardBorder,
                        width: 1.5,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: isPopular
                        ? widget.tier.accentColor.withOpacity(_isHovered ? 0.5 : 0.3)
                        : Colors.black.withOpacity(_isHovered ? 0.2 : 0.08),
                    blurRadius: isPopular ? (_isHovered ? 35 : 25) : (_isHovered ? 25 : 12),
                    offset: Offset(0, _isHovered ? 15 : 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gradient Header
                  GradientHeader(tier: widget.tier),

                  // Card Body
                  Padding(
                    padding: EdgeInsets.all(s.paddingLg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price
                        _buildPrice(fonts, s),
                        SizedBox(height: s.paddingMd),

                        // Delivery Time
                        _buildDeliveryTime(fonts, s),
                        SizedBox(height: s.spaceBtwItems),

                        // Divider
                        Divider(color: DColors.cardBorder, height: 1),
                        SizedBox(height: s.spaceBtwItems),

                        // Top Features (Compact - 4-5 only)
                        _buildTopFeatures(fonts, s),
                        SizedBox(height: s.paddingMd),

                        // View All Features Button
                        FeaturesExpandable(tier: widget.tier),
                        SizedBox(height: s.spaceBtwItems),

                        // CTA Button
                        _buildCTAButton(fonts, s),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Popular Badge (Floating)
            if (isPopular)
              Positioned(
                top: -12,
                right: context.responsiveValue(mobile: 20, tablet: 30, desktop: 30),
                child: PopularBadge(),
              ),
          ],
        ),
      ),
    );
  }

  /// Price
  Widget _buildPrice(AppFonts fonts, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Starting from', style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
        SizedBox(height: s.paddingSm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$',
              style: fonts.headlineMedium.rajdhani(
                fontSize: context.responsiveValue(mobile: 24, tablet: 28, desktop: 30),
                fontWeight: FontWeight.bold,
                color: DColors.textPrimary,
              ),
            ),

            Text(
              widget.tier.price,
              style: fonts.displayMedium.rajdhani(
                fontSize: context.responsiveValue(mobile: 42, tablet: 50, desktop: 56),
                fontWeight: FontWeight.bold,
                color: DColors.textPrimary,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms).scale(begin: Offset(0.8, 0.8), duration: 600.ms),
        Text(
          '/project',
          style: fonts.labelMedium.rubik(
            fontSize: context.responsiveValue(mobile: 12, tablet: 13, desktop: 14),
            color: DColors.textSecondary,
          ),
        ),
      ],
    );
  }

  /// Delivery Time
  Widget _buildDeliveryTime(AppFonts fonts, DSizes s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: widget.tier.accentColor.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: widget.tier.accentColor.withAlpha((255 * 0.3).round()), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, color: widget.tier.accentColor, size: 16),
          SizedBox(width: s.paddingSm),
          Text(
            widget.tier.deliveryTime,
            style: fonts.bodyMedium.rubik(
              fontSize: context.responsiveValue(mobile: 13, tablet: 14, desktop: 14),
              fontWeight: FontWeight.w600,
              color: widget.tier.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Top Features (First 4-5 only)
  Widget _buildTopFeatures(AppFonts fonts, DSizes s) {
    final topFeatures = widget.tier.features.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TOP FEATURES',
          style: fonts.labelMedium.rajdhani(
            fontSize: context.responsiveValue(mobile: 12, tablet: 13, desktop: 14),
            fontWeight: FontWeight.bold,
            color: DColors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: s.paddingMd),
        ...topFeatures.map((feature) {
          return Padding(
            padding: EdgeInsets.only(bottom: s.paddingSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: widget.tier.accentColor,
                  size: context.responsiveValue(mobile: 16, tablet: 18, desktop: 18),
                ),
                SizedBox(width: s.paddingSm),
                Expanded(
                  child: Text(
                    feature.text,
                    style: fonts.bodySmall.rubik(
                      fontSize: context.responsiveValue(mobile: 13, tablet: 14, desktop: 14),
                      color: DColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  /// CTA Button
  Widget _buildCTAButton(AppFonts fonts, DSizes s) {
    return CustomButton(
      width: double.infinity,
      height: 50,
      tittleText: widget.tier.ctaText,
      onPressed: () {
        context.go(RouteNames.contact);
      },
    );
  }
}
