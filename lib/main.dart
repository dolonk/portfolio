import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:portfolio/route/route_config.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:provider/provider.dart';

import 'core/di/injection_container.dart';
import 'features/blog/providers/blog_filter_provider.dart';
import 'features/blog/providers/blog_provider.dart';
import 'features/blog/providers/blog_search_provider.dart';

/*void main() {
  if (kDebugMode) {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrintScheduleBuildForStacks = false;
  }

  usePathUrlStrategy();
  //runApp(const MyApp());
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Build Storm - Flutter Portfolio',
      debugShowCheckedModeBanner: false,

      // Device Preview support
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      // Theme
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          minThumbLength: 60,
          thickness: WidgetStateProperty.all(8.0),
          trackVisibility: WidgetStateProperty.all(false),
          thumbColor: WidgetStateProperty.all(DColors.primaryButton.withAlpha((255 * 0.8).round())),
          thumbVisibility: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.dragged) || states.contains(WidgetState.hovered)) return true;
            return false;
          }),
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),

      // 🚀 GoRouter Configuration
      routerConfig: RouteConfig.router,
    );
  }
}*/

const bool kUseFirebase = false;

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // URL Strategy for web
  usePathUrlStrategy();

  // ==================== PHASE 1: Static Data Mode ====================
  if (!kUseFirebase) {
    print('\n🎯 PHASE 1: Running with STATIC DATA');
    print('📝 No Firebase required - Perfect for testing!\n');

    // Initialize DI without Firebase
    await initializeDependencies(useFirebase: false);
  }

  // ==================== PHASE 2: Firebase Mode ====================
  // Phase 2 এ এই block uncomment করবে
  /*
  else {
    print('\n🔥 PHASE 2: Running with FIREBASE');

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized\n');

    // Initialize DI with Firebase
    await initializeDependencies(useFirebase: true);
  }
  */

  // Hide debug banner in debug mode
  if (kDebugMode) {
    debugPrintScheduleBuildForStacks = false;
  }

  // Run app
  runApp(DevicePreview(enabled: kDebugMode, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ==================== BLOG PROVIDERS ====================

        // Main Blog Provider
        ChangeNotifierProvider(
          create: (_) => getIt<BlogProvider>()
            ..fetchAllPosts() // Auto-fetch on init
            ..fetchFeaturedPosts()
            ..fetchAllTags(),
        ),

        // Blog Search Provider
        ChangeNotifierProvider(create: (_) => getIt<BlogSearchProvider>()),

        // Blog Filter Provider
        ChangeNotifierProvider(create: (_) => getIt<BlogFilterProvider>()),

        // ==================== PORTFOLIO PROVIDERS ====================
        // TODO: Add portfolio providers in next phase
        // ChangeNotifierProvider(
        //   create: (_) => getIt<PortfolioProvider>()..fetchAllProjects(),
        // ),
      ],
      child: MaterialApp.router(
        title: 'Build Storm - Flutter Portfolio',
        debugShowCheckedModeBanner: false,

        // Device Preview support
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,

        // Theme
        theme: ThemeData(
          scrollbarTheme: ScrollbarThemeData(
            interactive: true,
            minThumbLength: 60,
            thickness: WidgetStateProperty.all(8.0),
            trackVisibility: WidgetStateProperty.all(false),
            thumbColor: WidgetStateProperty.all(DColors.primaryButton.withAlpha((255 * 0.8).round())),
            thumbVisibility: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.dragged) || states.contains(WidgetState.hovered)) {
                return true;
              }
              return false;
            }),
          ),
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),

        // GoRouter Configuration
        routerConfig: RouteConfig.router,
      ),
    );
  }
}
