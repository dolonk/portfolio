import 'package:flutter/material.dart';
import 'widgets/tool_category_card.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/data_layer/model/about/tool_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 900, desktop: 1200),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'TECH STACK',
                title: 'Development Tools',
                subtitle: 'Software I use to build amazing applications',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Tool Categories
              _buildToolCategories(context, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Tool Categories Grid
  Widget _buildToolCategories(BuildContext context, DSizes s) {
    final categories = ToolCategoryModel.getAllCategories();

    // Desktop/Tablet: Two columns
    if (context.isDesktop || context.isTablet) {
      return Column(
        children: [
          // Row 1: Categories 0, 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: ToolCategoryCard(category: categories[0])),
              SizedBox(width: s.spaceBtwItems),
              Expanded(child: ToolCategoryCard(category: categories[1])),
            ],
          ),
          SizedBox(height: s.spaceBtwItems),

          // Row 2: Categories 2, 3
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: ToolCategoryCard(category: categories[2])),
              SizedBox(width: s.spaceBtwItems),
              Expanded(child: ToolCategoryCard(category: categories[3])),
            ],
          ),
          SizedBox(height: s.spaceBtwItems),
        ],
      );
    } else {
      // Mobile: Single column
      return Column(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: s.spaceBtwItems),
            child: ToolCategoryCard(category: categories[index]),
          ),
        ),
      );
    }
  }
}
