import 'widgets/education_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/about/education_model.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 900, desktop: 1200),
          ),
          child: Column(
            children: [
              // Section Heading
              _buildSectionHeading(context, s),
              SizedBox(height: s.spaceBtwItems),

              // Education Cards
              _buildEducationCards(context, s),
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
          'Education',
          style: fonts.headlineLarge.rajdhani(
            fontSize: context.responsiveValue(mobile: 28, tablet: 32, desktop: 36),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.paddingSm),
        Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
          ),
          child: Text(
            'Academic background and qualifications',
            style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms);
  }

  /// Education Cards
  Widget _buildEducationCards(BuildContext context, DSizes s) {
    final educationList = EducationModel.getAllEducation();

    return Column(
      children: educationList.map((education) {
        return Padding(
          padding: EdgeInsets.only(bottom: s.spaceBtwItems),
          child: EducationCard(education: education),
        );
      }).toList(),
    );
  }
}
