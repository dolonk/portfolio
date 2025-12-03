import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import '../../../../../common_function/widgets/custom_button.dart';
import '../../../../../route/route_name.dart';
import '../../../../../utility/responsive/responsive_widget.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';
import 'package:portfolio/features/public_panel/home/widgets/experience_section/widgets/start_card.dart';
import 'package:portfolio/features/public_panel/home/widgets/experience_section/widgets/year_card.dart';


class HomeExperienceSection extends StatelessWidget {
  const HomeExperienceSection({super.key});

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
      padding: EdgeInsets.only(top: s.spaceBtwSections, left: s.paddingMd, right: s.paddingMd),
      child: Column(
        children: [
          // Section Header
          DSectionHeader(
            label: 'Journey & Achievements',
            title: 'Experience & Milestones',
            subtitle: 'Building innovative solutions with 3+ years of expertise in cross-platform development',
            alignment: TextAlign.center,
            maxWidth: 800,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Responsive Layout
          ResponsiveWidget(
            mobile: _buildMobileLayout(context),
            tablet: _buildTabletLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
          SizedBox(height: s.spaceBtwItems),

          // View Full Resume Button
          CustomButton(
            width: context.isMobile ? double.infinity : 260,
            height: 50,
            tittleText: 'View Full Resume',
            icon: Icons.description_rounded,
            onPressed: () => context.go(RouteNames.about),
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

    return Column(
      children: [
        // First Row
        Row(
          children: [
            _buildStatCard(stat: _stats[0], index: 0),
            SizedBox(width: s.spaceBtwItems),
            _buildStatCard(stat: _stats[1], index: 1),
          ],
        ),
        SizedBox(height: s.spaceBtwItems),
        // Second Row
        Row(
          children: [
            _buildStatCard(stat: _stats[2], index: 2),
            SizedBox(width: s.spaceBtwItems),
            _buildStatCard(stat: _stats[3], index: 3),
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

  Widget _buildStatCard({required Map<String, dynamic> stat, required int index}) {
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
