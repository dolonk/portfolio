import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';

class SolutionStepsSection extends StatefulWidget {
  final Map<String, dynamic> solutionSteps;
  final ValueChanged<Map<String, dynamic>> onChanged;

  const SolutionStepsSection({
    super.key,
    required this.solutionSteps,
    required this.onChanged,
  });

  @override
  State<SolutionStepsSection> createState() => _SolutionStepsSectionState();
}

class _SolutionStepsSectionState extends State<SolutionStepsSection> {
  // Step labels
  static const List<Map<String, String>> stepLabels = [
    {'key': 'step1', 'title': 'Research & Planning', 'icon': '🔍'},
    {'key': 'step2', 'title': 'Architecture Design', 'icon': '🏗️'},
    {'key': 'step3', 'title': 'State Management', 'icon': '⚙️'},
    {'key': 'step4', 'title': 'Technology Selection', 'icon': '🚀'},
  ];

  // Controllers for each step
  final Map<String, TextEditingController> _descriptionControllers = {};
  final Map<String, TextEditingController> _highlightInputControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (final step in stepLabels) {
      final key = step['key']!;
      final stepData = widget.solutionSteps[key] as Map<String, dynamic>? ?? {};

      _descriptionControllers[key] = TextEditingController(
        text: stepData['description'] as String? ?? '',
      );
      _highlightInputControllers[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final controller in _descriptionControllers.values) {
      controller.dispose();
    }
    for (final controller in _highlightInputControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

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

          // Step Editors
          ...stepLabels.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            return Column(
              children: [
                _buildStepEditor(context, s, step, index),
                if (index < stepLabels.length - 1) ...[
                  SizedBox(height: s.paddingMd),
                  _buildConnector(s),
                  SizedBox(height: s.paddingMd),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timeline_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Solution Timeline',
          style: context.fonts.titleLarge.rajdhani(
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(DSizes s) {
    return Row(
      children: [
        SizedBox(width: 20),
        Container(
          width: 2,
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [DColors.primaryButton, DColors.primaryButton.withAlpha(100)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepEditor(BuildContext context, DSizes s, Map<String, String> step, int index) {
    final key = step['key']!;
    final stepData = widget.solutionSteps[key] as Map<String, dynamic>? ?? {};
    final highlights = (stepData['highlights'] as List<dynamic>?)?.cast<String>() ?? [];

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.background,
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [DColors.primaryButton, DColors.primaryButton.withAlpha(180)],
                  ),
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: context.fonts.titleMedium.rajdhani(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: s.paddingSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${step['icon']} ${step['title']}',
                      style: context.fonts.bodyLarge.rubik(
                        fontWeight: FontWeight.w600,
                        color: DColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Description
          TextField(
            controller: _descriptionControllers[key],
            maxLines: 3,
            onChanged: (value) => _updateStep(key, 'description', value),
            decoration: InputDecoration(
              hintText: 'Describe what was done in this step...',
              hintStyle: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
              filled: true,
              fillColor: DColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
                borderSide: BorderSide(color: DColors.cardBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
                borderSide: BorderSide(color: DColors.cardBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
                borderSide: BorderSide(color: DColors.primaryButton, width: 2),
              ),
            ),
          ),
          SizedBox(height: s.paddingMd),

          // Highlights Label
          Text(
            'Highlights',
            style: context.fonts.bodySmall.rubik(
              fontWeight: FontWeight.w600,
              color: DColors.textSecondary,
            ),
          ),
          SizedBox(height: s.paddingSm),

          // Add Highlight Input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _highlightInputControllers[key],
                  decoration: InputDecoration(
                    hintText: 'Add a highlight...',
                    hintStyle: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
                    filled: true,
                    fillColor: DColors.cardBackground,
                    contentPadding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(s.borderRadiusSm),
                      borderSide: BorderSide(color: DColors.cardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(s.borderRadiusSm),
                      borderSide: BorderSide(color: DColors.cardBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(s.borderRadiusSm),
                      borderSide: BorderSide(color: DColors.primaryButton, width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(width: s.paddingSm),
              IconButton(
                onPressed: () => _addHighlight(key),
                icon: Icon(Icons.add_circle_rounded, color: DColors.primaryButton),
              ),
            ],
          ),
          SizedBox(height: s.paddingSm),

          // Highlights List
          if (highlights.isNotEmpty)
            Wrap(
              spacing: s.paddingSm,
              runSpacing: s.paddingSm,
              children: highlights.asMap().entries.map((entry) {
                return Chip(
                  label: Text(
                    entry.value,
                    style: context.fonts.bodySmall.rubik(color: DColors.textPrimary),
                  ),
                  deleteIcon: Icon(Icons.close, size: 16),
                  onDeleted: () => _removeHighlight(key, entry.key),
                  backgroundColor: DColors.cardBackground,
                  side: BorderSide(color: DColors.cardBorder),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  void _updateStep(String stepKey, String field, dynamic value) {
    final updated = Map<String, dynamic>.from(widget.solutionSteps);
    final stepData = Map<String, dynamic>.from(updated[stepKey] as Map<String, dynamic>? ?? {});
    stepData[field] = value;
    updated[stepKey] = stepData;
    widget.onChanged(updated);
  }

  void _addHighlight(String stepKey) {
    final text = _highlightInputControllers[stepKey]!.text.trim();
    if (text.isEmpty) return;

    final stepData = widget.solutionSteps[stepKey] as Map<String, dynamic>? ?? {};
    final highlights = List<String>.from((stepData['highlights'] as List<dynamic>?)?.cast<String>() ?? []);
    highlights.add(text);

    _updateStep(stepKey, 'highlights', highlights);
    _highlightInputControllers[stepKey]!.clear();
  }

  void _removeHighlight(String stepKey, int index) {
    final stepData = widget.solutionSteps[stepKey] as Map<String, dynamic>? ?? {};
    final highlights = List<String>.from((stepData['highlights'] as List<dynamic>?)?.cast<String>() ?? []);
    highlights.removeAt(index);
    _updateStep(stepKey, 'highlights', highlights);
  }
}
