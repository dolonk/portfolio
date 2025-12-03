import 'coursework_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/data_layer/model/about/education_model.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EducationCard extends StatefulWidget {
  final EducationModel education;

  const EducationCard({super.key, required this.education});

  @override
  State<EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
                constraints: BoxConstraints(
                  maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 650, desktop: 700),
                ),
                padding: EdgeInsets.all(
                  context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl * 1.2),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [widget.education.accentColor.withAlpha(20), widget.education.accentColor.withAlpha(40)],
                  ),

                  borderRadius: BorderRadius.circular(s.borderRadiusLg),
                  border: Border.all(
                    color: _isHovered
                        ? widget.education.accentColor
                        : widget.education.accentColor.withAlpha(127),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered ? widget.education.accentColor.withAlpha(51) : Colors.black.withAlpha(20),
                      blurRadius: _isHovered ? 25 : 15,
                      offset: Offset(0, _isHovered ? 10 : 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Graduation Icon
                    _buildIcon(context, s),
                    SizedBox(height: s.spaceBtwItems),

                    // Degree & Field
                    _buildDegreeInfo(context, s),
                    SizedBox(height: s.spaceBtwItems),

                    // Institution
                    _buildInstitution(context, s),
                    SizedBox(height: s.paddingMd),

                    // Duration & CGPA
                    _buildDurationAndCGPA(context, s),
                    SizedBox(height: s.spaceBtwSections),

                    // Relevant Coursework
                    if (widget.education.relevantCoursework.isNotEmpty) ...[
                      _buildCoursework(context, s),
                      SizedBox(height: s.spaceBtwSections),
                    ],

                    // Key Achievements
                    if (widget.education.achievements.isNotEmpty) _buildAchievements(context, s),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms, delay: 200.ms)
              .scale(begin: const Offset(0.95, 0.95), duration: 600.ms, delay: 200.ms),
    );
  }

  /// Graduation Icon
  Widget _buildIcon(BuildContext context, DSizes s) {
    return Container(
      width: context.responsiveValue(mobile: 80.0, tablet: 90.0, desktop: 100.0),
      height: context.responsiveValue(mobile: 80.0, tablet: 90.0, desktop: 100.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [widget.education.accentColor, widget.education.accentColor.withAlpha(178)],
        ),
        boxShadow: [
          BoxShadow(color: widget.education.accentColor.withAlpha(102), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Icon(
        Icons.school_rounded,
        size: context.responsiveValue(mobile: 40.0, tablet: 45.0, desktop: 50.0),
        color: Colors.white,
      ),
    ).animate(delay: 400.ms).scale(begin: const Offset(0.8, 0.8), curve: Curves.elasticOut, duration: 800.ms);
  }

  /// Degree Information
  Widget _buildDegreeInfo(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        // Degree Name
        Text(
          widget.education.degree,
          style: fonts.headlineMedium.rajdhani(
            fontSize: context.responsiveValue(mobile: 24.0, tablet: 28.0, desktop: 32.0),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.paddingSm * 0.5),

        // Field
        Text(
          widget.education.field,
          style: fonts.bodyLarge.rubik(
            fontSize: context.responsiveValue(mobile: 16.0, tablet: 17.0, desktop: 18.0),
            fontWeight: FontWeight.w600,
            color: widget.education.accentColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Institution
  Widget _buildInstitution(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_city_rounded, size: 20, color: DColors.textSecondary),
        SizedBox(width: s.paddingSm),
        Flexible(
          child: Text(
            widget.education.institution,
            style: fonts.bodyLarge.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Duration and CGPA
  Widget _buildDurationAndCGPA(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: s.paddingLg,
      runSpacing: s.paddingMd,
      children: [
        // Duration
        Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: DColors.cardBackground,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: DColors.cardBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_today_rounded, size: 18, color: widget.education.accentColor),
              SizedBox(width: s.paddingSm),
              Text(
                widget.education.duration,
                style: fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),

        // Passing Year Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
          decoration: BoxDecoration(
            color: widget.education.accentColor.withAlpha(38),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: widget.education.accentColor, width: 1.5),
          ),
          child: Text(
            'Graduated ${widget.education.endYear}',
            style: fonts.bodyMedium.rubik(color: widget.education.accentColor, fontWeight: FontWeight.bold),
          ),
        ),

        // CGPA (if provided)
        if (widget.education.cgpa != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withAlpha(38),
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
              border: Border.all(color: const Color(0xFF10B981), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.grade_rounded, size: 18, color: const Color(0xFF10B981)),
                SizedBox(width: s.paddingSm),
                Text(
                  'CGPA: ${widget.education.cgpa}',
                  style: fonts.bodyMedium.rubik(color: const Color(0xFF10B981), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// Relevant Coursework
  Widget _buildCoursework(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        // Section Title
        Text(
          'Relevant Coursework',
          style: fonts.bodyLarge.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
        SizedBox(height: s.paddingMd),

        // Coursework Badges
        AnimationLimiter(
          child: Wrap(
            spacing: s.paddingSm,
            runSpacing: s.paddingSm,
            alignment: WrapAlignment.center,
            children: List.generate(
              widget.education.relevantCoursework.length,
              (index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 300),
                child: SlideAnimation(
                  verticalOffset: 20.0,
                  child: FadeInAnimation(
                    child: CourseworkBadge(
                      course: widget.education.relevantCoursework[index],
                      accentColor: widget.education.accentColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Key Achievements
  Widget _buildAchievements(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        // Section Title
        Text(
          'Key Achievements',
          style: fonts.bodyLarge.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
        SizedBox(height: s.paddingMd),

        // Achievements List
        AnimationLimiter(
          child: Column(
            children: List.generate(
              widget.education.achievements.length,
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
                          Icon(Icons.check_circle_rounded, size: 20, color: widget.education.accentColor),
                          SizedBox(width: s.paddingSm),
                          Expanded(
                            child: Text(
                              widget.education.achievements[index],
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
          ),
        ),
      ],
    );
  }
}
