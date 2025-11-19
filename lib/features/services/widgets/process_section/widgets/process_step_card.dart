import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/common_function/style/hoverable_card.dart';
import 'package:responsive_website/data_layer/model/services/process_step_model.dart';

class ProcessStepCard extends StatefulWidget {
  final ProcessStepModel step;

  const ProcessStepCard({super.key, required this.step});

  @override
  State<ProcessStepCard> createState() => _ProcessStepCardState();
}

class _ProcessStepCardState extends State<ProcessStepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return HoverableCard(
      padding: EdgeInsets.all(s.paddingSm),
      onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          // Step Number Badge
          Center(child: _buildStepBadge(s, fonts)),
          SizedBox(height: s.spaceBtwItems),

          // Icon Circle
          _buildIconCircle(s),
          SizedBox(height: s.spaceBtwItems),

          // Title
          Text(widget.step.title, style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold)),
          SizedBox(height: s.paddingSm),

          // Timeline
          Container(
            padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
            decoration: BoxDecoration(
              color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.step.timeline,
              style: fonts.labelMedium.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Description
          Text(
            widget.step.description,
            style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Divider
          Divider(color: DColors.cardBorder),
          SizedBox(height: s.paddingSm),

          // Client Receives Section
          Text('Client Receives:', style: fonts.labelLarge.rubik(fontWeight: FontWeight.w600)),
          SizedBox(height: s.paddingSm),

          // Client Receives List
          ...widget.step.clientReceives.map((item) => _buildReceiveItem(item, s, fonts)),
        ],
      ),
    );
  }

  /// Step Number Badge (Circular with gradient)
  Widget _buildStepBadge(DSizes s, AppFonts fonts) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [DColors.primaryButton, DColors.primaryButton.withAlpha((255 * 0.7).round())],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${widget.step.stepNumber}',
          textAlign: TextAlign.center,
          style: fonts.headlineMedium.rajdhani(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Icon Circle with background
  Widget _buildIconCircle(DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
        shape: BoxShape.circle,
      ),
      child: Icon(widget.step.icon, color: DColors.primaryButton, size: 32),
    );
  }

  /// Client Receives Item (with checkmark)
  Widget _buildReceiveItem(String text, DSizes s, AppFonts fonts) {
    return Padding(
      padding: EdgeInsets.only(bottom: s.paddingSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Green Checkmark
          Icon(Icons.check_circle_rounded, color: const Color(0xFF10B981), size: 20),
          SizedBox(width: s.paddingSm),

          // Text
          Expanded(
            child: Text(text, style: fonts.bodySmall.rubik(color: DColors.textSecondary, height: 1.5)),
          ),
        ],
      ),
    );
  }
}
