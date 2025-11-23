import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../route/route_name.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../view_models/blog_view_model.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class PopularTagsWidget extends StatelessWidget {
  const PopularTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = BlogViewModel(context);
    final s = context.sizes;
    final fonts = context.fonts;

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
          _buildHeader(context, fonts, s),
          SizedBox(height: s.paddingMd),

          _buildTagsGrid(context, vm, vm.allTags, s),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideX(begin: 0.1, duration: 600.ms, delay: 600.ms);
  }

  /// Header with icon and title
  Widget _buildHeader(BuildContext context, AppFonts fonts, DSizes s) {
    return Row(
      children: [
        Icon(Icons.local_offer_rounded, color: DColors.primaryButton, size: 20),
        SizedBox(width: s.paddingSm),
        Text(
          'Popular Tags',
          style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ],
    );
  }

  /// Tags grid with data
  Widget _buildTagsGrid(BuildContext context, BlogViewModel vm, List<String> tags, DSizes s) {
    final sortedTags = _getSortedTags(vm, tags);
    final displayTags = sortedTags.take(5).toList();

    return Wrap(
      spacing: s.paddingSm,
      runSpacing: s.paddingSm,
      children: displayTags.map((tag) {
        final count = vm.getPostCountByTag(tag);
        final isSelected = vm.selectedTag == tag;

        return _TagChip(
          tag: tag,
          count: count,
          isSelected: isSelected,
          onTap: () => _handleTagTap(context, vm, tag),
        );
      }).toList(),
    );
  }

  /// Sort tags by post count (descending)
  List<String> _getSortedTags(BlogViewModel vm, List<String> tags) {
    final tagCounts = <String, int>{};

    for (final tag in tags) {
      tagCounts[tag] = vm.getPostCountByTag(tag);
    }

    // Sort by count descending
    final sortedEntries = tagCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return sortedEntries.map((e) => e.key).toList();
  }

  /// Handle tag tap - filter or custom callback
  void _handleTagTap(BuildContext context, BlogViewModel vm, String tag) {
    vm.filterByTag(tag);
    final currentRoute = GoRouterState.of(context).uri.toString();
    if (!currentRoute.contains('/blog')) {
      context.go(RouteNames.blog);
    }
  }
}

class _TagChip extends StatefulWidget {
  final String tag;
  final int? count;
  final bool isSelected;
  final VoidCallback onTap;

  const _TagChip({required this.tag, this.count, this.isSelected = false, required this.onTap});

  @override
  State<_TagChip> createState() => _TagChipState();
}

class _TagChipState extends State<_TagChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    final isActive = widget.isSelected || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? DColors.primaryButton
                : isActive
                ? DColors.primaryButton.withAlpha(51)
                : DColors.primaryButton.withAlpha(25),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(
              color: isActive ? DColors.primaryButton : DColors.primaryButton.withAlpha(76),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tag name with hashtag
              Text(
                '#${widget.tag}',
                style: fonts.labelSmall.rubik(
                  color: widget.isSelected
                      ? Colors.white
                      : isActive
                      ? DColors.primaryButton
                      : DColors.textSecondary,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),

              // Post count badge
              if (widget.count != null) ...[
                SizedBox(width: s.paddingSm * 0.5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: s.paddingSm * 0.6, vertical: 2),
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? Colors.white.withAlpha(50)
                        : DColors.primaryButton.withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${widget.count}',
                    style: fonts.labelSmall.rubik(
                      color: widget.isSelected ? Colors.white : DColors.primaryButton,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
