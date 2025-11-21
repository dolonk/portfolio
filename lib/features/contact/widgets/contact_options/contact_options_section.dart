import 'package:flutter/material.dart';
import 'widgets/chat_options_modal.dart';
import 'widgets/phone_options_modal.dart';
import 'widgets/contact_option_card.dart';
import '../../../../common_function/widgets/section_header.dart';
import '../../../../data_layer/model/contact/contact_info_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../utility/url_launcher_service/url_launcher_service.dart';

class ContactOptionsSection extends StatelessWidget {
  const ContactOptionsSection({super.key, required this.onScrollToForm});
  final VoidCallback onScrollToForm;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        children: [
          // Section Heading
          DSectionHeader(
            label: 'GET IN TOUCH',
            title: 'Choose Your Preferred Way to Connect',
            subtitle: 'Select the method that works best for you. I\'m here to help bring your ideas to life!',
            alignment: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Contact Options Cards Grid
          _buildContactOptionsGrid(context, s),
        ],
      ),
    );
  }

  /// Contact Options Cards Grid
  Widget _buildContactOptionsGrid(BuildContext context, DSizes s) {
    final options = _getContactOptions(context);
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 3, desktop: 3);
    final spacing = s.spaceBtwItems;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = context.isMobile
            ? double.infinity
            : (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return AnimationLimiter(
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            alignment: WrapAlignment.center,
            children: List.generate(options.length, (index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: crossAxisCount,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: SizedBox(
                      width: context.isMobile ? double.infinity : cardWidth,
                      height: context.responsiveValue(mobile: 280, tablet: 300, desktop: 320),
                      child: ContactOptionCard(option: options[index]),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  /// Get Contact Options Data
  List<ContactInfoModel> _getContactOptions(BuildContext context) {
    final urlLauncher = UrlLauncherService();
    return [
      // Quick Message (Scroll to form)
      ContactInfoModel(
        title: 'Quick Message',
        description: 'Send me a message directly through the contact form',
        icon: Icons.email_rounded,
        actionText: 'Form below',
        accentColor: const Color(0xFF8B5CF6), // Purple
        onTap: onScrollToForm,
      ),

      // Instant Chat (Show modal)
      ContactInfoModel(
        title: 'Instant Chat',
        description: 'Connect with me instantly via WhatsApp or Telegram',
        icon: Icons.chat_bubble_rounded,
        actionText: 'Start chat',
        accentColor: const Color(0xFF10B981),
        onTap: () {
          showDialog(context: context, builder: (context) => const ChatOptionsModal());
        },
      ),

      // Email Address (Launch email app)
      ContactInfoModel(
        title: 'Email Address',
        value: 'dolonk9@gmail.com',
        description: 'For general inquiries',
        icon: Icons.email_rounded,
        accentColor: const Color(0xFF8B5CF6),
        actionText: 'Send Email',
        onTap: () {
          urlLauncher.launchEmail(
            email: "dolonk9@gmail.com",
            subject: 'Inquiry from your Portfolio Website',
            body: 'Hello, I would like to discuss...',
          );
        },
      ),

      // Phone/WhatsApp
      ContactInfoModel(
        title: 'Phone/WhatsApp',
        value: '8801944893253',
        description: 'Available 9 AM - 6 PM (GMT+6)',
        icon: Icons.phone_rounded,
        accentColor: const Color(0xFF3B82F6),
        actionText: 'Call Now',
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => PhoneOptionsModal(phoneNumber: '+8801944893253'),
          );
        },
      ),

      // Location
      ContactInfoModel(
        title: 'Location',
        value: 'Dhaka, Bangladesh',
        description: 'Available for remote work globally',
        icon: Icons.location_on_rounded,
        accentColor: const Color(0xFF10B981),
        actionText: 'View Map',
        onTap: null,
      ),
    ];
  }
}
