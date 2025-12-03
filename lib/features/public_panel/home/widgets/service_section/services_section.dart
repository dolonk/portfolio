import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route/route_name.dart';
import '../../../../../common_function/widgets/custom_button.dart';
import '../../../../../common_function/widgets/responsive_grid.dart';
import '../../../../../data_layer/model/home/service_model.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/features/public_panel/home/widgets/service_section/widget/service_card.dart';

class MyServiceSection extends StatelessWidget {
  const MyServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Column(
        children: [
          DSectionHeader(
            label: 'SERVICES',
            title: 'What I Offer',
            subtitle: 'Professional development services tailored to your needs',
            alignment: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // DResponsiveGrid component
          DResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            animate: true,
            children: ServiceModel.getServices().map((service) => ServiceCard(serviceModel: service)).toList(),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Using new CustomButton
          CustomButton(
            width: context.isMobile ? double.infinity : 250,
            iconRight: true,
            tittleText: 'View All Services',
            icon: Icons.arrow_forward_rounded,
            onPressed: () => context.go(RouteNames.services),
          ),
        ],
      ),
    );
  }
}
