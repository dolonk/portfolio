import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../../common_function/widgets/custom_text_field.dart';

class ProjectDetailsSection extends StatelessWidget {
  final TextEditingController clientNameController;
  final TextEditingController launchDateController;
  final TextEditingController challengeController;
  final TextEditingController requirementsController;
  final TextEditingController constraintsController;
  final TextEditingController solutionController;

  const ProjectDetailsSection({
    super.key,
    required this.clientNameController,
    required this.launchDateController,
    required this.challengeController,
    required this.requirementsController,
    required this.constraintsController,
    required this.solutionController,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(context),
          SizedBox(height: s.paddingLg),

          // Client Name
          CustomTextField(
            controller: clientNameController,
            label: 'Client Name',
            hint: 'Enter client or company name',
          ),
          SizedBox(height: s.paddingMd),

          // Launch Date
          CustomTextField(controller: launchDateController, label: 'Launch Date', hint: 'e.g., January 2024'),
          SizedBox(height: s.paddingMd),

          // Challenge
          CustomTextField(
            controller: challengeController,
            label: 'The Challenge',
            hint: 'What problem did this project solve?',
            maxLines: 5,
          ),
          SizedBox(height: s.paddingMd),

          // Requirements
          CustomTextField(
            controller: requirementsController,
            label: 'Requirements',
            hint: 'What were the project requirements?',
            maxLines: 5,
          ),
          SizedBox(height: s.paddingMd),

          // Constraints
          CustomTextField(
            controller: constraintsController,
            label: 'Constraints',
            hint: 'What constraints or limitations existed?',
            maxLines: 5,
          ),
          SizedBox(height: s.paddingMd),

          // Solution
          CustomTextField(
            controller: solutionController,
            label: 'The Solution',
            hint: 'How did you solve the problem?',
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.description_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Project Details',
          style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ],
    );
  }
}
