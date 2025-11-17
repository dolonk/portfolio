import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/about/skill_model.dart';
import 'language_chip.dart';
import 'skill_progress_bar.dart';

/*class SkillCategory extends StatelessWidget {
  final SkillCategoryModel category;
  final int baseDelay;

  const SkillCategory({super.key, required this.category, this.baseDelay = 0});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
          padding: EdgeInsets.all(
            context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
          ),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: category.accentColor.withAlpha((255 * 0.3).round()), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              Row(
                children: [
                  // Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: category.accentColor.withAlpha((255 * 0.15).round()),
                      borderRadius: BorderRadius.circular(s.borderRadiusSm),
                    ),
                    child: Icon(category.icon, color: category.accentColor, size: 22),
                  ),
                  SizedBox(width: s.paddingMd),

                  // Category Name
                  Expanded(
                    child: Text(
                      category.categoryName,
                      style: fonts.headlineSmall.rajdhani(
                        fontSize: context.responsiveValue(mobile: 18.0, tablet: 20.0, desktop: 22.0),
                        fontWeight: FontWeight.bold,
                        color: DColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: s.spaceBtwItems),

              // Divider
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [category.accentColor, category.accentColor.withAlpha(0)]),
                ),
              ),
              SizedBox(height: s.spaceBtwItems),

              // Skills List
              ...List.generate(
                category.skills.length,
                (index) => SkillProgressBar(
                  skill: category.skills[index],
                  accentColor: category.accentColor,
                  delay: baseDelay + (index * 100),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: baseDelay.ms)
        .slideY(begin: 0.1, duration: 600.ms, delay: baseDelay.ms);
  }
}*/

class SkillCategory extends StatelessWidget {
  final SkillCategoryModel category;
  final int baseDelay;

  const SkillCategory({super.key, required this.category, this.baseDelay = 0});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
          padding: EdgeInsets.all(
            context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
          ),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: category.accentColor.withAlpha((255 * 0.3).round()), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              Row(
                children: [
                  // Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: category.accentColor.withAlpha((255 * 0.15).round()),
                      borderRadius: BorderRadius.circular(s.borderRadiusSm),
                    ),
                    child: Icon(category.icon, color: category.accentColor, size: 22),
                  ),
                  SizedBox(width: s.paddingMd),

                  // Category Name
                  Expanded(
                    child: Text(
                      category.categoryName,
                      style: fonts.headlineSmall.rajdhani(
                        fontSize: context.responsiveValue(mobile: 18.0, tablet: 20.0, desktop: 22.0),
                        fontWeight: FontWeight.bold,
                        color: DColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: s.spaceBtwItems),

              // Divider
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [category.accentColor, category.accentColor.withAlpha(0)]),
                ),
              ),
              SizedBox(height: s.spaceBtwItems),

              // --- MODIFIED SECTION ---
              // Skills List (Conditional Display)
              if (category.categoryName == 'Programming Languages')
                _buildLanguageChips(context)
              else
                _buildProgressBars(),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: baseDelay.ms)
        .slideY(begin: 0.1, duration: 600.ms, delay: baseDelay.ms);
  }

  /// Builds the Wrap layout with chips for the 'Programming Languages' category
  Widget _buildLanguageChips(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: List.generate(category.skills.length, (index) {
        final skill = category.skills[index];
        final animationDelay = baseDelay + (index * 75);
        return LanguageChip(skill: skill, accentColor: category.accentColor)
            .animate()
            .fadeIn(delay: animationDelay.ms, duration: 500.ms)
            .slideX(begin: 0.2, delay: animationDelay.ms, duration: 500.ms);
      }),
    );
  }

  /// Builds the list of progress bars for all other standard categories
  Widget _buildProgressBars() {
    return Column(
      children: List.generate(
        category.skills.length,
        (index) => SkillProgressBar(
          skill: category.skills[index],
          accentColor: category.accentColor,
          delay: baseDelay + (index * 100),
        ),
      ),
    );
  }
}
