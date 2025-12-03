import 'package:flutter/material.dart';
import 'widgets/process_step_card.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_widget.dart';
import '../../../../../utility/responsive/section_container.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';
import '../../../../../data_layer/model/services/process_step_model.dart';

class ProcessTimelineSection extends StatelessWidget {
  const ProcessTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Header
          DSectionHeader(
            label: 'How I Work',
            title: 'My Development Process',
            subtitle: 'A structured approach to deliver exceptional results, from discovery to deployment',
            alignment: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Process Steps
          ResponsiveWidget(
            mobile: _buildMobileLayout(context),
            tablet: _buildTabletLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  // 📱 Mobile Layout - Vertical Timeline
  Widget _buildMobileLayout(BuildContext context) {
    final steps = ProcessStepModel.getProcessSteps();

    return Column(
      children: List.generate(
        steps.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index == steps.length - 1 ? 0 : 16.0),
          child: ProcessStepCard(step: steps[index], isLast: index == steps.length - 1),
        ),
      ),
    );
  }

  // 📱 Tablet Layout - 2 Column Grid
  Widget _buildTabletLayout(BuildContext context) {
    final steps = ProcessStepModel.getProcessSteps();
    final s = context.sizes;
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - s.spaceBtwItems) / 2;
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

  // 💻 Desktop Layout - Horizontal Timeline
  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;
    final steps = ProcessStepModel.getProcessSteps();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: ProcessStepCard(step: steps[index], isLast: index == steps.length - 1),
              ),
              // Horizontal Connector Arrow
              if (index < steps.length - 1)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.paddingSm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 32,
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
}
