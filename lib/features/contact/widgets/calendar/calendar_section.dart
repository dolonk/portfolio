import 'widgets/info_badge.dart';
import 'widgets/calendly_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/data_layer/model/contact/calendar_info_model.dart';

class CalendarSection extends StatelessWidget {
  const CalendarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Heading
          DSectionHeader(
            label: 'BOOK A CALL',
            title: 'Schedule a Free Consultation',
            subtitle: 'Or pick a time that works for you',
            alignment: TextAlign.center,
            maxWidth: 700,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Calendly Widget
          CalendlyWidget(calendlyUrl: 'https://calendly.com/your-username/30min', height: 700),

          // Info Badges
          SizedBox(height: s.spaceBtwSections),
          _buildInfoBadges(context, s),
        ],
      ),
    );
  }

  /// Info Badges Below Calendar
  Widget _buildInfoBadges(BuildContext context, DSizes s) {
    final infoBadges = _getInfoBadges();

    return AnimationLimiter(
      child: Wrap(
        spacing: s.paddingMd,
        runSpacing: s.paddingMd,
        alignment: WrapAlignment.center,
        children: List.generate(infoBadges.length, (index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 20.0,
              child: FadeInAnimation(child: InfoBadge(info: infoBadges[index])),
            ),
          );
        }),
      ),
    ).animate(delay: 800.ms).fadeIn(duration: 600.ms);
  }

  /// Get Info Badges Data
  List<CalendarInfoModel> _getInfoBadges() {
    return [
      CalendarInfoModel(
        text: '30-minute free consultation',
        icon: Icons.schedule_rounded,
        color: const Color(0xFF8B5CF6), // Purple
      ),
      CalendarInfoModel(
        text: 'You\'ll receive email confirmation',
        icon: Icons.email_rounded,
        color: const Color(0xFF3B82F6), // Blue
      ),
      CalendarInfoModel(
        text: 'Pick a time that suits you best',
        icon: Icons.access_time_rounded,
        color: const Color(0xFF10B981), // Green
      ),
      CalendarInfoModel(
        text: 'No credit card required',
        icon: Icons.verified_user_rounded,
        color: const Color(0xFFF59E0B), // Orange
      ),
    ];
  }
}
