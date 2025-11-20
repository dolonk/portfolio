import 'widgets/value_item.dart';
import 'package:flutter/material.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:responsive_website/data_layer/model/about/value_model.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class ValuesSection extends StatelessWidget {
  const ValuesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 900, desktop: 1200),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'CORE VALUES',
                title: 'What I Bring to the Table',
                subtitle: 'Values and strengths that set me apart',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Values List
              _buildValuesList(),
            ],
          ),
        ),
      ),
    );
  }

  /// Values List
  Widget _buildValuesList() {
    final values = ValueModel.getAllValues();

    return Column(
      children: List.generate(values.length, (index) => ValueItem(value: values[index], delay: 200 + (index * 100))),
    );
  }
}
