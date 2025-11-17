import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../route/route_name.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../data_layer/model/home/service_model.dart';
import '../../../../../common_function/style/hoverable_card.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class ServiceCard extends StatefulWidget {
  final ServiceModel serviceModel;

  const ServiceCard({super.key, required this.serviceModel});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  late AnimationController _animationController;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _buttonSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    // Icon scale animation on hover
    _iconScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Button slide animation
    _buttonSlideAnimation = Tween<double>(
      begin: 0.0,
      end: 5.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Handle card hover state
  void _onCardHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  // Handle button hover state
  void _onButtonHover(bool isHovered) {
    setState(() {
      _isButtonHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return SizedBox(
      width: context.isMobile ? double.infinity : 260,
      height: context.isMobile ? 280 : 326,
      child: HoverableCard(
        padding: EdgeInsets.all(s.paddingMd),
        onHoverChanged: _onCardHover,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ANIMATED ICON SECTION
            ScaleTransition(
              scale: _iconScaleAnimation,
              child: SvgPicture.asset(
                widget.serviceModel.iconPath,
                width: context.responsiveValue(mobile: 50, tablet: 56, desktop: 60),
                height: context.responsiveValue(mobile: 50, tablet: 56, desktop: 60),
                colorFilter: ColorFilter.mode(
                  _isHovered ? DColors.primaryButton : DColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: s.spaceBtwItems),

            // TITLE
            Text(
              widget.serviceModel.title,
              style: fonts.bodyLarge.rajdhani(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: s.paddingXs),

            // SUBTITLE
            Text(
              widget.serviceModel.subTitle,
              style: fonts.labelLarge.rubik(color: DColors.textSecondary, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: s.spaceBtwItems),

            // DESCRIPTION
            Expanded(
              child: Text(
                widget.serviceModel.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: fonts.labelMedium.rubik(color: DColors.textSecondary, height: 1.5),
              ),
            ),
            SizedBox(height: s.paddingMd),

            // ACTION BUTTON WITH HOVER ANIMATION
            _buildActionButton(context, s, fonts),
          ],
        ),
      ),
    );
  }

  // ACTION BUTTON BUILDER
  Widget _buildActionButton(BuildContext context, DSizes s, AppFonts fonts) {
    return MouseRegion(
      onEnter: (_) => _onButtonHover(true),
      onExit: (_) => _onButtonHover(false),
      child: GestureDetector(
        onTap: () {
          context.go(RouteNames.services);
          debugPrint('Navigating to service: ${widget.serviceModel.title}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(
            color: _isButtonHovered ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: _isButtonHovered ? DColors.primaryButton : DColors.cardBorder, width: 2),
            // Subtle shadow on hover
            boxShadow: _isButtonHovered
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button text
              Text('Learn More', style: fonts.bodyMedium),

              // Animated arrow icon
              AnimatedBuilder(
                animation: _buttonSlideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_isButtonHovered ? _buttonSlideAnimation.value : 0, 0),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: _isButtonHovered ? Colors.white : DColors.textSecondary,
                      size: 20,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
