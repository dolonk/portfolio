import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/pricing/payment_terms_model.dart';

class PaymentPoliciesCard extends StatelessWidget {
  const PaymentPoliciesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final policies = PaymentPolicy.getAllPolicies();

    return Container(
      padding: EdgeInsets.all(context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl)),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(Icons.policy_rounded, color: DColors.primaryButton, size: 28),
              SizedBox(width: s.paddingMd),
              Text(
                'Payment Policies',
                style: fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: s.spaceBtwItems),

          // Policies Grid
          _buildPoliciesGrid(context, policies, fonts, s),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.2, duration: 600.ms, delay: 800.ms);
  }

  Widget _buildPoliciesGrid(BuildContext context, List<PaymentPolicy> policies, DFontSizes fonts, DSizes s) {
    final crossAxisCount = context.responsiveValue(mobile: 1, tablet: 2, desktop: 2);
    final spacing = s.paddingMd;

    if (context.isMobile) {
      return Column(
        children: policies.asMap().entries.map((entry) {
          final index = entry.key;
          final policy = entry.value;

          return Padding(
            padding: EdgeInsets.only(bottom: spacing),
            child: _PolicyCard(policy: policy, delay: index * 150),
          );
        }).toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - spacing) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: policies.asMap().entries.map((entry) {
            final index = entry.key;
            final policy = entry.value;

            return SizedBox(
              width: cardWidth,
              child: _PolicyCard(policy: policy, delay: index * 150),
            );
          }).toList(),
        );
      },
    );
  }
}

class _PolicyCard extends StatefulWidget {
  final PaymentPolicy policy;
  final int delay;

  const _PolicyCard({required this.policy, this.delay = 0});

  @override
  State<_PolicyCard> createState() => _PolicyCardState();
}

class _PolicyCardState extends State<_PolicyCard> {
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
            transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
            child: Container(
              padding: EdgeInsets.all(s.paddingLg),
              decoration: BoxDecoration(
                color: widget.policy.accentColor.withAlpha(12),
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                border: Border.all(
                  color: _isHovered ? widget.policy.accentColor : widget.policy.accentColor.withAlpha(51),
                  width: _isHovered ? 2 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon + Title
                  Row(
                    children: [
                      Text(widget.policy.icon, style: TextStyle(fontSize: 28)),
                      SizedBox(width: s.paddingSm),
                      Expanded(
                        child: Text(
                          widget.policy.title,
                          style: fonts.titleMedium.rajdhani(
                            fontWeight: FontWeight.bold,
                            color: widget.policy.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: s.paddingMd),

                  // Points
                  ...widget.policy.points.map((point) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: s.paddingSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle_rounded, color: widget.policy.accentColor, size: 16),
                          SizedBox(width: s.paddingSm),
                          Expanded(
                            child: Text(point, style: fonts.bodySmall.rubik(color: DColors.textPrimary, height: 1.5)),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: widget.delay))
        .fadeIn(duration: 600.ms)
        .slideX(begin: 0.2, duration: 600.ms);
  }
}
