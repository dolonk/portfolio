import 'deliverable_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_website/route/route_name.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/common_function/widgets/custom_button.dart';
import 'package:responsive_website/common_function/widgets/hoverable_card.dart';
import 'package:responsive_website/data_layer/model/services/service_detail_model.dart';

class ServiceCardDetailed extends StatefulWidget {
  final ServiceDetailModel service;

  const ServiceCardDetailed({super.key, required this.service});

  @override
  State<ServiceCardDetailed> createState() => _ServiceCardDetailedState();
}

class _ServiceCardDetailedState extends State<ServiceCardDetailed> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return HoverableCard(
      padding: EdgeInsets.all(s.paddingMd),
      onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Circle
          _buildIconCircle(s),
          SizedBox(height: s.spaceBtwItems),

          // Title
          Text(widget.service.title, style: fonts.headlineMedium.rajdhani(fontWeight: FontWeight.bold)),
          SizedBox(height: s.paddingSm),

          // Description
          Text(
            widget.service.description,
            style: fonts.bodyMedium.rubik(color: DColors.textSecondary, height: 1.6),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Divider
          Divider(color: DColors.cardBorder),
          SizedBox(height: s.paddingSm),

          // Deliverables List
          Text('Key Deliverables:', style: fonts.labelLarge.rubik(fontWeight: FontWeight.w600)),
          SizedBox(height: s.paddingSm),
          ...widget.service.deliverables!.map((item) => DeliverableItem(text: item)),
          SizedBox(height: s.spaceBtwItems),

          // Divider
          Divider(color: DColors.cardBorder),
          SizedBox(height: s.paddingSm),

          // Price & Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price
              Text(
                widget.service.pricing!,
                style: fonts.headlineSmall.rajdhani(
                  color: DColors.primaryButton,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Button
              CustomButton(
                onPressed: () => context.go(RouteNames.contact),
                tittleText: widget.service.buttonText ?? "",
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Icon Circle at Top
  Widget _buildIconCircle(DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DColors.primaryButton.withAlpha((255 * 0.2).round()),
            DColors.primaryButton.withAlpha((255 * 0.1).round()),
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(widget.service.icon, color: DColors.primaryButton, size: 32),
    );
  }
}
