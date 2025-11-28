/*
class CustomDropdown extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isFocused = false;
  String? _errorText;

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
            text: widget.label,
            style: fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
            children: [
              if (widget.isRequired)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red.shade400),
                ),
            ],
          ),
        ),
        SizedBox(height: s.paddingSm),

        // Dropdown with Focus Animation
        Focus(
          onFocusChange: (hasFocus) {
            setState(() => _isFocused = hasFocus);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              boxShadow: [
                if (_isFocused)
                  BoxShadow(
                    color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: DropdownButtonFormField<String>(
              initialValue: widget.value,
              hint: Text(widget.hint, style: fonts.bodyMedium.rubik(color: DColors.textSecondary)),
              items: widget.items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item, style: fonts.bodyMedium.rubik(color: DColors.textPrimary)),
                );
              }).toList(),
              onChanged: widget.onChanged,
              style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
              dropdownColor: DColors.cardBackground,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: DColors.textSecondary),
              decoration: InputDecoration(
                filled: true,
                fillColor: DColors.secondaryBackground,
                contentPadding: EdgeInsets.all(s.paddingMd),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  borderSide: BorderSide(color: DColors.cardBorder, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  borderSide: BorderSide(color: DColors.cardBorder, width: 1.5),
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
                errorStyle: const TextStyle(height: 0),
              ),
              validator: (value) {
                final error = widget.validator?.call(value);
                setState(() => _errorText = error);
                return error;
              },
            ),
          ),
        ),

        // Error Message with Shake Animation
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
*/
