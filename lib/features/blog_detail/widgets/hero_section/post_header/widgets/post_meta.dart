import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class PostMeta extends StatelessWidget {
  final String author;
  final String publishedDate;
  final String readingTime;
  final int viewCount;

  const PostMeta({
    super.key,
    required this.author,
    required this.publishedDate,
    required this.readingTime,
    required this.viewCount,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Wrap(
      spacing: context.responsiveValue(mobile: 12.0, tablet: 16.0, desktop: 20.0),
      runSpacing: s.paddingSm,
      alignment: WrapAlignment.center,
      children: [
        // Author
        _MetaItem(icon: Icons.person_rounded, text: author, fonts: fonts),

        // Separator
        if (!context.isMobile) _buildSeparator(),

        // Date
        _MetaItem(icon: Icons.calendar_today_rounded, text: publishedDate, fonts: fonts),

        // Separator
        if (!context.isMobile) _buildSeparator(),

        // Reading Time
        _MetaItem(icon: Icons.access_time_rounded, text: readingTime, fonts: fonts),

        // Separator
        if (!context.isMobile) _buildSeparator(),

        // View Count
        _MetaItem(icon: Icons.visibility_rounded, text: '${_formatViewCount(viewCount)} views', fonts: fonts),
      ],
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(color: DColors.textSecondary, shape: BoxShape.circle),
    );
  }

  String _formatViewCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final AppFonts fonts;

  const _MetaItem({required this.icon, required this.text, required this.fonts});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: DColors.primaryButton, size: 16),
        SizedBox(width: s.paddingXs),
        Text(
          text,
          style: fonts.bodySmall.rubik(
            color: DColors.textPrimary,
            fontSize: context.responsiveValue(mobile: 12.0, tablet: 13.0, desktop: 14.0),
          ),
        ),
      ],
    );
  }
}
