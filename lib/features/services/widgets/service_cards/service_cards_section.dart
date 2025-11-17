import 'package:flutter/material.dart';
import 'widgets/service_card_detailed.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/common_function/style/section_header.dart';
import 'package:responsive_website/data_layer/model/services/service_detail_model.dart';

class ServiceCardsSection extends StatelessWidget {
  const ServiceCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final services = ServiceDetailModel.getAllServices();

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd,  vertical: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Header
          const SectionHeader(
            subtitle: 'Our Services',
            title: 'Comprehensive Development Solutions',
            description:
                'From concept to deployment, I provide end-to-end development services tailored to your business needs.',
          ),
          SizedBox(height: s.spaceBtwItems),

          // Service Cards Grid
          _buildServiceCardsGrid(context, services, s),
        ],
      ),
    );
  }

  /// Service Cards Grid Layout
  Widget _buildServiceCardsGrid(BuildContext context, List<ServiceDetailModel> services, DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 3);
    final spacing = s.spaceBtwItems;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: services.map((service) {
            return SizedBox(
              width: context.isMobile ? double.infinity : cardWidth,
              child: ServiceCardDetailed(service: service),
            );
          }).toList(),
        );
      },
    );
  }
}
