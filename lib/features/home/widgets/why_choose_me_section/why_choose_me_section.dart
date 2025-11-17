import 'package:responsive_website/common_function/style/section_header.dart';

import 'widgets/benefit_card.dart';
import 'package:flutter/material.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/constants/image_string.dart';
import '../../../../data_layer/model/home/benefit_model.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';
import '../../../../utility/responsive/responsive_helper.dart';
import '../../../../utility/responsive/responsive_widget.dart';
import '../../../../utility/responsive/section_container.dart';

class WhyChooseMeSection extends StatelessWidget {
  const WhyChooseMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.only(top: s.spaceBtwSections),
      child: ResponsiveWidget(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  // 📱 Mobile Layout - Vertical Stack
  Widget _buildMobileLayout(BuildContext context) {
    final s = context.sizes;

    return Column(
      children: [
        // Professional Image
        _buildProfessionalImage(context),
        SizedBox(height: s.spaceBtwItems),

        // Section Header
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwItems),

        // Benefits List
        _buildBenefitsList(context),
      ],
    );
  }

  // 📱 Tablet Layout - Similar to Mobile
  Widget _buildTabletLayout(BuildContext context) {
    final s = context.sizes;

    return Column(
      children: [
        // Professional Image
        _buildProfessionalImage(context),
        SizedBox(height: s.spaceBtwItems),

        // Section Header
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwItems),

        // Benefits List
        _buildBenefitsList(context),
      ],
    );
  }

  // 💻 Desktop Layout - Side by Side
  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;

    return Column(
      children: [
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwItems),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side with Image
            Expanded(flex: 2, child: _buildProfessionalImage(context)),
            SizedBox(width: s.spaceBtwItems),
            //benefit section
            Expanded(flex: 3, child: _buildBenefitsList(context)),
          ],
        ),
      ],
    );
  }

  // 🖼️ Professional Image Section
  Widget _buildProfessionalImage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Gradient Circle
        Container(
          width: context.responsiveValue(mobile: 280, tablet: 350, desktop: 600),
          height: context.responsiveValue(mobile: 280, tablet: 350, desktop: 600),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                DColors.primaryButton.withAlpha((255 * 0.2).round()),
                DColors.primaryButton.withAlpha((255 * 0.05).round()),
                Colors.transparent,
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
        ),

        // Professional Image/Illustration
        Container(
          width: context.responsiveValue(mobile: 250, tablet: 320, desktop: 500),
          height: context.responsiveValue(mobile: 250, tablet: 320, desktop: 500),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: DColors.cardBorder, width: 3),
            boxShadow: [
              BoxShadow(
                color: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              DImages.profileImage,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: DColors.cardBackground,
                  child: Icon(Icons.person_outline_rounded, size: 100, color: DColors.textSecondary),
                );
              },
            ),
          ),
        ),

        // Floating Badge (Optional - "2.6+ Years")
        Positioned(
          bottom: context.responsiveValue(mobile: 20, desktop: 40),
          right: context.responsiveValue(mobile: 20, desktop: 40),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: DColors.primaryButton,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: DColors.primaryButton.withAlpha((255 * 0.4).round()),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              '3+ Years',
              style: context.fonts.labelLarge.rubik(color: DColors.textPrimary, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // 📝 Section Header
  Widget _buildSectionHeader(BuildContext context) {
    return SectionHeader(
      subtitle: 'Why Work With Me?',
      title: 'Building Excellence in Every Line of Code',
      description:
          'I deliver high-quality, scalable Flutter applications with clean architecture and best practices. Your success is my priority.',
    );
  }

  // 📋 Benefits List
  Widget _buildBenefitsList(BuildContext context) {
    final benefits = _getBenefitsData();

    return Column(
      children: List.generate(
        benefits.length,
        (index) => BenefitCard(benefit: benefits[index], index: index),
      ),
    );
  }

  // 📊 Benefits Data
  List<BenefitModel> _getBenefitsData() {
    return [
      BenefitModel(
        title: 'Production-Ready Code',
        description:
            'Every project follows MVVM architecture, clean code principles, and industry best practices for long-term maintainability.',
        icon: Icons.code_rounded,
      ),
      BenefitModel(
        title: 'Cross-Platform Expertise',
        description:
            'Master of Flutter across iOS, Android, Web, Windows, macOS, and Linux - one codebase, all platforms.',
        icon: Icons.devices_rounded,
      ),
      BenefitModel(
        title: 'Clean Architecture & Testing',
        description:
            'Structured code with proper separation of concerns, dependency injection, and comprehensive unit/widget testing.',
        icon: Icons.architecture_rounded,
      ),
      BenefitModel(
        title: 'On-Time Delivery Guarantee',
        description:
            'Milestone-based development with transparent communication. 95% of portfolio delivered on or before deadline.',
        icon: Icons.schedule_rounded,
      ),
      BenefitModel(
        title: 'Post-Launch Support',
        description:
            'Every project includes support period. Bug fixes, updates, and guidance even after deployment.',
        icon: Icons.support_agent_rounded,
      ),
    ];
  }
}
