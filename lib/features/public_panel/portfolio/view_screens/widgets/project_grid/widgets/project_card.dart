import 'tech_badge.dart';
import 'platform_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../route/route_name.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/common_function/widgets/custom_button.dart';
import 'package:portfolio/data_layer/domain/entities/portfolio/project.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  // Background Image
                  _buildProjectImage(),

                  // Gradient Overlay (darker on hover)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _isHovered
                            ? [Colors.black.withAlpha((255 * 0.7).round()), Colors.black.withAlpha((255 * 0.9).round())]
                            : [
                                Colors.black.withAlpha((255 * 0.3).round()),
                                Colors.black.withAlpha((255 * 0.7).round()),
                              ],
                      ),
                    ),
                  ),

                  // Content (slides up on hover)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    bottom: _isHovered ? s.paddingLg : s.paddingMd,
                    left: s.paddingLg,
                    right: s.paddingLg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Project Title
                        Text(
                          widget.project.title,
                          style: fonts.headlineSmall.rajdhani(color: Colors.white, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: s.paddingSm),

                        // Tagline (visible on hover)
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isHovered ? 1.0 : 0.0,
                          child: Text(
                            widget.project.tagline,
                            style: fonts.bodySmall.rubik(
                              color: Colors.white.withAlpha((255 * 0.9).round()),
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: s.paddingMd),

                        // Platform Badges
                        if (widget.project.platforms.isNotEmpty)
                          Wrap(
                            spacing: s.paddingSm,
                            runSpacing: s.paddingSm,
                            children: widget.project.platforms
                                .map((platform) => PlatformBadge(platform: platform))
                                .toList(),
                          ),

                        // Tech Stack Badges (visible on hover)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: _isHovered ? null : 0,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: _isHovered ? 1.0 : 0.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: s.paddingMd),
                                Wrap(
                                  spacing: s.paddingSm,
                                  runSpacing: s.paddingSm,
                                  children: widget.project.techStack.map((tech) => TechBadge(techName: tech)).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: s.paddingMd),

                        // View Case Study Button (visible on hover)
                        _isHovered
                            ? CustomButton(
                                width: double.infinity,
                                tittleText: 'View Case Study',
                                onPressed: () {
                                  context.go('${RouteNames.portfolio}/${widget.project.id}');
                                },
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Project Background Image
  Widget _buildProjectImage() {
    return Positioned.fill(
      child: Image.asset(
        widget.project.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: DColors.cardBackground,
            child: Center(child: Icon(Icons.image_rounded, size: 64, color: DColors.textSecondary)),
          );
        },
      ),
    );
  }
}
