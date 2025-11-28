import 'package:flutter/material.dart';
import 'widgets/sidebar_menu_item.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../utility/constants/colors.dart';
import '../auth/providers/admin_auth_provider.dart';
import '../../../utility/default_sizes/font_size.dart';
import '../../../utility/default_sizes/default_sizes.dart';

class AdminSidebar extends StatefulWidget {
  const AdminSidebar({super.key});

  @override
  State<AdminSidebar> createState() => _AdminSidebarState();
}

class _AdminSidebarState extends State<AdminSidebar> {
  String? _expandedItem;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final currentRoute = GoRouterState.of(context).uri.path;

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        border: Border(right: BorderSide(color: DColors.cardBorder, width: 1)),
      ),
      child: Column(
        children: [
          // Logo/Header
          _buildHeader(context, s),

          // Divider
          Divider(height: 1, color: DColors.cardBorder),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: s.paddingMd),
              children: _buildMenuItems(context, s, currentRoute),
            ),
          ),

          // Divider
          Divider(height: 1, color: DColors.cardBorder),

          // Logout Button
          _buildLogoutButton(context, s),
        ],
      ),
    );
  }

  /// Header with Logo
  Widget _buildHeader(BuildContext context, DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
              borderRadius: BorderRadius.circular(s.borderRadiusMd),
            ),
            child: Icon(Icons.admin_panel_settings_rounded, color: DColors.primaryButton, size: 24),
          ),
          SizedBox(width: s.paddingSm),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Panel',
                  style: context.fonts.titleLarge.rajdhani(
                    fontWeight: FontWeight.bold,
                    color: DColors.textPrimary,
                  ),
                ),
                Text('Portfolio CMS', style: context.fonts.labelSmall.rubik(color: DColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build Menu Items
  List<Widget> _buildMenuItems(BuildContext context, DSizes s, String currentRoute) {
    return [
      // Dashboard
      SidebarMenuItem(
        icon: Icons.dashboard_rounded,
        title: 'Dashboard',
        route: '/admin/dashboard',
        currentRoute: currentRoute,
        onTap: () => _navigateTo(context, '/admin/dashboard'),
      ),
      SizedBox(height: s.paddingSm),

      // Projects (Expandable)
      SidebarMenuItem(
        icon: Icons.work_rounded,
        title: 'Projects',
        route: '/admin/projects',
        currentRoute: currentRoute,
        isExpandable: true,
        isExpanded: _expandedItem == 'projects',
        onTap: () => _toggleExpand('projects'),
        children: [
          SidebarMenuItem(
            title: 'All Projects',
            route: '/admin/projects',
            currentRoute: currentRoute,
            onTap: () => _navigateTo(context, '/admin/projects'),
            isChild: true,
          ),
          SidebarMenuItem(
            title: 'Create New',
            route: '/admin/projects/create',
            currentRoute: currentRoute,
            onTap: () => _navigateTo(context, '/admin/projects/create'),
            isChild: true,
          ),
        ],
      ),
      SizedBox(height: s.paddingSm),

      // Blogs (Expandable) - Future
      SidebarMenuItem(
        icon: Icons.article_rounded,
        title: 'Blogs',
        route: '/admin/blogs',
        currentRoute: currentRoute,
        isExpandable: true,
        isExpanded: _expandedItem == 'blogs',
        onTap: () => _toggleExpand('blogs'),
        children: [
          SidebarMenuItem(
            title: 'All Posts',
            route: '/admin/blogs',
            currentRoute: currentRoute,
            onTap: () => _navigateTo(context, '/admin/blogs'),
            isChild: true,
          ),
          SidebarMenuItem(
            title: 'Write New',
            route: '/admin/blogs/create',
            currentRoute: currentRoute,
            onTap: () => _navigateTo(context, '/admin/blogs/create'),
            isChild: true,
          ),
        ],
      ),
      SizedBox(height: s.paddingSm),

      // Comments - Future
      SidebarMenuItem(
        icon: Icons.comment_rounded,
        title: 'Comments',
        route: '/admin/comments',
        currentRoute: currentRoute,
        onTap: () => _navigateTo(context, '/admin/comments'),
      ),
    ];
  }

  /// Logout Button
  Widget _buildLogoutButton(BuildContext context, DSizes s) {
    final authProvider = context.read<AdminAuthProvider>();

    return InkWell(
      onTap: () async {
        await authProvider.logout();
        if (context.mounted) {
          context.go('/admin/login');
        }
      },
      child: Container(
        padding: EdgeInsets.all(s.paddingLg),
        child: Row(
          children: [
            Icon(Icons.logout_rounded, color: Colors.red.shade400, size: 20),
            SizedBox(width: s.paddingMd),
            Text(
              'Logout',
              style: context.fonts.bodyMedium.rubik(color: Colors.red.shade400, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  /// Toggle Expand
  void _toggleExpand(String item) {
    setState(() {
      _expandedItem = _expandedItem == item ? null : item;
    });
  }

  /// Navigate and close drawer if mobile
  void _navigateTo(BuildContext context, String route) {
    context.go(route);

    // Close drawer if mobile
    if (Scaffold.of(context).hasDrawer) {
      Navigator.of(context).pop();
    }
  }
}
