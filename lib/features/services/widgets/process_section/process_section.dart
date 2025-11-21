import 'package:flutter/material.dart';
import 'widgets/process_step_card.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/services/process_step_model.dart';

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
          DSectionHeader(
            label: 'HOW I WORK',
            title: 'My Development Process',
            subtitle: 'A structured, transparent approach to deliver exceptional results from discovery to deployment',
            alignment: TextAlign.center,
            maxWidth: 800,
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =  (constraints.maxWidth - s.spaceBtwItems) / 2;
        return Wrap(
          spacing: s.spaceBtwItems,
          runSpacing: s.spaceBtwItems,
          children: steps.map((step) {
            return SizedBox(
              width: cardWidth,
              child: ProcessStepCard(step: step),
            );
          }).toList(),
        );
      },
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
