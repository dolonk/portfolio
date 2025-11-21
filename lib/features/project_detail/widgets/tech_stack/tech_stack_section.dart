import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_website/data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/features/project_detail/widgets/tech_stack/widgets/tech_stack.dart';

class TechStackSection extends StatelessWidget {
  final ProjectModel project;

  const TechStackSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          _buildSectionHeading(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Tech Stack Cards in Wrap Layout
          _buildTechStackGrid(context, s),
        ],
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tech Stack Used', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text(
          'Technologies and tools powering this project',
          style: fonts.bodyLarge.rubik(color: DColors.textSecondary),
        ),
      ],
    );
  }

  /// Tech Stack Grid with Wrap Layout
  Widget _buildTechStackGrid(BuildContext context, DSizes s) {
    final techStackItems = _getTechStackItems();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = context.responsiveValue(
          mobile: (constraints.maxWidth - s.spaceBtwItems) / 2,
          tablet: (1000 - s.spaceBtwItems * 3) / 4,
          desktop: (1100 - s.spaceBtwItems * 4) / 5,
        );

        return Wrap(
          spacing: s.spaceBtwItems,
          runSpacing: s.spaceBtwItems,
          children: techStackItems.map((tech) {
            return SizedBox(
              width: cardWidth,
              child: TechCard(
                icon: tech['icon'] as IconData,
                name: tech['name'] as String,
                category: tech['category'] as String,
                iconColor: tech['color'] as Color,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// Get Tech Stack Items with FontAwesome Icons and Categories
  List<Map<String, dynamic>> _getTechStackItems() {
    return [
      {'icon': FontAwesomeIcons.code, 'name': 'Flutter', 'category': 'Framework', 'color': const Color(0xFF02569B)},
      {'icon': FontAwesomeIcons.code, 'name': 'Dart', 'category': 'Language', 'color': const Color(0xFF0175C2)},
      {'icon': FontAwesomeIcons.fire, 'name': 'Firebase', 'category': 'Backend', 'color': const Color(0xFFFFCA28)},
      {
        'icon': FontAwesomeIcons.layerGroup,
        'name': 'BLoC',
        'category': 'State Management',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'icon': FontAwesomeIcons.stripe,
        'name': 'Stripe',
        'category': 'Payment Gateway',
        'color': const Color(0xFF635BFF),
      },
      {'icon': FontAwesomeIcons.cloud, 'name': 'REST API', 'category': 'Integration', 'color': const Color(0xFF3B82F6)},
      {
        'icon': FontAwesomeIcons.boxesStacked,
        'name': 'Get It',
        'category': 'Dependency Injection',
        'color': const Color(0xFF10B981),
      },
      {'icon': FontAwesomeIcons.gitAlt, 'name': 'Git', 'category': 'Version Control', 'color': const Color(0xFFF05032)},
      {'icon': FontAwesomeIcons.figma, 'name': 'Figma', 'category': 'Design Tool', 'color': const Color(0xFFF24E1E)},
    ];
  }
}
