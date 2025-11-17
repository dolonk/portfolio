import 'widgets/industry_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/services/industry_model.dart';
import 'package:responsive_website/common_function/style/section_header.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class IndustrySection extends StatelessWidget {
  const IndustrySection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final industries = IndustryModel.getAllIndustries();

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Header
          const SectionHeader(
            subtitle: 'Industries I Serve',
            title: 'Diverse Industry Experience',
            description:
                'Delivering tailored solutions across multiple industries with deep domain expertise',
          ),
          SizedBox(height: s.spaceBtwItems),

          // Industry Cards Grid
          _buildIndustryGrid(context, industries, s),
        ],
      ),
    );
  }

  /// Industry Cards Grid Layout
  Widget _buildIndustryGrid(BuildContext context, List<IndustryModel> industries, DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 2, tablet: 3, desktop: 4);
    final spacing = s.spaceBtwItems;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: industries.map((industry) {
            return SizedBox(
              width: cardWidth,
              child: IndustryCard(industry: industry),
            );
          }).toList(),
        );
      },
    );
  }
}
