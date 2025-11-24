import 'package:flutter/material.dart';
import 'widgets/features/features_section.dart';
import 'widgets/gallery/gallery_section.dart';
import 'widgets/results/results_section.dart';
import 'widgets/solution/solution_section.dart';
import 'widgets/challenge/challenge_section.dart';
import 'widgets/hero/project_hero_section.dart';
import 'widgets/demo_links/demo_links_section.dart';
import 'widgets/overview/project_overview_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import '../../utility/responsive/responsive_helper.dart';
import '../portfolio/view_models/project_view_model.dart';
import '../../common_function/state_widgets/state_builder.dart';
import '../../data_layer/domain/entities/portfolio/project.dart';
import '../../common_function/state_widgets/error/error_state.dart';
import '../../common_function/state_widgets/loading/blog_page.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';
import '../../common_function/state_widgets/data_not_found/not_found_state.dart';
import 'package:portfolio/features/project_detail/widgets/cta/cta_section.dart';
import 'package:portfolio/features/project_detail/widgets/tech_stack/tech_stack_section.dart';
import 'package:portfolio/features/project_detail/widgets/related_projects/related_projects_section.dart';

class ProjectDetailPage extends StatefulWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late final ProjectViewModel vm = ProjectViewModel(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.fetchProjectById(widget.projectId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: DColors.secondaryBackground,
      child: DStateBuilder<Project>(
        state: vm.detailState,
        onLoading: () => BlogPageLoading(),
        onError: (message) =>
            ErrorState(message: message, onRetry: () => vm.fetchProjectById(widget.projectId)),
        onEmpty: () => const DataNotFoundState(),
        onSuccess: (project) => Column(
          children: [
            // Hero Image
            ProjectHeroSection(project: project),

            Container(
              constraints: BoxConstraints(
                maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 800, desktop: 1600),
              ),
              child: Center(
                child: Column(
                  children: [
                    // Project Overview
                    ProjectOverviewSection(project: project),

                    // The Challenge (if available)
                    if (project.challenge.isNotEmpty) ChallengeSection(project: project),

                    // The Solution (if available)
                    if (project.solution.isNotEmpty) SolutionSection(project: project),

                    // Tech Stack Used
                    if (project.techStack.isNotEmpty) TechStackSection(project: project),

                    // Key Features (if available)
                    if (project.keyFeatures.isNotEmpty) FeaturesSection(project: project),

                    // Results & Impact (if available)
                    if (project.results.isNotEmpty) ResultsSection(project: project),

                    // Image Gallery (if available)
                    if (project.galleryImages.isNotEmpty)
                      GallerySection(imagesGallery: project.galleryImages),

                    // Demo & Links (if any link available)
                    if (_hasAnyLink(project)) DemoLinksSection(project: project),

                    // Related Projects
                    RelatedProjectsSection(project: project),
                  ],
                ),
              ),
            ),

            // CTA
            const CtaSection(),
          ],
        ),
      ),
    );
  }

  /// Check if project has any external links
  bool _hasAnyLink(Project project) {
    return project.liveUrl != null ||
        project.appStoreUrl != null ||
        project.playStoreUrl != null ||
        project.githubUrl.isNotEmpty ||
        project.demoVideoUrl.isNotEmpty;
  }
}
