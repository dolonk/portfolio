import 'package:flutter/material.dart';
import '../view_models/dashboard_view_model.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final viewModel = DashboardViewModel(context);
    final recentProjects = viewModel.recentProjects;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Projects',
                style: context.fonts.titleLarge.rajdhani(
                  fontWeight: FontWeight.bold,
                  color: DColors.textPrimary,
                ),
              ),
              Text(
                '${recentProjects.length} projects',
                style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),

          // Show projects if available
          if (recentProjects.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: s.paddingXl),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.work_off_rounded, size: 48, color: DColors.textSecondary.withAlpha(127)),
                    SizedBox(height: s.paddingSm),
                    Text(
                      'No projects yet',
                      style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                    ),
                  ],
                ),
              ),
            )
          else
            ...recentProjects.asMap().entries.map((entry) {
              final index = entry.key;
              final project = entry.value;

              return Column(
                children: [
                  _buildActivityItem(
                    context,
                    s,
                    icon: Icons.work_rounded,
                    iconColor: Colors.green,
                    title: project.title,
                    subtitle: project.category,
                    time: _formatDate(project.createdAt),
                  ),
                  if (index < recentProjects.length - 1) _buildDivider(s),
                ],
              );
            }),
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
    required String subtitle,
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
                Text(
                  title,
                  style: context.fonts.bodyMedium.rubik(color: DColors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(subtitle, style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
                Text(time, style: context.fonts.bodySmall.rubik(color: DColors.textSecondary.withAlpha(178))),
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

  /// Format date without intl package
  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }
}
