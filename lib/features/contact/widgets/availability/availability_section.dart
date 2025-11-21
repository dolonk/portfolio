import 'widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import '../../../../data_layer/model/contact/availability_status_model.dart';

class AvailabilitySection extends StatelessWidget {
  const AvailabilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final currentStatus = AvailabilityStatusModel.getCurrentStatus();

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 800),
          ),
          child: Column(
            children: [
              // Section Heading
              DSectionHeader(
                label: 'AVAILABILITY',
                title: 'Current Availability',
                subtitle: 'Check my current project status and availability',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwItems),

              // Status Card
              _buildStatusCard(context, s, currentStatus),
            ],
          ),
        ),
      ),
    );
  }

  /// Status Card
  Widget _buildStatusCard(BuildContext context, DSizes s, AvailabilityStatusModel status) {
    final fonts = context.fonts;

    return Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                status.statusColor.withAlpha((255 * 0.05).round()),
                status.statusColor.withAlpha((255 * 0.02).round()),
              ],
            ),
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(color: status.statusColor.withAlpha((255 * 0.3).round()), width: 2),
            boxShadow: [
              BoxShadow(
                color: status.statusColor.withAlpha((255 * 0.1).round()),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Status Badge
              StatusBadge(status: status),
              SizedBox(height: s.spaceBtwItems),

              // Description
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  status.description,
                  style: fonts.bodyLarge.rubik(color: DColors.textPrimary, height: 1.6, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),

              // Next Available Date (only show if limited or unavailable)
              if (status.nextAvailableDate != null) ...[
                SizedBox(height: s.spaceBtwItems),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
                  decoration: BoxDecoration(
                    color: DColors.cardBackground,
                    borderRadius: BorderRadius.circular(s.borderRadiusSm),
                    border: Border.all(color: DColors.cardBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 20, color: status.statusColor),
                      SizedBox(width: s.paddingSm),
                      Text('Next Available: ', style: fonts.bodyMedium.rubik(color: DColors.textSecondary)),
                      Text(
                        status.nextAvailableDate!,
                        style: fonts.bodyMedium.rubik(color: status.statusColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 300.ms)
        .slideY(begin: 0.1, duration: 800.ms, delay: 300.ms)
        .scale(begin: const Offset(0.95, 0.95), duration: 800.ms, delay: 300.ms);
  }
}
