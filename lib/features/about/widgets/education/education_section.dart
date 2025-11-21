import 'widgets/education_card.dart';
import 'package:flutter/material.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/about/education_model.dart';

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
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 900, desktop: 1400),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'ACADEMIC BACKGROUND',
                title: 'Education',
                subtitle: 'My academic journey and qualifications',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Education Cards
              _buildEducationCards(s),
            ],
          ),
        ),
      ),
    );
  }

  /// Education Cards
  Widget _buildEducationCards(DSizes s) {
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
