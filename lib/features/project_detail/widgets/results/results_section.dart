import 'widgets/metric_card.dart';
import 'widgets/testimonial_box.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class ResultsSection extends StatelessWidget {
  final ProjectModel project;

  const ResultsSection({super.key, required this.project});

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

          // Metrics Cards
          _buildMetricsGrid(context, s),
          SizedBox(height: s.spaceBtwSections),

          // Testimonial Box
          _buildTestimonial(context),
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
        Text('Results & Impact', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text('Measurable outcomes and client feedback', style: fonts.bodyLarge.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  /// Metrics Grid with Wrap Layout
  Widget _buildMetricsGrid(BuildContext context, DSizes s) {
    final metrics = _getMetricsData();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = context.responsiveValue(
          mobile: (constraints.maxWidth - s.spaceBtwItems) / 2,
          tablet: (900 - s.spaceBtwItems * 2) / 3,
          desktop: (1100 - s.spaceBtwItems * 3) / 4,
        );
        return Wrap(
          spacing: s.spaceBtwItems,
          runSpacing: s.spaceBtwItems,
          children: metrics.map((metric) {
            return SizedBox(
              width: cardWidth,
              child: MetricCard(
                icon: metric['icon'] as IconData,
                value: metric['value'] as String,
                label: metric['label'] as String,
                iconColor: metric['color'] as Color,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// Testimonial
  Widget _buildTestimonial(BuildContext context) {
    return TestimonialBox(
      testimonial: project.clientTestimonial,
      clientName: project.clientName,
      clientRole: 'CEO',
      clientCompany: project.clientName,
    );
  }

  /// Get Metrics Data
  List<Map<String, dynamic>> _getMetricsData() {
    final results = project.results ?? {};

    return [
      {
        'icon': Icons.download_rounded,
        'value': results['Downloads'] ?? '50,000+',
        'label': 'Downloads',
        'color': const Color(0xFF8B5CF6),
      },
      {
        'icon': Icons.star_rounded,
        'value': results['App Store Rating'] ?? '4.8/5.0',
        'label': 'App Store Rating',
        'color': const Color(0xFFF59E0B),
      },
      {
        'icon': Icons.star_rounded,
        'value': results['Play Store Rating'] ?? '4.7/5.0',
        'label': 'Play Store Rating',
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.access_time_rounded,
        'value': results['Average Session Time'] ?? '8.5 (m)',
        'label': 'Avg Session Time',
        'color': const Color(0xFF3B82F6),
      },
    ];
  }
}
