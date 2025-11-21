import 'package:flutter/material.dart';
import '../../common_function/base_screen/base_screen.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/features/services/widgets/faq_section/service_faq_section.dart';
import 'package:portfolio/features/services/widgets/cta_section/cta_section.dart';
import 'package:portfolio/features/services/widgets/hero/services_hero_section.dart';
import 'package:portfolio/features/services/widgets/addons_section/addons_section.dart';
import 'package:portfolio/features/services/widgets/process_section/process_section.dart';
import 'package:portfolio/features/services/widgets/industry_section/industry_section.dart';
import 'package:portfolio/features/services/widgets/service_cards/service_cards_section.dart';

import '../../utility/responsive/responsive_helper.dart';

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

          Container(
            constraints: BoxConstraints(
              maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 1600),
            ),
            child: Center(
              child: Column(
                children: [
                  // Service Cards (Detailed)
                  const ServiceCardsSection(),

                  // Process Deep Dive
                  const ProcessSection(),

                  // Industry Expertise
                  const IndustrySection(),

                  //  Add-ons Available
                  const AddonsSection(),

                  // FAQ Accordion
                  const ServicesFaqSection(),
                ],
              ),
            ),
          ),

          // CTA Section
          const CtaSection(),
        ],
      ),
    );
  }
}
