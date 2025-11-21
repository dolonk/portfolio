import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class PostTags extends StatelessWidget {
  final List<String> tags;
  final int maxTags;

  const PostTags({super.key, required this.tags, this.maxTags = 4});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final displayTags = tags.take(maxTags).toList();

    return Wrap(
      spacing: s.paddingSm,
      runSpacing: s.paddingSm,
      alignment: context.isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: displayTags.map((tag) => _TagChip(tag: tag)).toList(),
    );
  }
}

class _TagChip extends StatefulWidget {
  final String tag;

  const _TagChip({required this.tag});

  @override
  State<_TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<_TagChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
        decoration: BoxDecoration(
          color: _isHovered
              ? DColors.primaryButton.withAlpha((255 * 0.2).round())
              : DColors.primaryButton.withAlpha((255 * 0.1).round()),
          borderRadius: BorderRadius.circular(s.borderRadiusSm),
          border: Border.all(
            color: _isHovered ? DColors.primaryButton : DColors.primaryButton.withAlpha((255 * 0.3).round()),
            width: 1,
          ),
        ),
        child: Text(
          '#${widget.tag}',
          style: fonts.labelSmall.rubik(
            color: _isHovered ? DColors.primaryButton : DColors.textSecondary,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
