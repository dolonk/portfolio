import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/data_layer/model/about/skill_model.dart';

class SkillProgressBar extends StatefulWidget {
  final SkillModel skill;
  final Color accentColor;
  final int delay;

  const SkillProgressBar({super.key, required this.skill, required this.accentColor, this.delay = 0});

  @override
  State<SkillProgressBar> createState() => _SkillProgressBarState();
}

class _SkillProgressBarState extends State<SkillProgressBar> {
  double animatedValue = 0;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (!mounted) return;
      setState(() {
        animatedValue = widget.skill.percentage / 100;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.skill.name,
                    style: fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "${widget.skill.percentage}%",
                  style: fonts.bodyMedium.rubik(color: widget.accentColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: s.paddingSm),

            // Progress Bar (FractionallySizedBox animated)
            AnimatedContainer(
              duration: 300.ms,
              height: _isHovered ? 12 : 10,
              decoration: BoxDecoration(
                color: DColors.cardBackground,
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
                border: Border.all(color: DColors.cardBorder, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(s.borderRadiusSm - 1),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: animatedValue),
                  duration: 300.ms,
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [widget.accentColor, widget.accentColor.withAlpha(178)]),
                          boxShadow: [
                            if (_isHovered)
                              BoxShadow(color: widget.accentColor.withAlpha(20), blurRadius: 8, spreadRadius: 2),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
