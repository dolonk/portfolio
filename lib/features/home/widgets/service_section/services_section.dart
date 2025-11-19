import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_website/route/route_name.dart';
import '../../../../data_layer/model/home/service_model.dart';
import '../../../../common_function/style/custom_button.dart';
import '../../../../common_function/widgets/section_header.dart';
import '../../../../common_function/widgets/responsive_grid.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/features/home/widgets/service_section/widget/service_card.dart';

class MyServiceSection extends StatelessWidget {
  const MyServiceSection({super.key});

  // Service Data (6 services as per PDF)
  List<ServiceModel> _getServices() {
    return [
      ServiceModel(
        iconPath: "assets/home/icon/android_icon.svg",
        title: "Mobile App Development",
        subTitle: "iOS & Android",
        description:
            "Custom mobile applications for iOS and Android, delivering high performance and exceptional user experience.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Web Application Development",
        subTitle: "Responsive & Modern",
        description:
            "Responsive web applications with modern frameworks, SEO optimization, and cross-browser compatibility.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Desktop Development",
        subTitle: "Windows, macOS, Linux",
        description:
            "Cross-platform desktop applications for Windows, macOS, and Linux with native platform integration.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "UI/UX Design Services",
        subTitle: "User-Centered Design",
        description:
            "Beautiful and intuitive designs with wireframing, prototyping, and high-fidelity mockups for amazing user experience.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Consulting & Code Review",
        subTitle: "Expert Guidance",
        description:
            "Architecture review, performance optimization, code refactoring guidance, and best practices implementation.",
      ),
      ServiceModel(
        iconPath: "assets/home/icon/web_icon.svg",
        title: "Maintenance & Support",
        subTitle: "24/7 Available",
        description:
            "Ongoing maintenance, bug fixes, feature updates, OS compatibility updates, and 24/7 support options.",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, top: s.spaceBtwSections),
      child: Column(
        children: [
          DSectionHeader(
            label: 'SERVICES',
            title: 'What I Offer',
            subtitle: 'Professional development services tailored to your needs',
            alignment: TextAlign.center,
            maxWidth: 700,
          ),
          SizedBox(height: s.spaceBtwItems),

          // DResponsiveGrid component
          DResponsiveGrid(
            mobileColumns: 1,
            tabletColumns: 2,
            desktopColumns: 3,
            animate: true,
            children: _getServices().map((service) => ServiceCard(serviceModel: service)).toList(),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Using new CustomButton
          CustomButton(
            width: context.isMobile ? double.infinity : 250,
            tittleText: 'View All Services',
            icon: Icons.arrow_forward_rounded,
            onPressed: () => context.go(RouteNames.services),
          ),
        ],
      ),
    );
  }
}
