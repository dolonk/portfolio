import 'package:flutter/material.dart';
import 'widgets/pricing_card.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/pricing/pricing_tier_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PricingCardsSection extends StatelessWidget {
  const PricingCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final tiers = PricingTierModel.getAllTiers();

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 1400),
          ),
          child: Column(
            children: [
              _buildPricingCards(context, tiers, s),
              SizedBox(height: s.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCards(BuildContext context, List<PricingTierModel> tiers, DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 3);
    final spacing = context.responsiveValue(
      mobile: s.spaceBtwItems,
      tablet: s.spaceBtwSections * 0.75,
      desktop: s.spaceBtwSections,
    );

    // Mobile: Vertical list with stagger
    if (context.isMobile) {
      return AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) =>
                SlideAnimation(verticalOffset: 50.0, child: FadeInAnimation(child: widget)),
            children: tiers.map((tier) {
              return Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: PricingCard(tier: tier),
              );
            }).toList(),
          ),
        ),
      );
    }

    // Tablet/Desktop: Grid layout
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return AnimationLimiter(
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: tiers.asMap().entries.map((entry) {
              final index = entry.key;
              final tier = entry.value;

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: SizedBox(
                      width: cardWidth,
                      child: PricingCard(tier: tier),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
