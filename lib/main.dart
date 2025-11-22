import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart';
import 'package:portfolio/route/route_config.dart';
import 'features/blog/providers/blog_provider.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'features/blog/providers/blog_search_provider.dart';
import 'features/blog/providers/blog_filter_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

        // Search Provider
        ChangeNotifierProvider<BlogSearchProvider>(create: (_) => getIt<BlogSearchProvider>()),

        // Filter Provider
        ChangeNotifierProvider<BlogFilterProvider>(create: (_) => getIt<BlogFilterProvider>()),
      ],
      child: MaterialApp.router(
        title: 'Portfolio',
        debugShowCheckedModeBanner: false,
        routerConfig: RouteConfig.router,
        theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: DColors.background),
      ),
    );
  }
}
