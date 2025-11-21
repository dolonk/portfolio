import 'widgets/addon_card.dart';
import 'package:flutter/material.dart';
import 'widgets/bundle_discount_banner.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/pricing/addon_service_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PriceAddonsSection extends StatelessWidget {
  const PriceAddonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final addons = AddonServiceModel.getAllAddons();

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 1000, desktop: 1400),
          ),
          child: Column(
            children: [
              // Section Heading
              _buildSectionHeading(fonts, s),
              SizedBox(height: s.spaceBtwSections),

              // Add-on Cards Grid
              _buildAddonsGrid(context, addons, s),
              SizedBox(height: s.spaceBtwSections),

              // Bundle Discount Banner
              BundleDiscountBanner(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(AppFonts fonts, DSizes s) {
    return Column(
      children: [
        Text(
          'Enhance Your Package',
          style: fonts.headlineLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.paddingSm),
        Text(
          'Additional services available for all tiers',
          style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Add-ons Grid
  Widget _buildAddonsGrid(BuildContext context, List<AddonServiceModel> addons, DSizes s) {
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
            children: addons.map((addon) {
              return Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: AddonCard(addon: addon),
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
            children: addons.asMap().entries.map((entry) {
              final index = entry.key;
              final addon = entry.value;

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: SizedBox(
                      width: cardWidth,
                      child: AddonCard(addon: addon),
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
