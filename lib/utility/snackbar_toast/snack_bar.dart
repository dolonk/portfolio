import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../route/route_config.dart';
import '../constants/colors.dart';

class DSnackBar {
  DSnackBar._();

  /// ✅ Show Success SnackBar
  static void success({required String title, String message = '', int durationInSeconds = 3}) {
    _show(
      title: title,
      message: message,
      backgroundColor: DColors.serviceGreen,
      duration: durationInSeconds,
      icon: FontAwesomeIcons.check,
    );
  }

  /// ❌ Show Error SnackBar
  static void error({required String title, String message = '', int durationInSeconds = 3}) {
    _show(
      title: title,
      message: message,
      backgroundColor: DColors.primaryButton,
      duration: durationInSeconds,
      icon: Icons.error,
    );
  }

  /// 🔐 Base SnackBar Builder
  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    required int duration,
    required IconData icon,
  }) {
    final context = RouteConfig.rootNavigatorKey.currentContext;

    if (context == null) {
      debugPrint('❌ GlobalContext is null! SnackBar not shown.');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                  ),
                  if (message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(message, style: const TextStyle(color: Colors.white)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
