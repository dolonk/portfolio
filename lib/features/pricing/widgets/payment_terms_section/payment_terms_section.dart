import 'package:flutter/material.dart';
import 'widgets/payment_timeline.dart';
import 'widgets/payment_methods_card.dart';
import 'widgets/payment_policies_card.dart';

import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class PaymentTermsSection extends StatelessWidget {
  const PaymentTermsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
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

              // Payment Timeline
              PaymentTimeline(),
              SizedBox(height: s.spaceBtwSections),

              // Payment Methods Card
              PaymentMethodsCard(),
              SizedBox(height: s.spaceBtwItems),

              // Payment Policies
              PaymentPoliciesCard(),
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
        Text('How Payment Works', style: fonts.headlineLarge, textAlign: TextAlign.center),
        SizedBox(height: s.paddingSm),
        Text(
          'Transparent, milestone-based payment structure',
          style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
