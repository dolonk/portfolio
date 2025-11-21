import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class FaqSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;

  const FaqSearchBar({super.key, required this.onSearchChanged});

  @override
  State<FaqSearchBar> createState() => _FaqSearchBarState();
}

class _FaqSearchBarState extends State<FaqSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
      ),
      child: Focus(
        onFocusChange: (focused) => setState(() => _isFocused = focused),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(
              color: _isFocused ? DColors.primaryButton : DColors.cardBorder,
              width: _isFocused ? 2 : 1.5,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: _controller,
            onChanged: widget.onSearchChanged,
            style: fonts.bodyLarge.rubik(color: DColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search questions... (e.g., "payment methods", "refund")',
              hintStyle: fonts.bodyMedium.rubik(color: DColors.textSecondary),
              prefixIcon: Icon(Icons.search_rounded, color: DColors.primaryButton, size: 24),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear_rounded, color: DColors.textSecondary),
                      onPressed: () {
                        _controller.clear();
                        widget.onSearchChanged('');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(s.paddingMd),
            ),
          ),
        ),
      ),
    );
  }
}
