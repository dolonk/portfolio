import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/pricing/payment_terms_model.dart';

class PaymentTimeline extends StatelessWidget {
  const PaymentTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final milestones = PaymentMilestone.getAllMilestones();

    return Container(
      padding: EdgeInsets.all(
        context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl * 1.5),
      ),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          _buildTitle(context),
          SizedBox(height: s.spaceBtwSections),
          context.isMobile
              ? _buildVerticalTimeline(milestones, context)
              : _buildHorizontalTimeline(milestones, context),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, duration: 600.ms, delay: 400.ms);
  }

  Widget _buildTitle(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Row(
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
    );
  }

  Widget _buildHorizontalTimeline(List<PaymentMilestone> milestones, BuildContext context) {
    final s = context.sizes;

    return Column(
      children: [
        _buildTimelineNodes(milestones, context),
        SizedBox(height: s.spaceBtwSections),
        _buildMilestoneDetails(milestones, context),
      ],
    );
  }

  Widget _buildTimelineNodes(List<PaymentMilestone> milestones, BuildContext context) {
    return Row(
      children: List.generate(milestones.length * 2 - 1, (index) {
        if (index.isEven) {
          final milestoneIndex = index ~/ 2;
          return Expanded(child: _buildTimelineNode(milestones[milestoneIndex], milestoneIndex, context));
        } else {
          return Expanded(child: _buildConnectingLine(index, context));
        }
      }),
    );
  }

  Widget _buildConnectingLine(int index, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          height: 3,
          color: DColors.primaryButton.withAlpha(77),
        ).animate(delay: (200 * index).ms).scaleX(begin: 0, duration: 800.ms),
      ],
    );
  }

  Widget _buildMilestoneDetails(List<PaymentMilestone> milestones, BuildContext context) {
    final s = context.sizes;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: milestones.asMap().entries.map((entry) {
        final index = entry.key;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s.paddingSm),
            child: _buildMilestoneCard(entry.value, index, context),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVerticalTimeline(List<PaymentMilestone> milestones, BuildContext context) {
    return Column(
      children: milestones.asMap().entries.map((entry) {
        final index = entry.key;
        final isLast = index == milestones.length - 1;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _buildTimelineNode(entry.value, index, context),
                    if (!isLast) _buildVerticalConnector(index, context),
                  ],
                ),
                SizedBox(width: context.sizes.paddingMd),
                Expanded(child: _buildMilestoneCard(entry.value, index, context)),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildVerticalConnector(int index, BuildContext context) {
    final s = context.sizes;

    return Container(
      width: 3,
      height: 80,
      margin: EdgeInsets.symmetric(vertical: s.paddingSm),
      color: DColors.primaryButton.withAlpha(77), // 0.3 * 255
    ).animate(delay: (200 * index).ms).scaleY(begin: 0, duration: 800.ms);
  }

  Widget _buildTimelineNode(PaymentMilestone milestone, int index, BuildContext context) {
    final fonts = context.fonts;

    return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [milestone.accentColor, milestone.accentColor.withAlpha(179)]),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: milestone.accentColor.withAlpha(102), blurRadius: 15, offset: const Offset(0, 5)),
            ],
          ),
          child: Center(
            child: Text(
              milestone.percentage,
              style: fonts.headlineMedium.rajdhani(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        )
        .animate(delay: (200 * index).ms)
        .scale(begin: const Offset(0, 0), duration: 600.ms, curve: Curves.elasticOut)
        .then()
        .shimmer(duration: 2000.ms, color: Colors.white.withAlpha(77)); // 0.3 * 255
  }

  Widget _buildMilestoneCard(PaymentMilestone milestone, int index, BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsets.all(s.paddingLg),
        decoration: BoxDecoration(
          color: milestone.accentColor.withAlpha(13),
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
          border: Border.all(color: milestone.accentColor.withAlpha(51), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              milestone.name,
              style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: milestone.accentColor),
            ),
            SizedBox(height: s.paddingSm),
            _buildDueDate(milestone, fonts),
            SizedBox(height: s.paddingMd),
            ..._buildDeliverables(milestone, fonts, s),
          ],
        ),
      ).animate(delay: (400 + (index * 200)).ms).fadeIn(duration: 600.ms).slideX(begin: 0.2, duration: 600.ms),
    );
  }

  Widget _buildDueDate(PaymentMilestone milestone, AppFonts fonts) {
    return Row(
      children: [
        Icon(Icons.calendar_today_rounded, color: DColors.textSecondary, size: 14),
        SizedBox(width: 4),
        Expanded(
          child: Text(milestone.whenDue, style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
        ),
      ],
    );
  }

  List<Widget> _buildDeliverables(PaymentMilestone milestone, AppFonts fonts, DSizes s) {
    return milestone.deliverables.map((deliverable) {
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
    }).toList();
  }
}
