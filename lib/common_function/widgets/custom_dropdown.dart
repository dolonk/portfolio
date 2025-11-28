import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import '../../utility/default_sizes/font_size.dart';
import '../../utility/default_sizes/default_sizes.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.isRequired = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    // Ensure value exists in items, otherwise use null
    final safeValue = items.contains(value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (label.isNotEmpty) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
              children: [
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red.shade400),
                  ),
              ],
            ),
          ),
          SizedBox(height: s.paddingSm),
        ],

        // Dropdown
        DropdownButtonFormField<T>(
          initialValue: safeValue,
          hint: Text(hint, style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary)),
          dropdownColor: DColors.secondaryBackground,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item), style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary)),
            );
          }).toList(),
          onChanged: onChanged,
          validator:
              validator ??
              (value) {
                if (isRequired && value == null) {
                  return 'Please select $label';
                }
                return null;
              },
          decoration: InputDecoration(
            filled: true,
            fillColor: DColors.secondaryBackground,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingMd),
          ),
        ),
      ],
    );
  }
}
