import 'widgets/timeline_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/contact/timeline_step_model.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right:s.paddingMd ),
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

              // Timeline Steps
              _buildTimelineSteps(context, s),
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
          'What Happens Next?',
          style: fonts.headlineLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.paddingSm),
        Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
          ),
          child: Text(
            'Your journey from inquiry to delivery',
            style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms);
  }

  /// Timeline Steps with Staggered Animation
  Widget _buildTimelineSteps(BuildContext context, DSizes s) {
    final steps = TimelineStepModel.getAllSteps();

    return AnimationLimiter(
      child: Column(
        children: List.generate(steps.length, (index) {
          final isLast = index == steps.length - 1;

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: TimelineStep(step: steps[index], isLast: isLast),
              ),
            ),
          );
        }),
      ),
    ).animate(delay: 300.ms).fadeIn(duration: 600.ms);
  }
}
