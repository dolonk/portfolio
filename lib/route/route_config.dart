import '../features/admin_section/auth/login_page.dart';
import '../features/admin_section/dashboard/admin_dashboard_page.dart';
import '../features/admin_section/projects/all_projects/project_list_page.dart';
import '../features/admin_section/projects/project_editor/project_editor_page.dart';
import '../features/blog_detail/view_screens/blog_detail_page.dart';
import '../features/pricing/pricing_page.dart';
import '../features/project_detail/project_detail_page.dart';
import 'error_page.dart';
import 'route_name.dart';
import 'package:flutter/material.dart';
import '../features/blog/view_screens/blog_page.dart';
import 'package:go_router/go_router.dart';
import '../features/about/about_page.dart';
import '../features/contact/contact_page.dart';
import '../features/services/services_page.dart';
import 'package:portfolio/features/home/home_page.dart';
import 'package:portfolio/features/portfolio/view_screens/portfolio_page.dart';

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

      // ==================== ADMIN ROUTES ====================
      // Admin Login
      GoRoute(path: '/admin/login', name: 'adminLogin', builder: (context, state) => const AdminLoginPage()),

      // Admin Dashboard
      GoRoute(
        path: '/admin/dashboard',
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardPage(),
      ),

      // Add routes after admin dashboard
      GoRoute(
        path: '/admin/projects',
        name: 'adminProjects',
        builder: (context, state) => const ProjectListPage(),
      ),

      GoRoute(
        path: '/admin/projects/create',
        name: 'adminProjectCreate',
        builder: (context, state) => const ProjectEditorPage(),
      ),

      GoRoute(
        path: '/admin/projects/edit/:projectId',
        name: 'adminProjectEdit',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'];
          return ProjectEditorPage(projectId: projectId);
        },
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
