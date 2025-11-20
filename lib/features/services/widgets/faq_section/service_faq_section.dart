import '../../../../common_function/widgets/reusable_faq_item.dart';
import 'package:flutter/material.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:responsive_website/data_layer/model/services/faq_model.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class ServicesFaqSection extends StatefulWidget {
  const ServicesFaqSection({super.key});

  @override
  State<ServicesFaqSection> createState() => _ServicesFaqSectionState();
}

class _ServicesFaqSectionState extends State<ServicesFaqSection> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final faqs = FaqModel.getServicesFaqs();

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Header
          DSectionHeader(
            label: 'FAQ',
            title: 'Frequently Asked Questions',
            subtitle: 'Find answers to common questions about my services, process, and pricing',
            alignment: TextAlign.center,
            maxWidth: 800,
          ),
          SizedBox(height: s.spaceBtwItems),

          // FAQ Items Container
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 900),
              ),
              child: Column(
                children: List.generate(faqs.length, (index) {
                  return ReusableFaqItem(
                    faq: faqs[index],
                    isExpanded: _expandedIndex == index,
                    onTap: () {
                      setState(() {
                        _expandedIndex = _expandedIndex == index ? null : index;
                      });
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
