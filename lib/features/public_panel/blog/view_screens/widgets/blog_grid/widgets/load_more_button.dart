import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class LoadMoreButton extends StatefulWidget {
  final VoidCallback onPressed;
  final int currentCount;
  final int totalCount;
  final bool isLoading;

  const LoadMoreButton({
    super.key,
    required this.onPressed,
    required this.currentCount,
    required this.totalCount,
    this.isLoading = false,
  });

  @override
  State<LoadMoreButton> createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      children: [
        // Showing X of Y text
        Text(
          'Showing ${widget.currentCount} of ${widget.totalCount} articles',
          style: fonts.bodySmall.rubik(color: DColors.textSecondary),
        ),
        SizedBox(height: s.paddingMd),

        // Load More Button
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.isLoading ? null : widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveValue(mobile: 28.0, tablet: 32.0, desktop: 36.0),
                vertical: context.responsiveValue(mobile: 14.0, tablet: 16.0, desktop: 18.0),
              ),
              decoration: BoxDecoration(
                gradient: _isHovered
                    ? const LinearGradient(
                        colors: [DColors.primaryButton, Color(0xFFD4003D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: _isHovered ? null : DColors.cardBackground,
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                border: Border.all(color: _isHovered ? DColors.primaryButton : DColors.cardBorder, width: 2),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isLoading)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _isHovered ? DColors.textPrimary : DColors.primaryButton,
                        ),
                      ),
                    )
                  else
                    Icon(
                      Icons.refresh_rounded,
                      color: _isHovered ? DColors.textPrimary : DColors.textSecondary,
                      size: 20,
                    ),
                  SizedBox(width: s.paddingSm),
                  Text(
                    widget.isLoading ? 'Loading...' : 'Load More Posts',
                    style: fonts.bodyMedium.rubik(
                      color: _isHovered ? DColors.textPrimary : DColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
