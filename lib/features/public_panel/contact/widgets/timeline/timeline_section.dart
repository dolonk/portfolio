import 'widgets/timeline_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/data_layer/model/contact/timeline_step_model.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 900),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'NEXT STEPS',
                title: 'What Happens Next?',
                subtitle: 'Here\'s my transparent process from first contact to project completion',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwSections),

              // Timeline Steps
              _buildTimelineSteps(context, s),
            ],
          ),
        ),
      ),
    );
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
