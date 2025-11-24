import 'widgets/challenge_card.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import '../../../../data_layer/domain/entities/portfolio/project.dart';

class ChallengeSection extends StatelessWidget {
  final Project project;

  const ChallengeSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          _buildSectionHeading(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Challenge Cards in Wrap Layout
          _buildChallengeCards(context, s),
        ],
      ),
    );
  }

  /// Section Heading with Subtitle
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The Challenge', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text('Understanding the problem space', style: fonts.bodyLarge.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  /// Challenge Cards with Wrap Layout
  Widget _buildChallengeCards(BuildContext context, DSizes s) {
    final desktopCardWidth = context.isDesktop ? (1100 - (s.spaceBtwSections * 2)) / 3 : double.infinity;

    return Wrap(
      spacing: s.spaceBtwItems,
      runSpacing: s.spaceBtwItems,
      children: [
        // Card 1: Problem Statement
        SizedBox(
          width: context.isMobile ? double.infinity : desktopCardWidth,
          child: ChallengeCard(
            icon: Icons.lightbulb_outline_rounded,
            title: 'Problem Statement',
            content: project.challenge,
            iconColor: const Color(0xFFF59E0B),
          ),
        ),

        // Card 2: Client Requirements
        SizedBox(
          width: context.isMobile ? double.infinity : desktopCardWidth,
          child: ChallengeCard(
            icon: Icons.checklist_rounded,
            title: 'Client Requirements',
            content: project.requirements,
            iconColor: const Color(0xFF3B82F6),
          ),
        ),

        // Card 3: Constraints Faced
        SizedBox(
          width: context.isMobile ? double.infinity : desktopCardWidth,
          child: ChallengeCard(
            icon: Icons.construction_rounded,
            title: 'Constraints Faced',
            content: project.constraints,
            iconColor: const Color(0xFFEF4444),
          ),
        ),
      ],
    );
  }
}
