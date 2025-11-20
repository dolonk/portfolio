import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

import '../../../../../utility/url_launcher_service/url_launcher_service.dart';
import 'dialog_option_button.dart';

class PhoneOptionsModal extends StatelessWidget {
  final String phoneNumber;

  const PhoneOptionsModal({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final urlLauncher = UrlLauncherService();

    return Dialog(
      backgroundColor: Colors.transparent,
      child:
          Container(
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  color: DColors.cardBackground,
                  borderRadius: BorderRadius.circular(s.borderRadiusLg),
                  border: Border.all(color: DColors.cardBorder, width: 2),
                ),
                padding: EdgeInsets.all(s.paddingLg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose Contact Method',
                          style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded),
                          color: DColors.textSecondary,
                        ),
                      ],
                    ),
                    SizedBox(height: s.spaceBtwItems),

                    // Call Button
                    DialogOptionButton(
                      icon: Icons.phone_rounded,
                      label: 'Call Directly',
                      color: const Color(0xFF3B82F6),
                      onTap: () {
                        urlLauncher.launchPhone(phoneNumber);
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: s.paddingMd),

                    // WhatsApp Button
                    DialogOptionButton(
                      icon: FontAwesomeIcons.whatsapp,
                      label: 'WhatsApp',
                      color: const Color(0xFF25D366),
                      onTap: () {
                        urlLauncher.launchWhatsApp(phoneNumber: phoneNumber);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )
              .animate()
              .scale(begin: const Offset(0.8, 0.8), duration: 300.ms, curve: Curves.easeOutBack)
              .fadeIn(duration: 300.ms),
    );
  }
}
