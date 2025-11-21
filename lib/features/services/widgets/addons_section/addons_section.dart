import 'widgets/addon_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route/route_name.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/constants/colors.dart';
import '../../../../common_function/widgets/responsive_grid.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/common_function/widgets/custom_button.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/services/addon_model.dart';

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
          // Section header
          DSectionHeader(
            label: 'ENHANCE YOUR PACKAGE',
            title: 'Additional Services Available',
            subtitle: 'Extend your project capabilities with these professional add-on services',
            alignment: TextAlign.center,
            maxWidth: 800,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Add-on Cards Grid
          DResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            animate: true,
            children: addons.map((addon) => AddonCard(addon: addon)).toList(),
          ),
          SizedBox(height: s.spaceBtwSections),

          // Bundle Discount Note
          _buildBundleDiscountNote(context, s),
        ],
      ),
    );
  }

  /// Bundle Discount Banner
  Widget _buildBundleDiscountNote(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    // Common Widgets
    final icon = Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
      ),
      child: Icon(Icons.local_offer_rounded, color: DColors.primaryButton, size: 32),
    );

    final textContent = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💰 Bundle Discount Available',
            style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingXs),
          Text(
            'Combine 3 or more add-ons and save 15% on your total',
            style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
          ),
        ],
      ),
    );

    final button = CustomButton(
      width: 150,
      height: 45,
      tittleText: 'Contact Us',
      onPressed: () => context.go(RouteNames.contact),
    );

    // List of widgets for the info part (icon and text)
    final infoWidgets = [icon, SizedBox(width: s.paddingMd), textContent];

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DColors.primaryButton.withAlpha((255 * 0.1).round()),
            DColors.primaryButton.withAlpha((255 * 0.05).round()),
          ],
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round()), width: 1.5),
      ),
      child: context.isMobile
          ? Column(
              children: [
                Row(children: infoWidgets),
                SizedBox(height: s.spaceBtwItems),
                button,
              ],
            )
          : Row(children: [...infoWidgets, button]),
    );
  }
}
