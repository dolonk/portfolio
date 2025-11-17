import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import '../../../../../data_layer/model/contact/availability_status_model.dart';

class StatusBadge extends StatelessWidget {
  final AvailabilityStatusModel status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    Widget badge = Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingLg, desktop: s.paddingLg),
        vertical: s.paddingMd,
      ),
      decoration: BoxDecoration(
        color: status.statusColor.withAlpha((255 * 0.15).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: status.statusColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: status.statusColor.withAlpha((255 * 0.2).round()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status Icon
          Icon(
            status.icon,
            color: status.statusColor,
            size: context.responsiveValue(mobile: 24, tablet: 28, desktop: 28),
          ),
          SizedBox(width: s.paddingMd),

          // Status Text
          Text(
            status.statusText,
            style: fonts.headlineSmall.rajdhani(fontWeight: FontWeight.bold, color: status.statusColor),
          ),
        ],
      ),
    );

    // Add pulse animation only for "Available" status
    if (status.status == AvailabilityStatus.available) {
      badge = badge
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.03, 1.03),
            duration: 2000.ms,
            curve: Curves.easeInOut,
          );
    }

    return badge;
  }
}
