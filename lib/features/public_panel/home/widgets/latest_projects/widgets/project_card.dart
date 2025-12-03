import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route/route_name.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import '../../../../../../common_function/widgets/animated_custom_button.dart';
import '../../../../../../common_function/widgets/hoverable_card.dart';
import '../../../../../../data_layer/domain/entities/portfolio/project.dart';
import '../../../../../../utility/constants/colors.dart';

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

    return HoverableCard(
      padding: const EdgeInsets.all(8),
      onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(s.borderRadiusMd - 2),
                topRight: Radius.circular(s.borderRadiusMd - 2),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                        widget.project.imagePath,
                        fit: BoxFit.cover,
                        cacheHeight: 400,
                        cacheWidth: 400,
                        filterQuality: FilterQuality.medium,
                      )
                      .animate(target: _isHovered ? 1 : 0)
                      .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), curve: Curves.easeInOut),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, DColors.primaryButton.withAlpha((255 * 0.6).round())],
                      ),
                    ),
                  ).animate(target: _isHovered ? 1 : 0).fade(begin: 0.0, end: 1.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Project Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.project.title,
              style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),

          // Project Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    widget.project.description,
                    style: fonts.labelMedium.rubik(color: DColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),

                // View Button
                AnimatedCustomButton(
                  onPressed: () => context.go('${RouteNames.portfolio}/${widget.project.id}'),
                  text: 'View',
                  icon: const Icon(Icons.arrow_forward_rounded, color: DColors.textSecondary, size: 18),
                  width: null,
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  borderWidth: 1.5,
                  iconSlideDistance: 0.6,
                  textColor: DColors.textPrimary,
                  hoverTextColor: DColors.textPrimary,
                  hoverIconColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
