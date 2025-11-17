import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/pricing/payment_terms_model.dart';

class PaymentTimeline extends StatelessWidget {
  const PaymentTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final milestones = PaymentMilestone.getAllMilestones();

    return Container(
      padding: EdgeInsets.all(
        context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl * 1.5),
      ),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        children: [
          // Title
          Row(
            children: [
              Icon(Icons.schedule_rounded, color: DColors.primaryButton, size: 28),
              SizedBox(width: s.paddingMd),
              Text(
                'Payment Schedule',
                style: fonts.titleLarge.rajdhani(
                  fontSize: context.responsiveValue(mobile: 22, tablet: 26, desktop: 28),
                  fontWeight: FontWeight.bold,
                  color: DColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: s.spaceBtwSections),

          // Timeline
          context.isMobile
              ? _buildVerticalTimeline(milestones, fonts, s)
              : _buildHorizontalTimeline(milestones, fonts, s),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, duration: 600.ms, delay: 400.ms);
  }

  /// Horizontal Timeline (Desktop/Tablet)
  Widget _buildHorizontalTimeline(List<PaymentMilestone> milestones, AppFonts fonts, DSizes s) {
    return Column(
      children: [
        // Timeline Line with Nodes
        Row(
          children: List.generate(milestones.length * 2 - 1, (index) {
            if (index.isEven) {
              // Milestone node
              final milestoneIndex = index ~/ 2;
              final milestone = milestones[milestoneIndex];

              return Expanded(
                child: Column(
                  children: [
                    // Circle with percentage
                    _buildTimelineNode(milestone, fonts, s, milestoneIndex),
                  ],
                ),
              );
            } else {
              // Connecting line
              return Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      height: 3,
                      color: DColors.primaryButton.withOpacity(0.3),
                    ).animate(delay: Duration(milliseconds: 200 * index)).scaleX(begin: 0, duration: 800.ms),
                  ],
                ),
              );
            }
          }),
        ),
        SizedBox(height: s.spaceBtwSections),

        // Milestone Details
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: milestones.asMap().entries.map((entry) {
            final index = entry.key;
            final milestone = entry.value;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: s.paddingSm),
                child: _buildMilestoneCard(milestone, fonts, s, index),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Vertical Timeline (Mobile)
  Widget _buildVerticalTimeline(List<PaymentMilestone> milestones, AppFonts fonts, DSizes s) {
    return Column(
      children: milestones.asMap().entries.map((entry) {
        final index = entry.key;
        final milestone = entry.value;
        final isLast = index == milestones.length - 1;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Timeline node
                Column(
                  children: [
                    _buildTimelineNode(milestone, fonts, s, index),
                    if (!isLast)
                      Container(
                        width: 3,
                        height: 80,
                        margin: EdgeInsets.symmetric(vertical: s.paddingSm),
                        color: DColors.primaryButton.withOpacity(0.3),
                      ).animate(delay: Duration(milliseconds: 200 * index)).scaleY(begin: 0, duration: 800.ms),
                  ],
                ),
                SizedBox(width: s.paddingMd),

                // Right: Milestone details
                Expanded(child: _buildMilestoneCard(milestone, fonts, s, index)),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }

  /// Timeline Node (Circle with percentage)
  Widget _buildTimelineNode(PaymentMilestone milestone, AppFonts fonts, DSizes s, int index) {
    return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [milestone.accentColor, milestone.accentColor.withOpacity(0.7)]),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: milestone.accentColor.withOpacity(0.4), blurRadius: 15, offset: Offset(0, 5))],
          ),
          child: Center(
            child: Text(
              milestone.percentage,
              style: fonts.headlineMedium.rajdhani(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: 200 * index))
        .scale(begin: Offset(0, 0), duration: 600.ms, curve: Curves.elasticOut)
        .then()
        .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3));
  }

  /// Milestone Card
  Widget _buildMilestoneCard(PaymentMilestone milestone, AppFonts fonts, DSizes s, int index) {
    return Container(
          padding: EdgeInsets.all(s.paddingLg),
          decoration: BoxDecoration(
            color: milestone.accentColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: milestone.accentColor.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Milestone Name
              Text(
                milestone.name,
                style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: milestone.accentColor),
              ),
              SizedBox(height: s.paddingSm),

              // When Due
              Row(
                children: [
                  Icon(Icons.calendar_today_rounded, color: DColors.textSecondary, size: 14),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(milestone.whenDue, style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
                  ),
                ],
              ),
              SizedBox(height: s.paddingMd),

              // Deliverables
              ...milestone.deliverables.map((deliverable) {
                return Padding(
                  padding: EdgeInsets.only(bottom: s.paddingSm / 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_rounded, color: milestone.accentColor, size: 16),
                      SizedBox(width: s.paddingSm / 2),
                      Expanded(child: Text(deliverable, style: fonts.bodySmall)),
                    ],
                  ),
                );
              }),
            ],
          ),
        )
        .animate(delay: Duration(milliseconds: 400 + (index * 200)))
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.2, duration: 600.ms);
  }
}
