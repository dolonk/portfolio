import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;

class CalendlyWidget extends StatefulWidget {
  final String calendlyUrl;
  final double height;

  const CalendlyWidget({super.key, required this.calendlyUrl, this.height = 700});

  @override
  State<CalendlyWidget> createState() => _CalendlyWidgetState();
}

class _CalendlyWidgetState extends State<CalendlyWidget> {
  final String _viewType = 'calendly-iframe-${DateTime.now().millisecondsSinceEpoch}';

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Register view factory for web
      ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
        final iframe = web.HTMLIFrameElement()
          ..src = widget.calendlyUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '${widget.height}px'
          ..allow = 'camera; microphone; autoplay; encrypted-media;';

        return iframe;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    if (kIsWeb) {
      // Web: Show embedded iframe
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(s.borderRadiusLg),
          border: Border.all(color: DColors.cardBorder, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha((255 * 0.08).round()), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: context.responsiveValue(mobile: 600, tablet: 650, desktop: widget.height),
          child: HtmlElementView(viewType: _viewType),
        ),
      );
    } else {
      // Non-web platforms: Show button to open in browser
      return _buildFallbackButton(context, s);
    }
  }

  /// Fallback button for non-web platforms
  Widget _buildFallbackButton(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingLg * 2),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_rounded, size: 64, color: DColors.primaryButton),
          SizedBox(height: s.spaceBtwItems),
          Text(
            'Schedule Your Consultation',
            style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.paddingMd),
          Text(
            'Click the button below to open the scheduling page',
            style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),
          ElevatedButton.icon(
            onPressed: () => _openCalendlyInBrowser(),
            icon: const Icon(Icons.open_in_new_rounded),
            label: Text('Open Calendar', style: fonts.bodyLarge.rubik(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: DColors.primaryButton,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusSm)),
            ),
          ),
        ],
      ),
    );
  }

  /// Open Calendly in external browser
  Future<void> _openCalendlyInBrowser() async {
    final Uri url = Uri.parse(widget.calendlyUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch Calendly URL: ${widget.calendlyUrl}');
    }
  }
}
