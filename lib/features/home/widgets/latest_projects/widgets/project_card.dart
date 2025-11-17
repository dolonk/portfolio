import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../data_layer/model/portfolio/project_model.dart';
import '../../../../../common_function/style/hoverable_card.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  late AnimationController _animationController;
  late Animation<double> _buttonSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for button
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    // Button arrow slide animation
    _buttonSlideAnimation = Tween<double>(
      begin: 0.0,
      end: 4.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Handle button hover
  void _onButtonHover(bool isHovered) {
    setState(() {
      _isButtonHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

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
          // PROJECT IMAGE WITH ZOOM & OVERLAY
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
                  // Image with zoom animation
                  AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    scale: _isHovered ? 1.1 : 1.0,
                    child: Image.asset(
                      widget.project.imagePath,
                      fit: BoxFit.cover,
                      cacheHeight: 400,
                      cacheWidth: 400,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),

                  // Gradient overlay on hover
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, DColors.primaryButton.withAlpha((255 * 0.6).round())],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // PROJECT TITLE
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

          // 📄 DESCRIPTION & ACTION BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Description text
                Expanded(
                  child: Text(
                    widget.project.description,
                    style: fonts.labelMedium.rubik(color: DColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),

                // View Details Button
                _buildViewDetailsButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // VIEW DETAILS BUTTON
  Widget _buildViewDetailsButton(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => _onButtonHover(true),
      onExit: (_) => _onButtonHover(false),
      child: GestureDetector(
        onTap: () {
          context.go('/portfolio');
          debugPrint('View project: ${widget.project.title}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: _isButtonHovered ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: _isButtonHovered ? DColors.primaryButton : DColors.cardBorder, width: 1.5),
            boxShadow: _isButtonHovered
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // "View" text - always visible
              Text('View', style: fonts.labelLarge.rubik(color: DColors.textPrimary)),

              // Animated arrow icon
              AnimatedBuilder(
                animation: _buttonSlideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_buttonSlideAnimation.value, 0),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: _isButtonHovered ? Colors.white : DColors.textSecondary,
                      size: 18,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
