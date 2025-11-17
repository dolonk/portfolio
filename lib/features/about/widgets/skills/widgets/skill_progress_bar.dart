import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/data_layer/model/about/skill_model.dart';

class SkillProgressBar extends StatefulWidget {
  final SkillModel skill;
  final Color accentColor;
  final int delay;

  const SkillProgressBar({super.key, required this.skill, required this.accentColor, this.delay = 0});

  @override
  State<SkillProgressBar> createState() => _SkillProgressBarState();
}

class _SkillProgressBarState extends State<SkillProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    _animation = Tween<double>(
      begin: 0,
      end: widget.skill.percentage / 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Start animation after delay
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: EdgeInsets.only(bottom: s.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skill Name and Percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skill Name
                Expanded(
                  child: Text(
                    widget.skill.name,
                    style: fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: s.paddingMd),

                // Percentage
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Text(
                      '${(_animation.value * 100).toInt()}%',
                      style: fonts.bodyMedium.rubik(color: widget.accentColor, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: s.paddingSm),

            // Progress Bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _isHovered ? 12 : 10,
              decoration: BoxDecoration(
                color: DColors.cardBackground,
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
                border: Border.all(color: DColors.cardBorder, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(s.borderRadiusSm - 1),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        // Animated Fill
                        FractionallySizedBox(
                          widthFactor: _animation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  widget.accentColor,
                                  widget.accentColor.withAlpha((255 * 0.7).round()),
                                ],
                              ),
                              boxShadow: [
                                if (_isHovered)
                                  BoxShadow(
                                    color: widget.accentColor.withAlpha((255 * 0.5).round()),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
