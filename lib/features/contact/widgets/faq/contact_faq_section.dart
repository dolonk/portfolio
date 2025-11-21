import 'package:flutter/material.dart';
import '../../../../common_function/widgets/section_header.dart';
import '../../../../common_function/widgets/reusable_faq_item.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/services/faq_model.dart';

class ContactFaqSection extends StatefulWidget {
  const ContactFaqSection({super.key});

  @override
  State<ContactFaqSection> createState() => _ContactFaqSectionState();
}

class _ContactFaqSectionState extends State<ContactFaqSection> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final faqs = FaqModel.getContactFaqs();

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 900),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'FAQ',
                title: 'Frequently Asked Questions',
                subtitle: 'Everything you need to know before starting your project',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwSections),

              // FAQ Items List
              Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
