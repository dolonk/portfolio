import 'package:flutter/material.dart';
import 'widgets/faq/contact_faq_section.dart';
import 'widgets/timeline/timeline_section.dart';
import 'widgets/calendar/calendar_section.dart';
import 'widgets/testimonials/testimonials_section.dart';
import 'widgets/social_links/social_links_section.dart';
import 'widgets/availability/availability_section.dart';
import 'widgets/contact_form/contact_form_section.dart';
import 'widgets/contact_options/contact_options_section.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/common_function/base_screen/base_screen.dart';
import 'package:responsive_website/features/contact/widgets/hero_section/contact_hero_section.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey _contactFormKey = GlobalKey();

  void _scrollToContactForm() {
    if (_contactFormKey.currentContext != null) {
      Scrollable.ensureVisible(
        _contactFormKey.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: DColors.background,
      child: Column(
        children: [
          // Hero Section
          const ContactHeroSection(),

          // Contact Options
          ContactOptionsSection(onScrollToForm: _scrollToContactForm),

          // Contact Form
          ContactFormSection(key: _contactFormKey),

          // Calendar Integration
          const CalendarSection(),

          // Social Links
          const SocialLinksSection(),

          // FAQ section
          const ContactFaqSection(),

          // Availability Status
          const AvailabilitySection(),

          // What Happens Next (Timeline)
          const TimelineSection(),

          // Testimonials section
          const TestimonialsSection(),
        ],
      ),
    );
  }
}
