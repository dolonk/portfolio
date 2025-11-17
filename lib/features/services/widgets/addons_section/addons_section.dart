import 'package:go_router/go_router.dart';
import 'package:responsive_website/common_function/style/custom_button.dart';
import 'package:responsive_website/route/route_name.dart';

import 'widgets/addon_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/common_function/style/section_header.dart';
import 'package:responsive_website/data_layer/model/services/addon_model.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class AddonsSection extends StatelessWidget {
  const AddonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final addons = AddonModel.getAllAddons();

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Column(
        children: [
          // Section Header
          const SectionHeader(
            subtitle: 'Enhance Your Package',
            title: 'Additional Services Available',
            description: 'Extend your project capabilities with these professional add-on services',
          ),
          SizedBox(height: s.spaceBtwItems),

          // Add-on Cards Grid
          _buildAddonsGrid(context, addons, s),

          SizedBox(height: s.spaceBtwSections),

          // Bundle Discount Note (Bottom)
          _buildBundleDiscountNote(context, s),
        ],
      ),
    );
  }

  /// Add-ons Cards Grid Layout
  Widget _buildAddonsGrid(BuildContext context, List<AddonModel> addons, DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 3);
    final spacing = s.spaceBtwItems;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: addons.map((addon) {
            return SizedBox(
              width: context.isMobile ? double.infinity : cardWidth,
              child: AddonCard(addon: addon),
            );
          }).toList(),
        );
      },
    );
  }

  /// Bundle Discount Note (Highlighted Box at Bottom)
  Widget _buildBundleDiscountNote(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DColors.primaryButton.withAlpha((255 * 0.1).round()),
            DColors.primaryButton.withAlpha((255 * 0.05).round()),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round()), width: 2),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(s.paddingMd),
            decoration: BoxDecoration(
              color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.card_giftcard_rounded, color: DColors.primaryButton, size: 32),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Heading
          Text(
            'Bundle & Save!',
            style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.primaryButton),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.paddingSm),

          // Description
          Container(
            constraints: BoxConstraints(
              maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
            ),
            child: Text(
              'Mix and match any add-ons with your chosen package. Bundle discounts available for 3+ services.',
              style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // CTA Button
          CustomButton(tittleText: 'Contact for Bundle Quote', onPressed: () => context.go(RouteNames.contact)),
        ],
      ),
    );
  }
}
