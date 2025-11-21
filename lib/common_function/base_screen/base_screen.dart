import '../../route/route_name.dart';
import 'footer/custom_footer.dart';
import 'app_bar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool useCustomScrollView;

  const BaseScreen({
    super.key,
    required this.child,
    this.extendBody,
    this.extendBodyBehindAppBar,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.useCustomScrollView = false,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      extendBody: widget.extendBody ?? false,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
      appBar: const CustomAppBar(),
      drawer: context.isMobile ? _buildDrawer(context) : null,
      body: widget.useCustomScrollView
          ? widget.child
          : Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(children: [widget.child, const FooterSection()]),
                ),
              ),
            ),
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }

  /// 📱 Mobile Drawer with URL navigation
  Widget _buildDrawer(BuildContext context) {
    // Get current route
    final currentRoute = GoRouterState.of(context).uri.path;

    return Drawer(
      backgroundColor: DColors.cardBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [DColors.primaryButton, DColors.primaryButton.withAlpha((255 * 0.7).round())],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Build Storm', style: context.fonts.displayMedium.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Text('Flutter Developer', style: context.fonts.bodyMedium.copyWith(color: Colors.white70)),
              ],
            ),
          ),

          // Menu Items
          _buildDrawerItem(
            context: context,
            icon: Icons.home_rounded,
            title: RouteNames.homeName,
            route: RouteNames.home,
            isActive: currentRoute == RouteNames.home,
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.work_rounded,
            title: RouteNames.servicesName,
            route: RouteNames.services,
            isActive: currentRoute == RouteNames.services,
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.folder_rounded,
            title: RouteNames.portfoliosName,
            route: RouteNames.portfolio,
            isActive: currentRoute == RouteNames.portfolio,
          ),

          _buildDrawerItem(
            context: context,
            icon: FontAwesomeIcons.dollarSign,
            title: RouteNames.priceName,
            route: RouteNames.price,
            isActive: currentRoute == RouteNames.price,
          ),

          _buildDrawerItem(
            context: context,
            icon: FontAwesomeIcons.blog,
            title: RouteNames.blogName,
            route: RouteNames.blog,
            isActive: currentRoute == RouteNames.portfolio,
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.person_rounded,
            title: RouteNames.aboutName,
            route: RouteNames.about,
            isActive: currentRoute == RouteNames.about,
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.email_rounded,
            title: RouteNames.contactName,
            route: RouteNames.contact,
            isActive: currentRoute == RouteNames.contact,
          ),

          const Divider(color: DColors.cardBorder),

          // Social Links Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Connect with us',
              style: context.fonts.labelMedium.copyWith(color: DColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  /// 📋 Drawer Item Widget
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    required bool isActive,
  }) {
    return ListTile(
      leading: Icon(icon, color: isActive ? DColors.primaryButton : DColors.textSecondary),
      title: Text(
        title,
        style: context.fonts.bodyMedium.copyWith(
          color: isActive ? DColors.primaryButton : DColors.textPrimary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      selected: isActive,
      selectedTileColor: DColors.primaryButton.withAlpha((255 * 0.1).round()),
      onTap: () {
        // Close drawer
        Navigator.of(context).pop();

        // Small delay for smooth animation
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!context.mounted) return;
          context.go(route);
        });
      },
    );
  }
}
