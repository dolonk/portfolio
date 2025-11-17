import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_widget.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/common_function/style/section_header.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/features/home/widgets/experience_section/widgets/start_card.dart';
import 'package:responsive_website/features/home/widgets/experience_section/widgets/year_card.dart';

import '../../../../common_function/widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  // Data for the sections
  static const List<Map<String, dynamic>> _stats = [
    {'icon': '📱', 'number': 50, 'title': 'Projects Completed'},
    {'icon': '⭐', 'number': 30, 'title': 'Happy Clients'},
    {'icon': '🚀', 'number': 4, 'title': 'Platforms Mastered'},
    {'icon': '💯', 'number': 98, 'title': 'Client Satisfaction'},
  ];

  static const List<Map<String, dynamic>> _timelineData = [
    {'year': 2022, 'description': 'Started Flutter Development Journey with First Production App'},
    {'year': 2023, 'description': 'Built 20+ Cross-Platform Apps for Startups & Enterprises'},
    {'year': 2024, 'description': 'Achieved Senior Developer Status with Advanced Architecture Skills'},
    {'year': 2025, 'description': 'Leading Enterprise Projects & Mentoring Junior Developers'},
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.only(top: s.spaceBtwSections, left: s.paddingMd, right: s.paddingMd),
      child: Column(
        children: [
          DSectionHeader(
            label: 'Journey & Achievements',
            title: 'Experience & Milestones',
            subtitle: 'Building innovative solutions with 3+ years of expertise in cross-platform development',
            alignment: TextAlign.center,
            maxWidth: 800,
          ),
          SizedBox(height: s.spaceBtwItems),
          ResponsiveWidget(
            mobile: _buildMobileLayout(context),
            tablet: _buildTabletLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  // 📱 MOBILE LAYOUT
  Widget _buildMobileLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      children: [
        _buildStatsSection(context, isMobile: true),
        SizedBox(height: s.spaceBtwItems),

        SizedBox(height: 400, child: _buildTimelineSection(context, isVertical: true)),
      ],
    );
  }

  // 📱 TABLET LAYOUT
  Widget _buildTabletLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      children: [
        _buildStatsSection(context, isMobile: false),
        SizedBox(height: s.spaceBtwItems),

        _buildTimelineSection(context, isVertical: false),
      ],
    );
  }

  // 💻 DESKTOP LAYOUT
  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;

    return SizedBox(
      height: 450,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 6, child: _buildStatsSection(context, isMobile: false)),
          SizedBox(width: s.spaceBtwItems * 2),

          Expanded(flex: 4, child: _buildTimelineSection(context, isVertical: true)),
        ],
      ),
    );
  }

  // STATS SECTION
  Widget _buildStatsSection(BuildContext context, {required bool isMobile}) {
    final s = context.sizes;

    if (isMobile) {
      // Mobile: Vertical stack with aspect ratio
      return Column(
        children: List.generate(_stats.length, (index) {
          final stat = _stats[index];
          return Padding(
            padding: EdgeInsets.only(bottom: index < _stats.length - 1 ? s.spaceBtwItems : 0),
            child: AspectRatio(
              aspectRatio: 2.5, // Width:Height ratio
              child: StartCard(
                icon: stat['icon'] as String,
                number: stat['number'] as int,
                title: stat['title'] as String,
                index: index,
              ),
            ),
          );
        }),
      );
    }

    final spacing = s.spaceBtwItems;
    final aspectRatio = context.isTablet ? 1.6 : 1.4;

    return Column(
      children: [
        // First Row
        Row(
          children: [
            _buildStatCard(stat: _stats[0], index: 0, aspectRatio: aspectRatio),
            SizedBox(width: spacing),
            _buildStatCard(stat: _stats[1], index: 1, aspectRatio: aspectRatio),
          ],
        ),
        SizedBox(height: spacing),
        // Second Row
        Row(
          children: [
            _buildStatCard(stat: _stats[2], index: 2, aspectRatio: aspectRatio),
            SizedBox(width: spacing),
            _buildStatCard(stat: _stats[3], index: 3, aspectRatio: aspectRatio),
          ],
        ),
      ],
    );
  }

  // TIMELINE SECTION
  Widget _buildTimelineSection(BuildContext context, {required bool isVertical}) {
    // Mobile & Desktop: Vertical timeline
    if (isVertical) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTimelineCard(data: _timelineData[0], index: 0),
          SizedBox(height: context.sizes.spaceBtwItems),
          _buildTimelineCard(data: _timelineData[1], index: 1),
          SizedBox(height: context.sizes.spaceBtwItems),
          _buildTimelineCard(data: _timelineData[2], index: 2),
          SizedBox(height: context.sizes.spaceBtwItems),
          _buildTimelineCard(data: _timelineData[3], index: 3),
        ],
      );
    }

    // Tablet: Horizontal scroll
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_timelineData.length, (index) {
          final data = _timelineData[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
            child: YearCard(year: data['year'] as int, description: data['description'] as String, index: index),
          );
        }),
      ),
    );
  }

  Widget _buildStatCard({required Map<String, dynamic> stat, required int index, required double aspectRatio}) {
    return Expanded(
      child: StartCard(
        icon: stat['icon'] as String,
        number: stat['number'] as int,
        title: stat['title'] as String,
        index: index,
      ),
    );
  }

  Widget _buildTimelineCard({required Map<String, dynamic> data, required int index}) {
    return Expanded(
      child: YearCard(year: data['year'] as int, description: data['description'] as String, index: index),
    );
  }
}
