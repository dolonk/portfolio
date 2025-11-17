import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/about/about_stats_model.dart';
import 'package:responsive_website/data_layer/model/about/social_link_model.dart';
import 'widgets/stats_card.dart';
import 'widgets/social_link_button.dart';

class AboutHeroSection extends StatelessWidget {
  const AboutHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Column(
        children: [
          // Profile Photo
          _buildProfilePhoto(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Name & Title
          _buildNameAndTitle(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Tagline
          _buildTagline(context, s),
          SizedBox(height: s.spaceBtwSections),

          // Stats Cards
          _buildStatsCards(context, s),
          SizedBox(height: s.spaceBtwSections),

          // CTA Buttons
          _buildCTAButtons(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Social Links
          _buildSocialLinks(context, s),
        ],
      ),
    );
  }

  /// Profile Photo with Gradient Border
  Widget _buildProfilePhoto(BuildContext context, DSizes s) {
    final photoSize = context.responsiveValue(mobile: 140.0, tablet: 160.0, desktop: 180.0);

    return Container(
      width: photoSize + 10,
      height: photoSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8B5CF6), // Purple
            Color(0xFF3B82F6), // Blue
            Color(0xFF10B981), // Green
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(shape: BoxShape.circle, color: DColors.background),
        child: ClipOval(
          child: Image.asset(
            'assets/home/hero_section/dk.png',
            width: photoSize,
            height: photoSize,
            errorBuilder: (context, error, stackTrace) => Container(
              width: photoSize,
              height: photoSize,
              color: DColors.cardBackground,
              child: Icon(Icons.person_rounded, size: photoSize * 0.6, color: DColors.primaryButton),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8), duration: 800.ms);
  }

  /// Name and Title
  Widget _buildNameAndTitle(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        // Name with Wave Emoji
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFF8B5CF6), // Purple
              Color(0xFF3B82F6), // Blue
            ],
          ).createShader(bounds),
          child: Text(
            'Hi, I\'m Dolon Kumar 👋',
            style: fonts.displaySmall.rajdhani(
              fontSize: context.responsiveValue(mobile: 32, tablet: 40, desktop: 48),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: s.paddingSm),

        // Title
        Text(
          'Flutter Developer | Cross-Platform Expert',
          style: fonts.headlineSmall.rajdhani(
            fontSize: context.responsiveValue(mobile: 18, tablet: 20, desktop: 22),
            fontWeight: FontWeight.w600,
            color: DColors.primaryButton,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, duration: 600.ms, delay: 200.ms);
  }

  /// Tagline
  Widget _buildTagline(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
      ),
      child: Text(
        'Building efficient, scalable, and innovative applications that drive user engagement and satisfaction',
        style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
        textAlign: TextAlign.center,
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.1, duration: 600.ms, delay: 400.ms);
  }

  /// Stats Cards
  Widget _buildStatsCards(BuildContext context, DSizes s) {
    final stats = AboutStatsModel.getAllStats();

    return Wrap(
      spacing: s.paddingMd,
      runSpacing: s.paddingMd,
      alignment: WrapAlignment.center,
      children: stats.map((stat) {
        return SizedBox(
          width: context.responsiveValue(
            mobile: (MediaQuery.of(context).size.width - s.paddingMd * 5) / 2,
            tablet: 160.0,
            desktop: 180.0,
          ),
          child: StatsCard(stat: stat),
        );
      }).toList(),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.1, duration: 600.ms, delay: 600.ms);
  }

  /// CTA Buttons
  Widget _buildCTAButtons(BuildContext context, DSizes s) {
    return Wrap(
      spacing: s.paddingMd,
      runSpacing: s.paddingMd,
      alignment: WrapAlignment.center,
      children: [
        // Download CV Button
        _buildPrimaryButton(
          context: context,
          label: 'Download CV',
          icon: Icons.download_rounded,
          onPressed: () {
            // TODO: Add CV download functionality
            debugPrint('Download CV pressed');
          },
        ),

        // Let's Connect Button
        _buildSecondaryButton(
          context: context,
          label: 'Let\'s Connect',
          icon: Icons.chat_rounded,
          onPressed: () {
            // TODO: Navigate to Contact page
            debugPrint('Let\'s Connect pressed');
          },
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.1, duration: 600.ms, delay: 800.ms);
  }

  /// Primary Button
  Widget _buildPrimaryButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final s = context.sizes;
    final fonts = context.fonts;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: DColors.primaryButton,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl),
          vertical: s.paddingMd,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusSm)),
        textStyle: fonts.bodyLarge.rubik(fontWeight: FontWeight.w600),
        elevation: 4,
      ),
    );
  }

  /// Secondary Button
  Widget _buildSecondaryButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final s = context.sizes;
    final fonts = context.fonts;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: DColors.primaryButton,
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl),
          vertical: s.paddingMd,
        ),
        side: BorderSide(color: DColors.primaryButton, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusSm)),
        textStyle: fonts.bodyLarge.rubik(fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Social Links
  Widget _buildSocialLinks(BuildContext context, DSizes s) {
    final socialLinks = _getSocialLinks();

    return Wrap(
      spacing: s.paddingMd,
      runSpacing: s.paddingMd,
      alignment: WrapAlignment.center,
      children: socialLinks.map((social) {
        return SocialLinkButton(social: social);
      }).toList(),
    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.1, duration: 600.ms, delay: 1000.ms);
  }

  /// Get Social Links
  List<SocialLinkModel> _getSocialLinks() {
    return [
      SocialLinkModel(
        platform: 'GitHub',
        url: 'https://github.com/dolon-kumar',
        icon: FontAwesomeIcons.github,
        color: const Color(0xFF181717),
      ),
      SocialLinkModel(
        platform: 'LinkedIn',
        url: 'https://www.linkedin.com/in/dolon-kumar',
        icon: FontAwesomeIcons.linkedin,
        color: const Color(0xFF0A66C2),
      ),
      SocialLinkModel(
        platform: 'App Store',
        url: 'https://apps.apple.com',
        icon: FontAwesomeIcons.appStore,
        color: const Color(0xFF0D96F6),
      ),
      SocialLinkModel(
        platform: 'Play Store',
        url: 'https://play.google.com',
        icon: FontAwesomeIcons.googlePlay,
        color: const Color(0xFF34A853),
      ),
    ];
  }
}
