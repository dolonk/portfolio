import 'widgets/info_badge.dart';
import 'widgets/calendly_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/contact/calendar_info_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CalendarSection extends StatelessWidget {
  const CalendarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 900),
          ),
          child: Column(
            children: [
              // Section Heading
              _buildSectionHeading(context, s),
              SizedBox(height: s.spaceBtwSections),

              // Calendly Widget
              CalendlyWidget(calendlyUrl: 'https://calendly.com/your-username/30min', height: 700),

              // Info Badges
              SizedBox(height: s.spaceBtwSections),
              _buildInfoBadges(context, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        Text(
          'Schedule a Free Consultation',
          style: fonts.headlineLarge.rajdhani(
            fontSize: context.responsiveValue(mobile: 28, tablet: 32, desktop: 36),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.paddingSm),
        Text(
          'Or pick a time that works for you',
          style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms);
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
