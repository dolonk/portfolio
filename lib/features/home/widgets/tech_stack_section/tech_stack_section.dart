import 'widgets/tech_icon_card.dart';
import 'package:flutter/material.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../data_layer/model/home/tech_stack_model.dart';
import '../../../../utility/default_sizes/default_sizes.dart';
import '../../../../utility/responsive/responsive_helper.dart';
import '../../../../utility/responsive/responsive_widget.dart';
import '../../../../utility/responsive/section_container.dart';
import '../../../../common_function/style/section_header.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, top: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(context),

          // Tech Stack Grid
          ResponsiveWidget(
            mobile: _buildMobileLayout(context),
            tablet: _buildTabletLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  // 📱 Mobile Layout - 3 columns
  Widget _buildMobileLayout(BuildContext context) {
    final techStacks = _getTechStackData();
    return Column(children: _buildCategoryGroups(context, techStacks, crossAxisCount: 3));
  }

  // 📱 Tablet Layout - 4 columns
  Widget _buildTabletLayout(BuildContext context) {
    final techStacks = _getTechStackData();
    return Column(children: _buildCategoryGroups(context, techStacks, crossAxisCount: 4));
  }

  // 💻 Desktop Layout - 6 columns
  Widget _buildDesktopLayout(BuildContext context) {
    final techStacks = _getTechStackData();

    return Column(children: _buildCategoryGroups(context, techStacks, crossAxisCount: 6));
  }

  // 📝 Section Header
  Widget _buildSectionHeader(BuildContext context) {
    return SectionHeader(
      subtitle: 'Technologies I Master',
      title: 'Tech Stack & Tools',
      description: 'Building cross-platform applications with modern frameworks and industry-leading tools',
    );
  }

  // 📋 Build Category Groups
  List<Widget> _buildCategoryGroups(
    BuildContext context,
    List<TechStackModel> techStacks, {
    required int crossAxisCount,
  }) {
    final s = context.sizes;
    final fonts = context.fonts;

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
            left: s.spaceBtwItems,
            right: s.spaceBtwItems,
            bottom: s.spaceBtwItems,
            top: s.spaceBtwSections,
          ),
          child: Text(
            category,
            style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );

      // ✅ Tech Wrap for this category (OPTIMIZED)
      widgets.add(
        LayoutBuilder(
          builder: (context, constraints) {
            // Calculate card width based on crossAxisCount
            final spacing = s.spaceBtwItems;
            final totalSpacing = spacing * (crossAxisCount - 1);
            final cardWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: context.isMobile ? 12 : spacing,
              alignment: WrapAlignment.center,
              children: techs.map((tech) {
                return SizedBox(
                  width: cardWidth,
                  height: cardWidth, // Square cards
                  child: TechIconCard(tech: tech, index: globalIndex++),
                );
              }).toList(),
            );
          },
        ),
      );
    });

    return widgets;
  }

  // 📊 Tech Stack Data
  List<TechStackModel> _getTechStackData() {
    return [
      // Languages
      TechStackModel(
        name: 'Flutter',
        iconPath: 'assets/tech_icons/flutter.svg',
        category: 'Core Technologies',
      ),
      TechStackModel(name: 'Dart', iconPath: 'assets/tech_icons/dart.svg', category: 'Core Technologies'),
      TechStackModel(
        name: 'Firebase',
        iconPath: 'assets/tech_icons/firebase.svg',
        category: 'Core Technologies',
      ),
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
      TechStackModel(
        name: 'Provider',
        iconPath: 'assets/tech_icons/provider.svg',
        category: 'State Management',
      ),
      TechStackModel(name: 'BLoC', iconPath: 'assets/tech_icons/bloc.svg', category: 'State Management'),
      TechStackModel(
        name: 'Riverpod',
        iconPath: 'assets/tech_icons/riverpod.svg',
        category: 'State Management',
      ),
      TechStackModel(name: 'GetX', iconPath: 'assets/tech_icons/getx.svg', category: 'State Management'),

      // Tools & Platforms
      TechStackModel(name: 'Git', iconPath: 'assets/tech_icons/git.svg', category: 'Tools & Platforms'),
      TechStackModel(name: 'GitHub', iconPath: 'assets/tech_icons/github.svg', category: 'Tools & Platforms'),
      TechStackModel(
        name: 'VS Code',
        iconPath: 'assets/tech_icons/vscode.svg',
        category: 'Tools & Platforms',
      ),
      TechStackModel(name: 'Figma', iconPath: 'assets/tech_icons/figma.svg', category: 'Tools & Platforms'),
    ];
  }
}
