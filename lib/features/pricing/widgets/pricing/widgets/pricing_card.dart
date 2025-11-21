import 'popular_badge.dart';
import 'gradient_header.dart';
import 'features_expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/route/route_name.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/common_function/widgets/custom_button.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/pricing/pricing_tier_model.dart';

class PricingCard extends StatefulWidget {
  final PricingTierModel tier;

  const PricingCard({super.key, required this.tier});

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final tier = widget.tier;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(s.borderRadiusLg),
                  border: Border.all(
                    color: tier.isPopular
                        ? tier.accentColor.withAlpha(_isHovered ? 255 : 153)
                        : (_isHovered ? tier.accentColor : DColors.cardBorder),
                    width: tier.isPopular ? 2 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: tier.isPopular
                          ? tier.accentColor.withAlpha(_isHovered ? 77 : 26)
                          : Colors.black.withAlpha(_isHovered ? 38 : 18),
                      blurRadius: _isHovered ? 30 : 15,
                      offset: Offset(0, _isHovered ? 12 : 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientHeader(tier: tier),

                    Padding(
                      padding: EdgeInsets.all(s.paddingLg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPrice(context),
                          SizedBox(height: s.paddingMd),

                          _buildDelivery(context),
                          SizedBox(height: s.spaceBtwItems),

                          Divider(height: 1, color: DColors.cardBorder),
                          SizedBox(height: s.spaceBtwItems),

                          _buildTopFeatures(context),
                          SizedBox(height: s.paddingMd),

                          FeaturesExpandable(tier: tier),
                          SizedBox(height: s.spaceBtwItems),

                          _buildCTA(context),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              // hover scale
              .animate(target: _isHovered ? 1 : 0)
              .scale(
                begin: Offset(1, 1),
                end: tier.isPopular ? Offset(1.05, 1.05) : Offset(1.03, 1.03),
                duration: 350.ms,
                curve: Curves.easeOut,
              )
              // popular pulse animation
              .animate()
              .scale(
                begin: Offset(1, 1),
                end: Offset(tier.isPopular ? 1.02 : 1.0, tier.isPopular ? 1.02 : 1.0),
                duration: 2000.ms,
                curve: Curves.easeInOut,
              ),
          if (tier.isPopular)
            Positioned(
              top: -12,
              right: context.responsiveValue(mobile: 20, tablet: 30, desktop: 30),
              child: PopularBadge(),
            ),
        ],
      ),
    );
  }

  // --- SECTION BUILDERS -------------------------------------------------------
  Widget _buildPrice(BuildContext context) {
    final fonts = context.fonts;
    final s = context.sizes;
    final tier = widget.tier;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Starting from", style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
        SizedBox(height: s.paddingSm),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\$",
              style: fonts.headlineMedium.rajdhani(
                fontSize: context.responsiveValue(mobile: 24, tablet: 28, desktop: 30),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              tier.price,
              style: fonts.displayMedium.rajdhani(
                fontSize: context.responsiveValue(mobile: 42, tablet: 50, desktop: 56),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms).scale(begin: Offset(.8, .8), duration: 500.ms),

        Text("/project", style: fonts.labelMedium.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  Widget _buildDelivery(BuildContext context) {
    final tier = widget.tier;
    final fonts = context.fonts;
    final s = context.sizes;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: tier.accentColor.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: tier.accentColor.withAlpha((0.3 * 255).round())),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, color: tier.accentColor, size: 16),
          SizedBox(width: s.paddingSm),
          Text(
            tier.deliveryTime,
            style: fonts.bodyMedium.rubik(color: tier.accentColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildTopFeatures(BuildContext context) {
    final tier = widget.tier;
    final fonts = context.fonts;
    final s = context.sizes;
    final top = tier.features.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TOP FEATURES",
          style: fonts.labelMedium.rajdhani(
            color: DColors.textSecondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: s.paddingMd),

        ...top.map((f) {
          return Padding(
            padding: EdgeInsets.only(bottom: s.paddingSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_rounded, color: tier.accentColor, size: 18),
                SizedBox(width: s.paddingSm),
                Expanded(
                  child: Text(f.text, style: fonts.bodySmall.rubik(color: DColors.textPrimary)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCTA(BuildContext context) {
    final tier = widget.tier;
    return CustomButton(
      width: double.infinity,
      height: 50,
      tittleText: tier.ctaText,
      onPressed: () => context.go(RouteNames.contact),
    );
  }
}
