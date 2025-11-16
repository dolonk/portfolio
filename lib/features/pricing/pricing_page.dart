import 'package:flutter/material.dart';
import 'package:responsive_website/features/pricing/widgets/faq_section/faq_section.dart';
import 'widgets/pricing/price_into_section/pricing_intro_section.dart';
import 'widgets/hero_section/pricing_hero_section.dart';
import 'widgets/custom_cta_section/custom_cta_section.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/common_function/base_screen/base_screen.dart';
import 'package:responsive_website/features/pricing/widgets/addons_section/addons_section.dart';
import 'package:responsive_website/features/pricing/widgets/comparison_section/comparison_section.dart';
import 'package:responsive_website/features/pricing/widgets/pricing/pricing_cards_section.dart';
import 'package:responsive_website/features/pricing/widgets/payment_terms_section/payment_terms_section.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: DColors.background,
      child: Column(
        children: [
          // Hero Section
          PricingHeroSection(),

          // Intro
          PricingIntroSection(),

          // Pricing Cards
          PricingCardsSection(),

          // Comparison Table
          ComparisonSection(),

          // Custom CTA
          PriceCustomCtaSection(),

          // Add-on Services
          PriceAddonsSection(),

          // Payment Terms
          PaymentTermsSection(),

          // FAQ
          PriceFaqSection(),
        ],
      ),
    );
  }
}
