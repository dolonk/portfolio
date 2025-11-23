import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class PopularTagsWidget extends StatelessWidget {
  const PopularTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    final popularTags = [
      'Flutter',
      'Dart',
      'BLoC',
      'Provider',
      'Firebase',
      'Architecture',
      'UI/UX',
      'Performance',
      'Testing',
      'State Management',
    ];

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Row(
            children: [
              Icon(Icons.local_offer_rounded, color: DColors.primaryButton, size: 20),
              SizedBox(width: s.paddingSm),
              Text(
                'Popular Tags',
                style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Tags
          Wrap(
            spacing: s.paddingSm,
            runSpacing: s.paddingSm,
            children: popularTags.map((tag) => _TagChip(tag: tag)).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideX(begin: 0.1, duration: 600.ms, delay: 600.ms);
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
      child: GestureDetector(
        onTap: () {
          // TODO: Filter by tag
          print('Filter by tag: ${widget.tag}');
        },
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
      ),
    );
  }
}
