import 'package:flutter/material.dart';
import 'package:portfolio/features/about/widgets/cta/cta_section.dart';
import 'package:portfolio/features/about/widgets/experience/experience_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'widgets/achievements/achievements_section.dart';
import 'widgets/education/education_section.dart';
import 'widgets/hero_section/about_hero_section.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';

import 'widgets/my_story/my_story_section.dart';
import 'widgets/skills/skills_section.dart';
import 'widgets/tools/tools_section.dart';
import 'widgets/values/values_section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      backgroundColor: DColors.background,
      child: Column(
        children: [
          // Hero
          AboutHeroSection(),

          // My Story
          MyStorySection(),

          // Skills Showcase
          SkillsSection(),

          // Professional Experience
          ExperienceSection(),

          // Education
          EducationSection(),

          // Achievements & Certifications
          AchievementsSection(),

          // Development Tools
          ToolsSection(),

          // What I Bring
          ValuesSection(),

          // CTA (Call-to-Action)
          CTASection(),
        ],
      ),
    );
  }
}
