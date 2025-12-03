import 'admin_sidebar.dart';
import 'admin_header.dart';
import 'package:flutter/material.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/responsive/responsive_helper.dart';

class AdminLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;

  const AdminLayout({super.key, required this.child, required this.title, this.actions});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: DColors.background,

      // Drawer for mobile
      drawer: isMobile ? const AdminSidebar() : null,

      body: Row(
        children: [
          // Fixed Sidebar for Desktop/Tablet
          if (!isMobile) const AdminSidebar(),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Header
                AdminHeader(
                  title: widget.title,
                  onMenuPressed: isMobile ? () => _scaffoldKey.currentState?.openDrawer() : null,
                  actions: widget.actions,
                ),

                // Content
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
