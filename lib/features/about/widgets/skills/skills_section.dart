import 'widgets/skill_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/about/skill_model.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final categories = SkillCategoryModel.getAllCategories();
    return SectionContainer(
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

              // Skills Categories Grid for language
              SkillCategory(category: categories[0], baseDelay: 600),
              SizedBox(height: s.spaceBtwItems),

              // Skills Categories Grid
              _buildSkillsGrid(context, s),
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
          'Skills & Expertise',
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
            'Technologies I\'ve mastered over the years',
            style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms);
  }

  /// Skills Categories Grid (Two Columns on Desktop)
  Widget _buildSkillsGrid(BuildContext context, DSizes s) {
    final categories = SkillCategoryModel.getAllCategories();

    if (context.isMobile) {
      return Column(
        children: List.generate(
          categories.length > 1 ? categories.length - 1 : 0,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: s.spaceBtwItems),
            child: SkillCategory(category: categories[index + 1], baseDelay: 200 + (index + 1 * 100)),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          // Categories 0, 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategory(category: categories[1], baseDelay: 200)),
              SizedBox(width: s.spaceBtwItems),
              Expanded(child: SkillCategory(category: categories[2], baseDelay: 300)),
            ],
          ),
          SizedBox(height: s.spaceBtwItems),

          // Categories 2, 3
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategory(category: categories[3], baseDelay: 400)),
              SizedBox(width: s.spaceBtwItems),
              Expanded(child: SkillCategory(category: categories[4], baseDelay: 500)),
            ],
          ),
          SizedBox(height: s.spaceBtwItems),
        ],
      );
    }
  }
}
