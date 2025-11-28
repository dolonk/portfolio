import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';


class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

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
            'Quick Actions',
            style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingMd),

          // Action Buttons
          _buildActionButton(
            context,
            s,
            icon: Icons.add_rounded,
            title: 'Create Project',
            subtitle: 'Add new portfolio project',
            onTap: () => context.go('/admin/projects/create'),
          ),
          SizedBox(height: s.paddingSm),

          _buildActionButton(
            context,
            s,
            icon: Icons.edit_rounded,
            title: 'Write Blog Post',
            subtitle: 'Create new blog article',
            onTap: () => context.go('/admin/blogs/create'),
          ),
          SizedBox(height: s.paddingSm),

          _buildActionButton(
            context,
            s,
            icon: Icons.work_rounded,
            title: 'View All Projects',
            subtitle: 'Manage portfolio items',
            onTap: () => context.go('/admin/projects'),
          ),
          SizedBox(height: s.paddingSm),

          _buildActionButton(
            context,
            s,
            icon: Icons.comment_rounded,
            title: 'Manage Comments',
            subtitle: 'Review & approve comments',
            onTap: () => context.go('/admin/comments'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    DSizes s, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(s.borderRadiusMd),
      child: Container(
        padding: EdgeInsets.all(s.paddingMd),
        decoration: BoxDecoration(
          color: DColors.background,
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
          border: Border.all(color: DColors.cardBorder),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(s.paddingSm),
              decoration: BoxDecoration(
                color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
              ),
              child: Icon(icon, color: DColors.primaryButton, size: 20),
            ),
            SizedBox(width: s.paddingMd),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.fonts.bodyMedium.rubik(
                      fontWeight: FontWeight.w600,
                      color: DColors.textPrimary,
                    ),
                  ),
                  Text(subtitle, style: context.fonts.bodySmall.rubik(color: DColors.textSecondary)),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: DColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
