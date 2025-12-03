import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class PostMetaInfo extends StatelessWidget {
  final String author;
  final String date;
  final String readingTime;

  const PostMetaInfo({super.key, required this.author, required this.date, required this.readingTime});

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
        _buildMetaItem(context, icon: Icons.person_rounded, text: author, fonts: fonts),

        // Separator
        if (!context.isMobile)
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(color: DColors.textSecondary, shape: BoxShape.circle),
          ),

        // Date
        _buildMetaItem(context, icon: Icons.calendar_today_rounded, text: date, fonts: fonts),

        // Separator
        if (!context.isMobile)
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(color: DColors.textSecondary, shape: BoxShape.circle),
          ),

        // Reading Time
        _buildMetaItem(context, icon: Icons.access_time_rounded, text: readingTime, fonts: fonts),
      ],
    );
  }

  Widget _buildMetaItem(BuildContext context, {required IconData icon, required String text, required DFontSizes fonts}) {
    final s = context.sizes;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: DColors.primaryButton, size: 16),
        SizedBox(width: s.paddingXs),
        Text(
          text,
          style: fonts.bodySmall.rubik(
            color: DColors.textSecondary,
            fontSize: context.responsiveValue(mobile: 12.0, tablet: 13.0, desktop: 14.0),
          ),
        ),
      ],
    );
  }
}
