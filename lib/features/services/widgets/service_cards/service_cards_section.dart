import 'package:flutter/material.dart';
import 'widgets/service_card_detailed.dart';
import '../../../../common_function/widgets/section_header.dart';
import '../../../../common_function/widgets/responsive_grid.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/services/service_detail_model.dart';

class ServiceCardsSection extends StatelessWidget {
  const ServiceCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final services = ServiceDetailModel.getAllServices();

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Column(
        children: [
          // section header
          DSectionHeader(
            label: 'OUR SERVICES',
            title: 'Comprehensive Development Solutions',
            subtitle:
                'From concept to deployment, I provide end-to-end development services tailored to your business needs.',
            alignment: TextAlign.center,
            maxWidth: 800,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Service Cards Grid
          DResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            animate: true,
            aspectRatio: null,
            children: services.map((service) => ServiceCardDetailed(service: service)).toList(),
          ),
        ],
      ),
    );
  }
}
