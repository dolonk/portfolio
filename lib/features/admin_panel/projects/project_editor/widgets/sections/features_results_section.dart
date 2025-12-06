import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../../common_function/widgets/custom_text_field.dart';

class ResultsSection extends StatefulWidget {
  final List<String> keyFeatures;
  final Map<String, String> results;
  final TextEditingController testimonialController;
  final ValueChanged<List<String>> onFeaturesChanged;
  final ValueChanged<Map<String, String>> onResultsChanged;

  const ResultsSection({
    super.key,
    required this.keyFeatures,
    required this.results,
    required this.testimonialController,
    required this.onFeaturesChanged,
    required this.onResultsChanged,
  });

  @override
  State<ResultsSection> createState() => _ResultsSectionState();
}

class _ResultsSectionState extends State<ResultsSection> {
  final TextEditingController _featureController = TextEditingController();
  final TextEditingController _resultKeyController = TextEditingController();
  final TextEditingController _resultValueController = TextEditingController();

  @override
  void dispose() {
    _featureController.dispose();
    _resultKeyController.dispose();
    _resultValueController.dispose();
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

          // Results
          _buildResultsEditor(context, s),

          Divider(color: DColors.cardBorder),
          SizedBox(height: s.paddingLg),

          // Client Testimonial
          CustomTextField(
            controller: widget.testimonialController,
            label: 'Client Testimonial',
            hint: 'What did the client say about this project?',
            maxLines: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text('Results', style: context.fonts.titleLarge),
      ],
    );
  }

  Widget _buildResultsEditor(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add measurable results (e.g., Users: 10K+, Rating: 4.8/5)',
          style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
        ),
        SizedBox(height: s.paddingMd),

        // Add Result Input
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _resultKeyController,
                decoration: InputDecoration(
                  hintText: 'Metric (e.g., Users)',
                  hintStyle: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                  filled: true,
                  fillColor: DColors.background,
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
            Expanded(
              child: TextField(
                controller: _resultValueController,
                decoration: InputDecoration(
                  hintText: 'Value (e.g., 10K+)',
                  hintStyle: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                  filled: true,
                  fillColor: DColors.background,
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
            ElevatedButton(
              onPressed: _addResult,
              style: ElevatedButton.styleFrom(
                backgroundColor: DColors.primaryButton,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: 14),
              ),
              child: Icon(Icons.add_rounded),
            ),
          ],
        ),
        SizedBox(height: s.paddingMd),

        // Results List
        if (widget.results.isNotEmpty)
          ...widget.results.entries.map((entry) {
            return Container(
              margin: EdgeInsets.only(bottom: s.paddingSm),
              padding: EdgeInsets.all(s.paddingMd),
              decoration: BoxDecoration(
                color: DColors.background,
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
                border: Border.all(color: DColors.cardBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: '${entry.key}: ',
                        style: context.fonts.bodyMedium.rubik(
                          fontWeight: FontWeight.w600,
                          color: DColors.primaryButton,
                        ),
                        children: [
                          TextSpan(
                            text: entry.value,
                            style: context.fonts.bodyMedium.rubik(
                              color: DColors.textPrimary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _removeResult(entry.key),
                    icon: Icon(Icons.delete_rounded, color: Colors.red.shade400, size: 20),
                  ),
                ],
              ),
            );
          }).toList(),
      ],
    );
  }

  void _addResult() {
    final key = _resultKeyController.text.trim();
    final value = _resultValueController.text.trim();
    if (key.isEmpty || value.isEmpty) return;

    final updated = Map<String, String>.from(widget.results)..[key] = value;
    widget.onResultsChanged(updated);
    _resultKeyController.clear();
    _resultValueController.clear();
  }

  void _removeResult(String key) {
    final updated = Map<String, String>.from(widget.results)..remove(key);
    widget.onResultsChanged(updated);
  }
}
