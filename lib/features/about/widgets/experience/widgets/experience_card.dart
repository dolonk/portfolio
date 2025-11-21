import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/about/experience_model.dart';
import 'timeline_marker.dart';
import 'tech_badge.dart';

class ExperienceCard extends StatefulWidget {
  final ExperienceModel experience;
  final bool isLast;
  final int delay;

  const ExperienceCard({super.key, required this.experience, this.isLast = false, this.delay = 0});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child:
          Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Timeline Marker + Line
                  Column(
                    children: [
                      TimelineMarker(
                        accentColor: widget.experience.accentColor,
                        isCurrent: widget.experience.isCurrent,
                        icon: Icons.work_rounded,
                      ),

                      // Connecting Line (if not last)
                      if (!widget.isLast)
                        Container(
                          width: 3,
                          height: context.responsiveValue(mobile: 120.0, tablet: 140.0, desktop: 160.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                widget.experience.accentColor.withAlpha(153),
                                widget.experience.accentColor.withAlpha(51),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    width: context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingXl),
                  ),

                  // Right: Content
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
                      padding: EdgeInsets.all(
                        context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
                      ),
                      margin: EdgeInsets.only(bottom: widget.isLast ? 0 : s.spaceBtwItems),
                      decoration: BoxDecoration(
                        color: DColors.cardBackground,
                        borderRadius: BorderRadius.circular(s.borderRadiusMd),
                        border: Border.all(
                          color: _isHovered
                              ? widget.experience.accentColor
                              : widget.experience.accentColor.withAlpha(76),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isHovered
                                ? widget.experience.accentColor.withAlpha(38)
                                : Colors.black.withAlpha(12),
                            blurRadius: _isHovered ? 20 : 10,
                            offset: Offset(0, _isHovered ? 8 : 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(context, s),
                          SizedBox(height: s.spaceBtwItems),
                          _buildResponsibilities(context, s),
                          SizedBox(height: s.spaceBtwItems),
                          _buildTechStack(context, s),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: widget.delay.ms)
              .slideX(begin: -0.1, duration: 600.ms, delay: widget.delay.ms),
    );
  }

  /// Header (Company, Role, Duration)
  Widget _buildHeader(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Name
        Text(
          widget.experience.company,
          style: fonts.headlineSmall.rajdhani(
            fontSize: context.responsiveValue(mobile: 20.0, tablet: 22.0, desktop: 24.0),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
        ),
        SizedBox(height: s.paddingSm * 0.5),

        // Role
        Text(
          widget.experience.role,
          style: fonts.bodyLarge.rubik(
            fontSize: context.responsiveValue(mobile: 16.0, tablet: 17.0, desktop: 18.0),
            fontWeight: FontWeight.w600,
            color: widget.experience.accentColor,
          ),
        ),
        SizedBox(height: s.paddingSm * 0.5),

        // Duration with Badge
        Row(
          children: [
            Icon(Icons.calendar_today_rounded, size: 16, color: DColors.textSecondary),
            SizedBox(width: s.paddingSm),
            Text(widget.experience.duration, style: fonts.bodyMedium.rubik(color: DColors.textSecondary)),
            if (widget.experience.isCurrent) ...[
              SizedBox(width: s.paddingSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: s.paddingSm * 0.3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withAlpha(38),
                  borderRadius: BorderRadius.circular(s.borderRadiusSm),
                  border: Border.all(color: const Color(0xFF10B981), width: 1),
                ),
                child: Text(
                  'Present',
                  style: fonts.bodySmall.rubik(
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  /// Responsibilities with Bullet Points
  Widget _buildResponsibilities(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Responsibilities & Achievements:',
            style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingSm),
          ...List.generate(
            widget.experience.responsibilities.length,
            (index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 400),
              child: SlideAnimation(
                verticalOffset: 20.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: s.paddingSm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle_rounded, size: 18, color: widget.experience.accentColor),
                        SizedBox(width: s.paddingSm),
                        Expanded(
                          child: Text(
                            widget.experience.responsibilities[index],
                            style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tech Stack Badges
  Widget _buildTechStack(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technologies Used:',
          style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
        SizedBox(height: s.paddingSm),
        Wrap(
          spacing: s.paddingSm,
          runSpacing: s.paddingSm,
          children: widget.experience.technologies.map((tech) {
            return TechBadge(tech: tech, accentColor: widget.experience.accentColor);
          }).toList(),
        ),
      ],
    );
  }
}
