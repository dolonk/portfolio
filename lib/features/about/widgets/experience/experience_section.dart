import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/about/experience_model.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'widgets/experience_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
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
                label: 'CAREER JOURNEY',
                title: 'Professional Experience',
                subtitle: 'My journey in the tech industry',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Experience Timeline
              _buildExperienceTimeline(),
            ],
          ),
        ),
      ),
    );
  }

  /// Experience Timeline
  Widget _buildExperienceTimeline() {
    final experiences = ExperienceModel.getAllExperiences();

    return Column(
      children: List.generate(experiences.length, (index) {
        final isLast = index == experiences.length - 1;
        return ExperienceCard(experience: experiences[index], isLast: isLast, delay: 200 + (index * 100));
      }),
    );
  }
}
