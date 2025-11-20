import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class TableOfContents extends StatefulWidget {
  final List<String> headings;
  final int activeIndex;
  final Function(int) onHeadingTap;

  const TableOfContents({
    super.key,
    required this.headings,
    required this.activeIndex,
    required this.onHeadingTap,
  });

  @override
  State<TableOfContents> createState() => _TableOfContentsState();
}

class _TableOfContentsState extends State<TableOfContents> {
  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

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
          // Header
          Row(
            children: [
              Icon(Icons.list_rounded, color: DColors.primaryButton, size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                'Table of Contents',
                style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Headings List
          ...widget.headings.asMap().entries.map((entry) {
            final index = entry.key;
            final heading = entry.value;
            final isActive = index == widget.activeIndex;

            return _TocItem(heading: heading, isActive: isActive, onTap: () => widget.onHeadingTap(index));
          }),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 500.ms).slideX(begin: 0.1, duration: 600.ms, delay: 500.ms);
  }
}

class _TocItem extends StatefulWidget {
  final String heading;
  final bool isActive;
  final VoidCallback onTap;

  const _TocItem({required this.heading, required this.isActive, required this.onTap});

  @override
  State<_TocItem> createState() => _TocItemState();
}

class _TocItemState extends State<_TocItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(bottom: s.paddingSm),
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: widget.isActive
                ? DColors.primaryButton.withAlpha((255 * 0.1).round())
                : _isHovered
                ? DColors.cardBorder.withAlpha((255 * 0.3).round())
                : Colors.transparent,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(
              color: widget.isActive
                  ? DColors.primaryButton
                  : _isHovered
                  ? DColors.cardBorder
                  : Colors.transparent,
              width: widget.isActive ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Active indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.isActive ? 4 : 2,
                height: widget.isActive ? 16 : 12,
                decoration: BoxDecoration(
                  color: widget.isActive ? DColors.primaryButton : DColors.textSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: s.paddingSm),

              // Heading text
              Expanded(
                child: Text(
                  widget.heading,
                  style: fonts.bodySmall.rubik(
                    color: widget.isActive
                        ? DColors.primaryButton
                        : _isHovered
                        ? DColors.textPrimary
                        : DColors.textSecondary,
                    fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
