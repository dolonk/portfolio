import '../../route/route_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:portfolio/utility/url_launcher_service/url_validator.dart';
import 'package:portfolio/utility/url_launcher_service/url_launch_result.dart';

class UrlLauncherService {
  static final UrlLauncherService _instance = UrlLauncherService._internal();
  factory UrlLauncherService() => _instance;
  UrlLauncherService._internal();

  /// PRIVATE HELPER
  void _handleFailure(UrlLaunchResult result) {
    debugPrint('URL Launch Error: ${result.errorMessage}');

    final context = RouteConfig.rootNavigatorKey.currentContext;

    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? 'Could not perform the action.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// launch operation
  Future<void> _launchOperation(Future<UrlLaunchResult> Function() launchFunction) async {
    final result = await launchFunction();
    if (!result.success) {
      _handleFailure(result);
    }
  }

  /// Launch email client with built-in error handling.
  Future<void> launchEmail({
    required String email,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    await _launchOperation(() async {
      try {
        if (!UrlValidator.isValidEmail(email)) {
          return UrlLaunchResult.failure(UrlType.email, 'Invalid email address: $email');
        }

        final queryParams = <String, String>{};
        if (subject != null && subject.isNotEmpty) queryParams['subject'] = subject;
        if (body != null && body.isNotEmpty) queryParams['body'] = body;
        if (cc != null && cc.isNotEmpty) queryParams['cc'] = cc.join(',');
        if (bcc != null && bcc.isNotEmpty) queryParams['bcc'] = bcc.join(',');

        final uri = Uri(
          scheme: 'mailto',
          path: email,
          queryParameters: queryParams.isEmpty ? null : queryParams,
        );

        if (!await launcher.canLaunchUrl(uri)) {
          return UrlLaunchResult.failure(
            UrlType.email,
            'Cannot launch email client. Is an email app installed?',
          );
        }

        final launched = await launcher.launchUrl(uri);
        return launched
            ? UrlLaunchResult.success(UrlType.email)
            : UrlLaunchResult.failure(UrlType.email, 'Failed to launch email client.');
      } catch (e) {
        return UrlLaunchResult.failure(UrlType.email, 'Exception: ${e.toString()}');
      }
    });
  }

  /// Launch website URL
  Future<void> launchWebsite(String url, {LaunchMode mode = LaunchMode.externalApplication}) async {
    await _launchOperation(() async {
      try {
        String formattedUrl = url;
        if (!url.startsWith('http://') && !url.startsWith('https://')) {
          formattedUrl = 'https://$url';
        }
        final uri = Uri.parse(formattedUrl);
        if (!await launcher.canLaunchUrl(uri)) {
          return UrlLaunchResult.failure(UrlType.website, 'Cannot open website: $url');
        }
        final launched = await launcher.launchUrl(uri, mode: mode);
        return launched
            ? UrlLaunchResult.success(UrlType.website)
            : UrlLaunchResult.failure(UrlType.website, 'Failed to open website');
      } catch (e) {
        return UrlLaunchResult.failure(UrlType.website, 'Exception: ${e.toString()}');
      }
    });
  }

  /// Launch phone dialer
  Future<void> launchPhone(String phoneNumber) async {
    await _launchOperation(() async {
      try {
        if (!UrlValidator.isValidPhone(phoneNumber)) {
          return UrlLaunchResult.failure(UrlType.phone, 'Invalid phone number: $phoneNumber');
        }
        final uri = Uri.parse('tel:${phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '')}');
        if (!await launcher.canLaunchUrl(uri)) {
          return UrlLaunchResult.failure(UrlType.phone, 'Cannot launch phone dialer');
        }
        final launched = await launcher.launchUrl(uri);
        return launched
            ? UrlLaunchResult.success(UrlType.phone)
            : UrlLaunchResult.failure(UrlType.phone, 'Failed to launch phone dialer');
      } catch (e) {
        return UrlLaunchResult.failure(UrlType.phone, 'Exception: ${e.toString()}');
      }
    });
  }

  /// Launch WhatsApp chat
  Future<void> launchWhatsApp({required String phoneNumber, String? message}) async {
    await _launchOperation(() async {
      try {
        if (!UrlValidator.isValidWhatsAppNumber(phoneNumber)) {
          return UrlLaunchResult.failure(UrlType.whatsapp, 'Invalid WhatsApp number: $phoneNumber');
        }
        final cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
        String whatsappUrl = 'https://wa.me/$cleanNumber';
        if (message != null && message.isNotEmpty) {
          whatsappUrl += '?text=${Uri.encodeComponent(message)}';
        }
        final uri = Uri.parse(whatsappUrl);
        if (!await launcher.canLaunchUrl(uri)) {
          return UrlLaunchResult.failure(UrlType.whatsapp, 'WhatsApp is not installed or cannot be launched');
        }
        final launched = await launcher.launchUrl(uri, mode: LaunchMode.externalApplication);
        return launched
            ? UrlLaunchResult.success(UrlType.whatsapp)
            : UrlLaunchResult.failure(UrlType.whatsapp, 'Failed to launch WhatsApp');
      } catch (e) {
        return UrlLaunchResult.failure(UrlType.whatsapp, 'Exception: ${e.toString()}');
      }
    });
  }

  /// Launch SMS app
  Future<void> launchSMS({required String phoneNumber, String? message}) async {
    await _launchOperation(() async {
      try {
        if (!UrlValidator.isValidPhone(phoneNumber)) {
          return UrlLaunchResult.failure(UrlType.sms, 'Invalid phone number: $phoneNumber');
        }
        final cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s-()]'), '');
        String smsUrl = 'sms:$cleanNumber';
        if (message != null && message.isNotEmpty) {
          smsUrl += '?body=${Uri.encodeComponent(message)}';
        }
        final uri = Uri.parse(smsUrl);
        if (!await launcher.canLaunchUrl(uri)) {
          return UrlLaunchResult.failure(UrlType.sms, 'Cannot launch SMS app');
        }
        final launched = await launcher.launchUrl(uri);
        return launched
            ? UrlLaunchResult.success(UrlType.sms)
            : UrlLaunchResult.failure(UrlType.sms, 'Failed to launch SMS app');
      } catch (e) {
        return UrlLaunchResult.failure(UrlType.sms, 'Exception: ${e.toString()}');
      }
    });
  }

  /// Launch Telegram chat
  Future<void> launchTelegram({required String username, String? message}) async {
    await _launchOperation(() async {
      try {
        String telegramUrl = 'https://t.me/$username';
        if (message != null && message.isNotEmpty) {
          telegramUrl += '?text=${Uri.encodeComponent(message)}';
        }
        final uri = Uri.parse(telegramUrl);
        if (!await launcher.canLaunchUrl(uri)) {
          return UrlLaunchResult.failure(UrlType.telegram, 'Telegram is not installed or cannot be launched');
        }
        final launched = await launcher.launchUrl(uri, mode: LaunchMode.externalApplication);
        return launched
            ? UrlLaunchResult.success(UrlType.telegram)
            : UrlLaunchResult.failure(UrlType.telegram, 'Failed to launch Telegram');
      } catch (e) {
        return UrlLaunchResult.failure(UrlType.telegram, 'Exception: ${e.toString()}');
      }
    });
  }

  /// Launch Google Maps with location
  Future<void> launchMaps({double? latitude, double? longitude, String? address}) async {
    await _launchOperation(() async {
      try {
        String mapsUrl;
        if (latitude != null && longitude != null) {
          mapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
        } else if (address != null && address.isNotEmpty) {
          mapsUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';
        } else {
          return UrlLaunchResult.failure(UrlType.other, 'Either coordinates or address must be provided');
        }
        final uri = Uri.parse(mapsUrl);
        if (!await launcher.canLaunchUrl(uri)) {
          return UrlLaunchResult.failure(UrlType.other, 'Cannot launch Maps');
        }
        final launched = await launcher.launchUrl(uri, mode: LaunchMode.externalApplication);
        return launched
            ? UrlLaunchResult.success(UrlType.other)
            : UrlLaunchResult.failure(UrlType.other, 'Failed to launch Maps');
      } catch (e) {
        return UrlLaunchResult.failure(UrlType.other, 'Exception: ${e.toString()}');
      }
    });
  }
}
