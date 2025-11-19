import 'widgets/industry_card.dart';
import 'package:flutter/material.dart';
import '../../../../common_function/widgets/section_header.dart';
import '../../../../common_function/widgets/responsive_grid.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/services/industry_model.dart';

class IndustrySection extends StatelessWidget {
  const IndustrySection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final industries = IndustryModel.getAllIndustries();

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        children: [
          // Section header
          DSectionHeader(
            label: 'INDUSTRIES I SERVE',
            title: 'Diverse Industry Experience',
            subtitle: 'Delivering tailored solutions across multiple industries with deep domain expertise',
            alignment: TextAlign.center,
            maxWidth: 800,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Industry Cards Grid
          DResponsiveGrid(
            mobileColumns: 2,
            tabletColumns: 3,
            desktopColumns: 4,
            animate: true,
            children: industries.map((industry) => IndustryCard(industry: industry)).toList(),
          ),
        ],
      ),
    );
  }
}
