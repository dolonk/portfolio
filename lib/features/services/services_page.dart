import 'package:flutter/material.dart';
import '../../common_function/base_screen/base_screen.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/features/services/widgets/faq_section/faq_section.dart';
import 'package:responsive_website/features/services/widgets/cta_section/cta_section.dart';
import 'package:responsive_website/features/services/widgets/hero/services_hero_section.dart';
import 'package:responsive_website/features/services/widgets/addons_section/addons_section.dart';
import 'package:responsive_website/features/services/widgets/process_section/process_section.dart';
import 'package:responsive_website/features/services/widgets/industry_section/industry_section.dart';
import 'package:responsive_website/features/services/widgets/service_cards/service_cards_section.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: DColors.background,
      child: Column(
        children: [
          // Hero Section
          const ServicesHeroSection(),

          // Service Cards (Detailed)
          const ServiceCardsSection(),

          // Process Deep Dive
          const ProcessSection(),

          // Industry Expertise
          const IndustrySection(),

          //  Add-ons Available
          const AddonsSection(),

          // FAQ Accordion
          const FaqSection(),

          // CTA Section
          const CtaSection(),
        ],
      ),
    );
  }
}
