import 'package:flutter/material.dart';
import '../../../utility/default_sizes/default_sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/responsive_widget.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    return SectionContainer(
      backgroundColor: const Color(0xFF1D1D1D),
      padding: EdgeInsets.all(s.paddingMd),
      child: ResponsiveWidget(
        /// Mobile Layout
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogoAndTagline(context),
            SizedBox(height: s.defaultSpace),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: _buildQuickLinks(context)),
                  Expanded(flex: 2, child: _buildContactInfo(context)),
                ],
              ),
            ),
            SizedBox(height: 20),
            const Divider(color: Colors.white10, thickness: 1, height: 1),
            SizedBox(height: 20),
            _buildBottomBar(context),
          ],
        ),

        /// Desktop Layout
        desktop: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildLogoAndTagline(context)),
                Expanded(flex: 1, child: _buildQuickLinks(context)),
                Expanded(flex: 1, child: _buildContactInfo(context)),
              ],
            ),
            SizedBox(height: 40),
            const Divider(color: Colors.white10, thickness: 1, height: 1),
            SizedBox(height: 20),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  // --- 1. Logo and Tagline Widget ---
  Widget _buildLogoAndTagline(BuildContext context) {
    final font = context.fonts;
    return Column(
      crossAxisAlignment: context.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text('LOGO', style: font.titleLarge),
        SizedBox(height: context.sizes.spaceBtwItems),

        context.isMobile
            ? Text('Get Ready To Create Great', style: font.bodyMedium)
            : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Get Ready', style: font.displayLarge),
                    TextSpan(
                      text: ' To Create\n',
                      style: font.displayLarge.rajdhani(fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: 'Great',
                      style: font.displayLarge.rajdhani(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  // --- 2. Quick Links Widget ---
  Widget _buildQuickLinks(BuildContext context) {
    const List<String> links = ['Home', 'Project', 'Blog', 'About'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Link', style: context.fonts.headlineMedium),
        const SizedBox(height: 20),

        // List of links
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: GestureDetector(
              onTap: () {},
              child: Text(link, style: context.fonts.labelMedium),
            ),
          ),
        ),
      ],
    );
  }

  // --- 3. Contact Info Widget ---
  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact', style: context.fonts.headlineMedium),
        const SizedBox(height: 20),
        Text('+880 12345 6479', style: context.fonts.labelMedium),
        const SizedBox(height: 10),
        Text('Email@gmail.com', style: context.fonts.labelMedium),
        const SizedBox(height: 10),
        Text(
          'Nilphamari sadar, Nilphamari, Rangpur\nDhaka, Bangladesh-5300',
          style: context.fonts.labelMedium,
        ),
        const SizedBox(height: 20),
        // Social Media Icons
        Row(
          children: [
            _buildSocialIcon(context, FontAwesomeIcons.linkedin),
            _buildSocialIcon(context, FontAwesomeIcons.github),
            _buildSocialIcon(context, FontAwesomeIcons.whatsapp),
            _buildSocialIcon(context, FontAwesomeIcons.instagram),
          ],
        ),
      ],
    );
  }

  // Helper method for social icons
  Widget _buildSocialIcon(BuildContext context, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: context.sizes.paddingMd),
      child: GestureDetector(
        onTap: () {},
        child: Icon(icon, color: Colors.white70, size: context.sizes.iconSm),
      ),
    );
  }

  // --- 4. Bottom Bar Widget ---
  Widget _buildBottomBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('© 2025 LocationIQ', style: context.fonts.labelMedium),
        _buildBottomLink(context, 'Privacy policy'),
        _buildBottomLink(context, 'Terms & Conditions'),
      ],
    );
  }

  // Helper method for bottom links
  Widget _buildBottomLink(BuildContext context, String title) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Text(title, style: context.fonts.labelMedium),
      ),
    );
  }
}
