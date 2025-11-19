import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../route/route_name.dart';
import '../../../../../utility/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../data_layer/model/home/service_model.dart';
import '../../../../../common_function/style/hoverable_card.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import '../../../../../common_function/style/animated_custom_button.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel serviceModel;

  const ServiceCard({super.key, required this.serviceModel});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;
  final bool _isButtonHovered = false;

  void _onCardHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final animationDuration = 300.ms;

    return SizedBox(
      width: context.isMobile ? double.infinity : 260,
      height: context.isMobile ? 280 : 326,
      child: HoverableCard(
        padding: EdgeInsets.all(s.paddingMd),
        onHoverChanged: _onCardHover,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Svg Icon
            SvgPicture.asset(
                  widget.serviceModel.iconPath,
                  width: context.responsiveValue(mobile: 50, tablet: 56, desktop: 60),
                  height: context.responsiveValue(mobile: 50, tablet: 56, desktop: 60),
                  colorFilter: ColorFilter.mode(
                    _isHovered ? DColors.primaryButton : DColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                )
                .animate(target: _isHovered ? 1 : 0)
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  curve: Curves.easeInOut,
                  duration: animationDuration,
                ),
            SizedBox(height: s.spaceBtwItems),

            // Title
            Text(
              widget.serviceModel.title,
              style: fonts.bodyLarge.rajdhani(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: s.paddingXs),

            // Sub Title
            Text(
              widget.serviceModel.subTitle,
              style: fonts.labelLarge.rubik(color: DColors.textSecondary, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: s.spaceBtwItems),

            // Description
            Expanded(
              child: Text(
                widget.serviceModel.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: fonts.labelMedium.rubik(color: DColors.textSecondary, height: 1.5),
              ),
            ),
            SizedBox(height: s.paddingMd),

            // Button
            AnimatedCustomButton(
              onPressed: () => context.go(RouteNames.services),
              text: 'Learn More',
              iconSlideDistance: 1,
              icon: Icon(Icons.arrow_forward_rounded, color: DColors.textSecondary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
