import '../features/blog_detail/blog_detail_page.dart';
import '../features/pricing/pricing_page.dart';
import '../features/project_detail/project_detail_page.dart';
import 'error_page.dart';
import 'route_name.dart';
import 'package:flutter/material.dart';
import '../features/blog/blog_page.dart';
import 'package:go_router/go_router.dart';
import '../features/about/about_page.dart';
import '../features/contact/contact_page.dart';
import '../features/services/services_page.dart';
import 'package:portfolio/features/home/home_page.dart';
import 'package:portfolio/features/portfolio/portfolio_page.dart';

class RouteConfig {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: false,
    initialLocation: RouteNames.home,

    // 🎯 Route Configuration
    routes: [
      // Home Route
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.homeName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context: context, state: state, child: const HomePage()),
      ),

      // Services Route
      GoRoute(
        path: RouteNames.services,
        name: RouteNames.servicesName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context: context, state: state, child: const ServicesPage()),
      ),

      // Projects Route
      GoRoute(
        path: RouteNames.portfolio,
        name: RouteNames.portfoliosName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context: context, state: state, child: const PortfolioPage()),
      ),

      // Project Detail Route
      GoRoute(
        path: '${RouteNames.portfolio}/:projectId',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId']!;
          return ProjectDetailPage(projectId: projectId);
        },
      ),

      GoRoute(
        path: RouteNames.price,
        name: RouteNames.priceName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context: context, state: state, child: const PricingPage()),
      ),

      // Blog Route
      GoRoute(
        path: RouteNames.blog,
        name: RouteNames.blogName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context: context, state: state, child: const BlogPage()),
      ),

      // In route_config.dart
      GoRoute(
        path: '${RouteNames.blog}/:postId',
        builder: (context, state) {
          final postId = state.pathParameters['postId']!;
          return BlogDetailPage(postId: postId);
        },
      ),

      // About Route
      GoRoute(
        path: RouteNames.about,
        name: RouteNames.aboutName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context: context, state: state, child: const AboutPage()),
      ),

      // Contact Route
      GoRoute(
        path: RouteNames.contact,
        name: RouteNames.contactName,
        pageBuilder: (context, state) =>
            _buildPageWithTransition(context: context, state: state, child: const ContactPage()),
      ),

      // 404 Error Route
      GoRoute(
        path: RouteNames.error,
        name: RouteNames.errorName,
        pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: const ErrorPage()),
      ),
    ],

    // 🚫 Error Handler
    errorBuilder: (context, state) => const ErrorPage(),

    // 🔄 Redirect Logic (Optional)
    redirect: (context, state) {
      return null;
    },
  );

  /// 🎬 Custom Page Transition (No changes needed here)
  static CustomTransitionPage _buildPageWithTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade + Slide transition
        const begin = Offset(0.0, 0.05);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        var fadeAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
