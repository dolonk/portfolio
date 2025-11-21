import 'package:flutter/material.dart';
import '../../utility/responsive/responsive_helper.dart';
import 'widgets/features/features_section.dart';
import 'widgets/gallery/gallery_section.dart';
import 'widgets/results/results_section.dart';
import 'widgets/solution/solution_section.dart';
import 'widgets/challenge/challenge_section.dart';
import 'widgets/hero/project_hero_section.dart';
import '../../data_layer/model/portfolio/project_model.dart';
import 'widgets/demo_links/demo_links_section.dart';
import 'widgets/overview/project_overview_section.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/common_function/base_screen/base_screen.dart';
import 'package:portfolio/features/project_detail/widgets/cta/cta_section.dart';
import 'package:portfolio/features/project_detail/widgets/tech_stack/tech_stack_section.dart';
import 'package:portfolio/features/project_detail/widgets/related_projects/related_projects_section.dart';

class ProjectDetailPage extends StatelessWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final project = ProjectModel.getSampleProject(projectId);

    return BaseScreen(
      backgroundColor: DColors.secondaryBackground,
      child: Column(
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

                  // The Challenge
                  ChallengeSection(project: project),

                  // The Solution
                  SolutionSection(project: project),

                  // Tech Stack Used
                  TechStackSection(project: project),

                  // Key Features
                  FeaturesSection(project: project),

                  // Results & Impact
                  ResultsSection(project: project),

                  // Image Gallery
                  GallerySection(imagesGallery: project.galleryImages),

                  // Demo & Links
                  DemoLinksSection(project: project),

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
    );
  }
}
