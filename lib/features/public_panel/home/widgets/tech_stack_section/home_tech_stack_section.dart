import 'widgets/tech_icon_card.dart';
import 'package:flutter/material.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';
import '../../../../../utility/responsive/section_container.dart';
import '../../../../../data_layer/model/home/tech_stack_model.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';

class HomeTechStackSection extends StatelessWidget {
  const HomeTechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Header
          DSectionHeader(
            label: 'TECHNOLOGIES I MASTER',
            title: 'Tech Stack & Tools',
            subtitle: 'Building cross-platform applications with modern frameworks and industry-leading tools',
            alignment: TextAlign.center,
            maxWidth: 800,
          ),

          // Tech Stack by Categories
          _buildCategoryGroups(context),
        ],
      ),
    );
  }

  Widget _buildCategoryGroups(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final techStacks = TechStackModel.getTechStackData();

    // Group by category
    final categories = <String, List<TechStackModel>>{};
    for (var tech in techStacks) {
      if (!categories.containsKey(tech.category)) {
        categories[tech.category] = [];
      }
      categories[tech.category]!.add(tech);
    }

    final widgets = <Widget>[];
    int globalIndex = 0;

    categories.forEach((category, techs) {
      // Category Title
      widgets.add(
        Padding(
          padding: EdgeInsets.only(
            left: s.paddingMd,
            right: s.paddingMd,
            bottom: s.spaceBtwItems,
            top: s.spaceBtwItems,
          ),
          child: Text(
            category,
            style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );

      // Tech Icons Grid
      widgets.add(
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = context.responsiveValue(mobile: 3, tablet: 4, desktop: 6);

            final spacing = s.spaceBtwItems;
            final totalSpacing = spacing * (crossAxisCount - 1);
            final cardWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: context.isMobile ? s.spaceBtwItems * 1.5 : spacing,
              alignment: WrapAlignment.center,
              children: techs.map((tech) {
                return SizedBox(
                  width: cardWidth,
                  height: cardWidth,
                  child: TechIconCard(tech: tech, index: globalIndex++),
                );
              }).toList(),
            );
          },
        ),
      );
    });

    return Column(children: widgets);
  }
}
