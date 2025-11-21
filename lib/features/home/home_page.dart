import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import '../../utility/responsive/responsive_helper.dart';
import 'widgets/process_timeline_section/process_timeline_section.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';
import 'package:portfolio/features/home/widgets/blog_section/blog_section.dart';
import 'package:portfolio/features/home/widgets/get_in_touch/get_in_touch.dart';
import 'package:portfolio/features/home/widgets/hero_section/hero_section.dart';
import 'package:portfolio/features/home/widgets/latest_projects/latest_projects.dart';
import 'package:portfolio/features/home/widgets/reviews_section/reviews_section.dart';
import 'package:portfolio/features/home/widgets/service_section/services_section.dart';
import 'package:portfolio/features/home/widgets/experience_section/experience_section.dart';
import 'package:portfolio/features/home/widgets/tech_stack_section/tech_stack_section.dart';
import 'package:portfolio/features/home/widgets/why_work_with_me_section/why_work_with_me_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: DColors.secondaryBackground,
      child: Column(
        children: [
          // Hero Section
          HeroSection(),

          Container(
            constraints: BoxConstraints(
              maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 1400),
            ),
            child: Center(
              child: Column(
                children: [
                  // Services Section
                  MyServiceSection(),

                  // Experience Section
                  ExperienceSection(),

                  // Latest Projects Section
                  LatestProjectsSection(),

                  // Why Choose Me Section
                  WhyWorkWithMeSection(),

                  // Tech Stack Section
                  TechStackSection(),

                  // Process Timeline Section
                  ProcessTimelineSection(),

                  // Reviews Section
                  ReviewsSection(),

                  // Blog Section
                  BlogSection(),
                ],
              ),
            ),
          ),

          // Get In Touch Section
          GetInTouchSection(),
        ],
      ),
    );
  }
}
