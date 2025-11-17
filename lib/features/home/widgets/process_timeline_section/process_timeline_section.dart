import 'package:flutter/material.dart';
import 'widgets/process_step_card.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../data_layer/model/services/process_step_model.dart';
import '../../../../utility/default_sizes/default_sizes.dart';
import '../../../../utility/responsive/responsive_helper.dart';
import '../../../../utility/responsive/responsive_widget.dart';
import '../../../../utility/responsive/section_container.dart';
import 'package:responsive_website/common_function/style/section_header.dart';

class ProcessTimelineSection extends StatelessWidget {
  const ProcessTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, top: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(context),
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

  // 📝 Section Header
  Widget _buildSectionHeader(BuildContext context) {
    return SectionHeader(
      subtitle: 'How I Work',
      title: 'My Development Process',
      description: 'A structured approach to deliver exceptional results, from discovery to deployment',
    );
  }

  // 📱 Mobile Layout - Vertical Timeline
  Widget _buildMobileLayout(BuildContext context) {
    final steps = _getProcessSteps();

    return Column(
      children: List.generate(
        steps.length,
        (index) => ProcessStepCard(step: steps[index], isLast: index == steps.length - 1),
      ),
    );
  }

  // 📱 Tablet Layout - 2 Column Grid
  Widget _buildTabletLayout(BuildContext context) {
    final s = context.sizes;
    final steps = _getProcessSteps();

    return Wrap(
      spacing: s.spaceBtwSections,
      runSpacing: s.spaceBtwSections,
      alignment: WrapAlignment.center,
      children: List.generate(steps.length, (index) {
        return SizedBox(
          width: (context.screenWidth - s.paddingMd * 2 - s.spaceBtwSections) / 2,
          child: ProcessStepCard(
            step: steps[index],
            isLast: true, // No connectors in grid
          ),
        );
      }),
    );
  }

  // 💻 Desktop Layout - Horizontal Timeline
  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;
    final steps = _getProcessSteps();

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

  // 📊 Process Steps Data
  List<ProcessStepModel> _getProcessSteps() {
    return [
      ProcessStepModel(
        stepNumber: 1,
        title: 'Discovery',
        description:
            'Understanding your requirements, goals, target audience, and project scope through detailed consultation.',
        icon: Icons.search_rounded,
      ),
      ProcessStepModel(
        stepNumber: 2,
        title: 'Design & Planning',
        description:
            'Creating wireframes, UI/UX designs, technical architecture, and detailed project roadmap with milestones.',
        icon: Icons.architecture_rounded,
      ),
      ProcessStepModel(
        stepNumber: 3,
        title: 'Development',
        description:
            'Building robust, scalable applications with clean code, following MVVM architecture and best practices.',
        icon: Icons.code_rounded,
      ),
      ProcessStepModel(
        stepNumber: 4,
        title: 'Testing & QA',
        description:
            'Comprehensive testing including unit tests, widget tests, integration tests, and manual quality assurance.',
        icon: Icons.bug_report_rounded,
      ),
      ProcessStepModel(
        stepNumber: 5,
        title: 'Deployment & Support',
        description:
            'Launching your app to production, app stores deployment, and providing post-launch support and maintenance.',
        icon: Icons.rocket_launch_rounded,
      ),
    ];
  }
}
