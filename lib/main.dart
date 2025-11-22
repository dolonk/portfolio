import 'package:flutter/material.dart';
import 'package:portfolio/route/route_config.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:provider/provider.dart';
import 'core/config/firebase_options.dart';
import 'core/di/injection_container.dart';
import 'features/blog/providers/blog_filter_provider.dart';
import 'features/blog/providers/blog_provider.dart';
import 'features/blog/providers/blog_search_provider.dart';
import 'package:firebase_core/firebase_core.dart';

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



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ==================== FIREBASE INITIALIZATION (OPTIONAL) ====================
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    firebaseInitialized = true;
    print('✅ Firebase initialized successfully');
  } catch (e) {
    print('⚠️ Firebase initialization failed: $e');
    print('📝 Using static data instead');
  }

  // ==================== DEPENDENCY INJECTION SETUP ====================
  await initializeDependencies(useFirebase: firebaseInitialized);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ==================== BLOG PROVIDERS (From GetIt) ====================

        // Blog Provider
        ChangeNotifierProvider<BlogProvider>(create: (_) => getIt<BlogProvider>()),

        // Search Provider
        ChangeNotifierProvider<BlogSearchProvider>(create: (_) => getIt<BlogSearchProvider>()),

        // Filter Provider
        ChangeNotifierProvider<BlogFilterProvider>(create: (_) => getIt<BlogFilterProvider>()),
      ],
      child: MaterialApp.router(
        title: 'Portfolio - Dolon Kumar',
        debugShowCheckedModeBanner: false,
        routerConfig: RouteConfig.router,
        theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: DColors.background),
      ),
    );
  }
}
