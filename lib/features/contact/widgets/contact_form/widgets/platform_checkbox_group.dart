import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class PlatformCheckboxGroup extends StatefulWidget {
  final List<String> selectedPlatforms;
  final void Function(List<String>) onChanged;
  final String? Function(List<String>)? validator;

  const PlatformCheckboxGroup({super.key, required this.selectedPlatforms, required this.onChanged, this.validator});

  @override
  State<PlatformCheckboxGroup> createState() => _PlatformCheckboxGroupState();
}

class _PlatformCheckboxGroupState extends State<PlatformCheckboxGroup> {
  final List<String> _platforms = ['iOS', 'Android', 'Web', 'Windows', 'macOS', 'Linux'];
  String? _errorText;

  void _validate() {
    final error = widget.validator?.call(widget.selectedPlatforms);
    setState(() => _errorText = error);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            text: 'Platform(s) Needed',
            style: fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red.shade400),
              ),
            ],
          ),
        ),
        SizedBox(height: s.paddingSm),

        // Checkboxes Grid
        Wrap(
          spacing: context.isMobile ? s.paddingMd : s.paddingLg,
          runSpacing: s.paddingSm,
          children: _platforms.map((platform) {
            final isSelected = widget.selectedPlatforms.contains(platform);

            return _PlatformCheckbox(
              label: platform,
              isSelected: isSelected,
              onChanged: (selected) {
                final newList = List<String>.from(widget.selectedPlatforms);
                if (selected) {
                  newList.add(platform);
                } else {
                  newList.remove(platform);
                }
                widget.onChanged(newList);
                _validate();
              },
            );
          }).toList(),
        ),

        // Error Message
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: s.paddingSm, left: s.paddingSm),
            child: Text(
              _errorText!,
              style: fonts.bodySmall.rubik(color: Colors.red.shade400),
            ).animate(key: ValueKey(_errorText)).shake(duration: 500.ms, hz: 2, curve: Curves.easeInOut),
          ),
      ],
    );
  }
}

/// Individual Platform Checkbox
class _PlatformCheckbox extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function(bool) onChanged;

  const _PlatformCheckbox({required this.label, required this.isSelected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return InkWell(
      onTap: () => onChanged(!isSelected),
      borderRadius: BorderRadius.circular(s.borderRadiusSm),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: s.paddingSm * 0.5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom Checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? DColors.primaryButton : Colors.transparent,
                border: Border.all(color: isSelected ? DColors.primaryButton : DColors.cardBorder, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
            SizedBox(width: s.paddingSm),

            // Label
            Text(
              label,
              style: fonts.bodyMedium.rubik(
                color: DColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
