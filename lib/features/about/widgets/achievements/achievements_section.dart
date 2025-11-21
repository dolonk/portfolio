import 'package:flutter/material.dart';
import 'widgets/achievement_item.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/about/achievement_model.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 1200),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'MILESTONES',
                title: 'Achievements & Certifications',
                subtitle: 'Milestones and professional credentials',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Achievements Timeline
              _buildAchievementsTimeline(),
            ],
          ),
        ),
      ),
    );
  }

  /// Achievements Timeline
  Widget _buildAchievementsTimeline() {
    final achievements = AchievementModel.getAllAchievements();

    return Column(
      children: List.generate(achievements.length, (index) {
        final isLast = index == achievements.length - 1;
        return AchievementItem(achievement: achievements[index], isLast: isLast, delay: 200 + (index * 100));
      }),
    );
  }
}
