import 'package:flutter/material.dart';
import 'widgets/process_step_card.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/common_function/style/section_header.dart';
import 'package:responsive_website/data_layer/model/services/process_step_model.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final steps = ProcessStepModel.getAllSteps();

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.only(left: s.paddingMd, bottom: s.spaceBtwSections, right: s.paddingMd),
      child: Column(
        children: [
          // Section Header
          const SectionHeader(
            subtitle: 'How I Work',
            title: 'My Development Process',
            description:
                'A structured, transparent approach to deliver exceptional results from discovery to deployment',
          ),
          SizedBox(height: s.spaceBtwItems),

          // Process Steps Layout
          if (context.isDesktop)
            _buildDesktopLayout(context, steps, s)
          else if (context.isTablet)
            _buildTabletLayout(context, steps, s)
          else
            _buildMobileLayout(context, steps, s),
        ],
      ),
    );
  }

  /// 💻 Desktop Layout - Horizontal with connectors
  Widget _buildDesktopLayout(BuildContext context, List<ProcessStepModel> steps, DSizes s) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        final isLast = index == steps.length - 1;

        return Expanded(
          child: Row(
            children: [
              // Process Step Card
              Expanded(child: ProcessStepCard(step: steps[index])),

              // Connector Arrow (not for last step)
              if (!isLast)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.paddingSm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 80),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 28,
                        color: DColors.primaryButton.withAlpha((255 * 0.6).round()),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  /// 📱 Tablet Layout - 2 columns grid
  Widget _buildTabletLayout(BuildContext context, List<ProcessStepModel> steps, DSizes s) {
    return Wrap(
      spacing: s.spaceBtwItems,
      runSpacing: s.spaceBtwItems,
      children: steps.map((step) {
        return SizedBox(
          width: (context.screenWidth - s.paddingMd * 2 - s.spaceBtwItems) / 2,
          child: ProcessStepCard(step: step),
        );
      }).toList(),
    );
  }

  /// 📱 Mobile Layout - Vertical stack
  Widget _buildMobileLayout(BuildContext context, List<ProcessStepModel> steps, DSizes s) {
    return Column(
      children: steps.map((step) {
        return Padding(
          padding: EdgeInsets.only(bottom: s.spaceBtwItems),
          child: ProcessStepCard(step: step),
        );
      }).toList(),
    );
  }
}
