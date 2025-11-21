import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import '../../../../../utility/url_launcher_service/url_launcher_service.dart';
import 'dialog_option_button.dart';

class ChatOptionsModal extends StatelessWidget {
  const ChatOptionsModal({super.key});

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
                          'Choose Chat Platform',
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

                    // WhatsApp Button
                    DialogOptionButton(
                      icon: FontAwesomeIcons.whatsapp,
                      label: 'WhatsApp',
                      color: const Color(0xFF25D366),
                      onTap: () {
                        urlLauncher.launchWhatsApp(phoneNumber: '+8801944893253');
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: s.paddingMd),

                    // Telegram Button
                    DialogOptionButton(
                      icon: FontAwesomeIcons.telegram,
                      label: 'Telegram',
                      color: const Color(0xFF0088CC),
                      onTap: () {
                        urlLauncher.launchTelegram(username: '@DolonTr4');
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
