import '../../../../../data_layer/model/home/benefit_model.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/constants/image_string.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/responsive/responsive_helper.dart';
import 'widgets/benefit_card.dart';
import 'package:flutter/material.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_widget.dart';
import '../../../../../utility/responsive/section_container.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';

class WhyWorkWithMeSection extends StatelessWidget {
  const WhyWorkWithMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(top: s.spaceBtwSections, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: ResponsiveWidget(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      children: [
        _buildProfessionalImage(context),
        SizedBox(height: s.spaceBtwItems),
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwItems),
        _buildBenefitsList(context),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      children: [
        _buildProfessionalImage(context),
        SizedBox(height: s.spaceBtwItems),
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwItems),
        _buildBenefitsList(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      children: [
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwItems),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: _buildProfessionalImage(context)),
            SizedBox(width: s.spaceBtwItems),
            Expanded(flex: 3, child: _buildBenefitsList(context)),
          ],
        ),
      ],
    );
  }

  // Professional Image Section
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
              colors: [DColors.primaryButton.withAlpha(51), DColors.primaryButton.withAlpha(12), Colors.transparent],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
        ),

        // Professional Image
        Container(
          width: context.responsiveValue(mobile: 250, tablet: 320, desktop: 500),
          height: context.responsiveValue(mobile: 250, tablet: 320, desktop: 500),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: DColors.cardBorder, width: 3),
            boxShadow: [
              BoxShadow(color: DColors.primaryButton.withAlpha(51), blurRadius: 30, offset: const Offset(0, 10)),
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

        // Floating Badge
        Positioned(
          bottom: context.responsiveValue(mobile: 20, desktop: 40),
          right: context.responsiveValue(mobile: 20, desktop: 40),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: DColors.primaryButton,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: DColors.primaryButton.withAlpha(102), blurRadius: 15, offset: const Offset(0, 5)),
              ],
            ),
            child: Text(
              '2.6+ Years',
              style: context.fonts.labelLarge.rubik(color: DColors.textPrimary, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // Using DSectionHeader
  Widget _buildSectionHeader(BuildContext context) {
    return DSectionHeader(
      label: 'WHY WORK WITH ME?',
      title: 'Building Excellence in Every Line of Code',
      subtitle:
          'I deliver high-quality, scalable Flutter applications with clean architecture and best practices. Your success is my priority.',
      alignment: TextAlign.center,
      maxWidth: 1400,
    );
  }

  // Benefits List Section
  Widget _buildBenefitsList(BuildContext context) {
    final benefits = BenefitModel.getBenefitsData();
    return Column(
      children: List.generate(benefits.length, (index) => BenefitCard(benefit: benefits[index], index: index)),
    );
  }
}
