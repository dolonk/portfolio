import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart';
import 'package:portfolio/route/route_config.dart';
import 'features/blog/providers/blog_provider.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'features/blog_detail/providers/comment_provider.dart';
import 'features/portfolio/providers/project_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Remove # Url
  usePathUrlStrategy();

  // ==================== FIREBASE INITIALIZATION (OPTIONAL) ====================
  bool firebaseInitialized = false;

  // ==================== DEPENDENCY INJECTION SETUP ====================
  await initializeDependencies(useFirebase: firebaseInitialized);

  runApp(const MyApp());
  //runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Blog Provider
        ChangeNotifierProvider<BlogProvider>(create: (_) => getIt<BlogProvider>()),

        // Comment Provider
        ChangeNotifierProvider<CommentProvider>(create: (_) => getIt<CommentProvider>()),

        // Project Provider
        ChangeNotifierProvider<ProjectProvider>(create: (_) => getIt<ProjectProvider>()),
      ],
      child: MaterialApp.router(
        title: 'Portfolio',
        debugShowCheckedModeBanner: false,
        routerConfig: RouteConfig.router,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: DColors.background,
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
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
      ),
    );
  }
}
