import 'package:flutter/material.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

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
          Text(
            'Recent Activity',
            style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingMd),

          // Activity Items
          _buildActivityItem(
            context,
            s,
            icon: Icons.comment_rounded,
            iconColor: Colors.blue,
            title: 'New comment on "Flutter MVVM Architecture"',
            time: '2 hours ago',
          ),
          _buildDivider(s),

          _buildActivityItem(
            context,
            s,
            icon: Icons.work_rounded,
            iconColor: Colors.green,
            title: 'Project "ShopEase App" published',
            time: '5 hours ago',
          ),
          _buildDivider(s),

          _buildActivityItem(
            context,
            s,
            icon: Icons.edit_rounded,
            iconColor: Colors.orange,
            title: 'Draft saved: "Advanced Flutter Patterns"',
            time: '1 day ago',
          ),
          _buildDivider(s),

          _buildActivityItem(
            context,
            s,
            icon: Icons.visibility_rounded,
            iconColor: Colors.purple,
            title: '45 new views on portfolio',
            time: '2 days ago',
          ),
          _buildDivider(s),

          _buildActivityItem(
            context,
            s,
            icon: Icons.thumb_up_rounded,
            iconColor: Colors.pink,
            title: '12 new likes on blog posts',
            time: '3 days ago',
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    DSizes s, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: s.paddingSm),
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(s.paddingSm),
            decoration: BoxDecoration(
              color: iconColor.withAlpha((255 * 0.1).round()),
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          SizedBox(width: s.paddingMd),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary)),
                Text(time, style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(DSizes s) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: s.paddingSm),
      child: Divider(height: 1, color: DColors.cardBorder),
    );
  }
}
