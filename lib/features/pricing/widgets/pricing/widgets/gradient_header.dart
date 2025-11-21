import 'package:flutter/material.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/pricing/pricing_tier_model.dart';

class GradientHeader extends StatelessWidget {
  final PricingTierModel tier;

  const GradientHeader({super.key, required this.tier});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(mobile: s.paddingLg, desktop: s.paddingXl),
        vertical: context.responsiveValue(mobile: s.paddingLg, desktop: s.paddingXl),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: _getGradientColors()),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(s.borderRadiusLg),
          topRight: Radius.circular(s.borderRadiusLg),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tier Name + Icon
          Row(
            children: [
              Text(
                _getTierIcon(),
                style: TextStyle(fontSize: context.responsiveValue(mobile: 24, tablet: 28, desktop: 30)),
              ),
              SizedBox(width: s.paddingSm),
              Expanded(
                child: Text(
                  tier.name.toUpperCase(),
                  style: fonts.headlineMedium.rajdhani(
                    fontSize: context.responsiveValue(mobile: 24, tablet: 28, desktop: 30),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: s.paddingSm),

          // Tagline
          Text(tier.tagline, style: fonts.bodyMedium.rubik(color: Colors.white.withAlpha((255 * 0.9).round()))),
        ],
      ),
    );
  }

  /// Get gradient colors based on tier
  List<Color> _getGradientColors() {
    if (tier.name.toLowerCase() == 'starter') {
      return [Color(0xFF8B5CF6), Color(0xFF6366F1)]; // Purple gradient
    } else if (tier.name.toLowerCase() == 'pro') {
      return [Color(0xFFF59E0B), Color(0xFFFBBF24)]; // Gold gradient
    } else {
      return [Color(0xFF3B82F6), Color(0xFF2563EB)]; // Blue gradient
    }
  }

  /// Get tier icon
  String _getTierIcon() {
    if (tier.name.toLowerCase() == 'starter') {
      return '🚀';
    } else if (tier.name.toLowerCase() == 'pro') {
      return '💎';
    } else {
      return '🏆';
    }
  }
}
