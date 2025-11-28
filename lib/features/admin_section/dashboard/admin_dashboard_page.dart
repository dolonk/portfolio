import 'widgets/stats_card.dart';
import 'widgets/quick_actions.dart';
import '../shared/admin_layout.dart';
import 'widgets/recent_activity.dart';
import 'package:flutter/material.dart';
import 'view_models/dashboard_view_model.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/default_sizes/font_size.dart';
import '../../../utility/default_sizes/default_sizes.dart';
import '../../../utility/responsive/responsive_helper.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final viewModel = DashboardViewModel(context);

    return AdminLayout(
      title: 'Dashboard',
      child: viewModel.isDashboardLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(s.paddingLg),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Header
                      _buildWelcomeHeader(context, s),
                      SizedBox(height: s.spaceBtwItems),

                      // Stats Cards (with real data from ViewModel)
                      _buildStatsSection(context, s, viewModel),
                      SizedBox(height: s.spaceBtwSections),

                      // Quick Actions + Recent Activity
                      _buildContentSection(context, s),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  /// Welcome Header
  Widget _buildWelcomeHeader(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back! 👋',
          style: context.fonts.displaySmall.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
        SizedBox(height: s.paddingSm),
        Text(
          'Here\'s what\'s happening with your portfolio today',
          style: context.fonts.bodyLarge.rubik(color: DColors.textSecondary),
        ),
      ],
    );
  }

  /// Stats Section (Real data from ViewModel)
  Widget _buildStatsSection(BuildContext context, DSizes s, DashboardViewModel viewModel) {
    final isMobile = context.isMobile;

    // Get stats from ViewModel
    final projectCount = viewModel.totalProjects.toString();
    final blogCount = viewModel.totalBlogs.toString();
    final commentCount = viewModel.totalComments.toString();
    final viewCount = viewModel.totalViews.toString();

    // Mobile: 2 columns
    if (isMobile) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StatsCard(title: 'Projects', value: projectCount, icon: Icons.work_rounded),
              ),
              SizedBox(width: s.paddingMd),
              Expanded(
                child: StatsCard(title: 'Blog Posts', value: blogCount, icon: Icons.article_rounded),
              ),
            ],
          ),
          SizedBox(height: s.paddingMd),
          Row(
            children: [
              Expanded(
                child: StatsCard(title: 'Comments', value: commentCount, icon: Icons.comment_rounded),
              ),
              SizedBox(width: s.paddingMd),
              Expanded(
                child: StatsCard(title: 'Total Views', value: viewCount, icon: Icons.visibility_rounded),
              ),
            ],
          ),
        ],
      );
    }

    // Tablet/Desktop: 4 columns
    return Row(
      children: [
        Expanded(
          child: StatsCard(title: 'Projects', value: projectCount, icon: Icons.work_rounded),
        ),
        SizedBox(width: s.paddingMd),
        Expanded(
          child: StatsCard(title: 'Blog Posts', value: blogCount, icon: Icons.article_rounded),
        ),
        SizedBox(width: s.paddingMd),
        Expanded(
          child: StatsCard(title: 'Comments', value: commentCount, icon: Icons.comment_rounded),
        ),
        SizedBox(width: s.paddingMd),
        Expanded(
          child: StatsCard(title: 'Total Views', value: viewCount, icon: Icons.visibility_rounded),
        ),
      ],
    );
  }

  /// Content Section (Quick Actions + Recent Activity)
  Widget _buildContentSection(BuildContext context, DSizes s) {
    final isMobile = context.isMobile;

    // Mobile: Stacked
    if (isMobile) {
      return Column(
        children: [
          QuickActions(),
          SizedBox(height: s.spaceBtwItems),
          RecentActivity(),
        ],
      );
    }

    // Desktop/Tablet: Side by side
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: QuickActions()),
        SizedBox(width: s.spaceBtwItems),
        Expanded(flex: 2, child: RecentActivity()),
      ],
    );
  }
}
