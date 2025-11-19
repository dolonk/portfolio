import 'widgets/tech_icon_card.dart';
import 'package:flutter/material.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';
import '../../../../utility/responsive/responsive_helper.dart';
import '../../../../utility/responsive/section_container.dart';
import '../../../../common_function/widgets/section_header.dart';
import '../../../../data_layer/model/home/tech_stack_model.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

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
    final techStacks = _getTechStackData();

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

  List<TechStackModel> _getTechStackData() {
    return [
      // Core Technologies
      TechStackModel(name: 'Flutter', iconPath: 'assets/tech_icons/flutter.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Dart', iconPath: 'assets/tech_icons/dart.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Firebase', iconPath: 'assets/tech_icons/firebase.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Kotlin', iconPath: 'assets/tech_icons/kotlin.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Java', iconPath: 'assets/tech_icons/java.svg', category: 'Core Technologies'),
      TechStackModel(name: 'Swift', iconPath: 'assets/tech_icons/swift.svg', category: 'Core Technologies'),

      // Platforms
      TechStackModel(name: 'iOS', iconPath: 'assets/tech_icons/ios.svg', category: 'Platforms'),
      TechStackModel(name: 'Android', iconPath: 'assets/tech_icons/android.svg', category: 'Platforms'),
      TechStackModel(name: 'Web', iconPath: 'assets/tech_icons/web.svg', category: 'Platforms'),
      TechStackModel(name: 'Windows', iconPath: 'assets/tech_icons/windows.svg', category: 'Platforms'),
      TechStackModel(name: 'macOS', iconPath: 'assets/tech_icons/macos.svg', category: 'Platforms'),

      // State Management
      TechStackModel(name: 'Provider', iconPath: 'assets/tech_icons/provider.svg', category: 'State Management'),
      TechStackModel(name: 'BLoC', iconPath: 'assets/tech_icons/bloc.svg', category: 'State Management'),
      TechStackModel(name: 'Riverpod', iconPath: 'assets/tech_icons/riverpod.svg', category: 'State Management'),
      TechStackModel(name: 'GetX', iconPath: 'assets/tech_icons/getx.svg', category: 'State Management'),

      // Tools & Platforms
      TechStackModel(name: 'Git', iconPath: 'assets/tech_icons/git.svg', category: 'Tools & Platforms'),
      TechStackModel(name: 'GitHub', iconPath: 'assets/tech_icons/github.svg', category: 'Tools & Platforms'),
      TechStackModel(name: 'VS Code', iconPath: 'assets/tech_icons/vscode.svg', category: 'Tools & Platforms'),
      TechStackModel(name: 'Figma', iconPath: 'assets/tech_icons/figma.svg', category: 'Tools & Platforms'),
    ];
  }
}
