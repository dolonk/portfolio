import 'package:flutter/material.dart';
import '../../../route/route_name.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/common_function/base_screen/app_bar/widgets/appbar_menu_item.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    // Get current route
    final currentRoute = GoRouterState.of(context).uri.path;

    return AppBar(
      elevation: 0,
      backgroundColor: DColors.background,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: context.isMobile
          ? GestureDetector(
              onTap: () => context.go('/'),
              child: Text('Build Storm', style: context.fonts.displayMedium),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBarMenuItem(
                  title: RouteNames.homeName,
                  isActive: currentRoute == RouteNames.home,
                  onTap: () => context.go(RouteNames.home),
                ),

                AppBarMenuItem(
                  title: RouteNames.servicesName,
                  isActive: currentRoute == RouteNames.services,
                  onTap: () => context.go(RouteNames.services),
                ),

                AppBarMenuItem(
                  title: RouteNames.portfoliosName,
                  isActive: currentRoute == RouteNames.portfolio,
                  onTap: () => context.go(RouteNames.portfolio),
                ),

                AppBarMenuItem(
                  title: RouteNames.priceName,
                  isActive: currentRoute == RouteNames.price,
                  onTap: () => context.go(RouteNames.price),
                ),

                AppBarMenuItem(
                  title: RouteNames.blogName,
                  isActive: currentRoute == RouteNames.blog,
                  onTap: () => context.go(RouteNames.blog),
                ),

                AppBarMenuItem(
                  title: RouteNames.aboutName,
                  isActive: currentRoute == RouteNames.about,
                  onTap: () => context.go(RouteNames.about),
                ),

                AppBarMenuItem(
                  title: RouteNames.contactName,
                  isActive: currentRoute == RouteNames.contact,
                  onTap: () => context.go(RouteNames.contact),
                ),
              ],
            ),
    );
  }
}
