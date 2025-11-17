import 'widgets/timeline_step.dart';
import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/data_layer/model/portfolio/project_model.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class SolutionSection extends StatelessWidget {
  final ProjectModel project;

  const SolutionSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Heading
            _buildSectionHeading(context, s),
            SizedBox(height: s.spaceBtwItems),

            // Timeline Steps
            Padding(
              padding: EdgeInsets.only(left: s.spaceBtwSections),
              child: _buildTimelineSteps(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Heading with Subtitle
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The Solution', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text('How we solved the challenge', style: fonts.bodyMedium.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  /// Timeline Steps
  Widget _buildTimelineSteps(BuildContext context) {
    return Column(
      spacing: context.sizes.spaceBtwItems,
      children: [
        // Step 1: Your Approach
        TimelineStep(
          stepNumber: 1,
          icon: Icons.explore_rounded,
          title: 'Your Approach',
          description: project.solution,
          highlights: [
            'Clean architecture principles',
            'Modular component design',
            'Test-driven development',
            'Continuous integration pipeline',
          ],
          isLast: false,
          stepColor: const Color(0xFF8B5CF6),
        ),

        // Step 2: Architecture Decisions
        TimelineStep(
          stepNumber: 2,
          icon: Icons.psychology_rounded,
          title: 'Architecture Decisions',
          description:
              'We implemented a clean MVVM architecture pattern to ensure separation of concerns and maintainability. The codebase is organized into clear layers: presentation, domain, and data. This structure allows for easy testing, scalability, and team collaboration. Each layer has well-defined responsibilities and communicates through abstractions.',
          highlights: [
            'MVVM pattern for clean separation',
            'Repository pattern for data management',
            'Dependency injection for flexibility',
            'Clear layer boundaries',
          ],
          isLast: false,
          stepColor: const Color(0xFF3B82F6),
        ),

        // Step 3: State Management Choice
        TimelineStep(
          stepNumber: 3,
          icon: Icons.settings_suggest_rounded,
          title: 'State Management Choice',
          description:
              'BLoC (Business Logic Component) was chosen for state management due to its predictability and testability. It provides a clear separation between business logic and UI, making the codebase more maintainable. The reactive streams approach ensures efficient state updates and handles complex async operations gracefully.',
          highlights: [
            'BLoC for predictable state flow',
            'Stream-based reactive updates',
            'Easy testing and debugging',
            'Separation of concerns',
          ],
          isLast: false,
          stepColor: const Color(0xFF10B981),
        ),

        // Step 4: Why This Tech Stack
        TimelineStep(
          stepNumber: 4,
          icon: Icons.code_rounded,
          title: 'Why This Tech Stack',
          description:
              'Flutter was selected for cross-platform development efficiency, Firebase for real-time capabilities and scalability, and Stripe for secure payment processing. This tech stack combination provides optimal performance, reduces development time, and ensures a native-like experience on both iOS and Android platforms while maintaining a single codebase.',
          highlights: [
            'Flutter for cross-platform efficiency',
            'Firebase for real-time sync',
            'Stripe for secure payments',
            'Native performance achieved',
          ],
          isLast: true,
          stepColor: const Color(0xFFF59E0B),
        ),
      ],
    );
  }
}
