import 'package:flutter/material.dart';
import '../project_detail/widgets/cta/cta_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import '../../../utility/responsive/responsive_helper.dart';
import '../../../common_function/base_screen/base_screen.dart';
import 'package:portfolio/features/public_panel/services/widgets/addons_section/addons_section.dart';
import 'package:portfolio/features/public_panel/services/widgets/faq_section/service_faq_section.dart';
import 'package:portfolio/features/public_panel/services/widgets/hero/services_hero_section.dart';
import 'package:portfolio/features/public_panel/services/widgets/industry_section/industry_section.dart';
import 'package:portfolio/features/public_panel/services/widgets/process_section/process_section.dart';
import 'package:portfolio/features/public_panel/services/widgets/service_cards/service_cards_section.dart';

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
