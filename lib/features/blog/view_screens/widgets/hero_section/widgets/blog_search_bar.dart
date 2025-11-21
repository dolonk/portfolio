import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class BlogSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const BlogSearchBar({super.key, required this.onSearch});

  @override
  State<BlogSearchBar> createState() => _BlogSearchBarState();
}

class _BlogSearchBarState extends State<BlogSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFocused = false;

  @override
  void dispose() {
    _searchController.dispose();
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
      child: Row(
        children: [
          // Search Input Field
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {
                setState(() => _isFocused = hasFocus);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: DColors.cardBackground,
                  borderRadius: BorderRadius.circular(s.borderRadiusMd),
                  border: Border.all(
                    color: _isFocused ? DColors.primaryButton : DColors.cardBorder,
                    width: _isFocused ? 2 : 1,
                  ),
                  boxShadow: _isFocused
                      ? [
                          BoxShadow(
                            color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) => widget.onSearch(value),
                  style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    hintStyle: fonts.bodyMedium.rubik(color: DColors.textSecondary),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: _isFocused ? DColors.primaryButton : DColors.textSecondary,
                      size: 24,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: s.paddingMd,
                      vertical: context.responsiveValue(mobile: 14.0, tablet: 16.0, desktop: 18.0),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: s.paddingMd),

          // Search Button
          _buildSearchButton(context, s, fonts),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: 0.1, duration: 600.ms, delay: 400.ms);
  }

  /// Search Button
  Widget _buildSearchButton(BuildContext context, DSizes s, AppFonts fonts) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onSearch(_searchController.text),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(mobile: 20.0, tablet: 24.0, desktop: 28.0),
            vertical: context.responsiveValue(mobile: 14.0, tablet: 16.0, desktop: 18.0),
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [DColors.primaryButton, Color(0xFFD4003D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            boxShadow: [
              BoxShadow(
                color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_rounded,
                color: DColors.textPrimary,
                size: context.responsiveValue(mobile: 18.0, tablet: 20.0, desktop: 22.0),
              ),
              if (context.isDesktop) ...[
                SizedBox(width: s.paddingSm),
                Text(
                  'Search',
                  style: fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
