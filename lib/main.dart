import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:responsive_website/route/route_config.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:responsive_website/utility/constants/colors.dart';

void main() {
  if (kDebugMode) {
    WidgetsFlutterBinding.ensureInitialized();
    debugPrintScheduleBuildForStacks = false;
  }

  usePathUrlStrategy();
  runApp(const MyApp());
  //runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
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
}
