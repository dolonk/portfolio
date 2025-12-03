import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route/route_name.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/common_function/widgets/custom_button.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/data_layer/model/pricing/addon_service_model.dart';

class AddonCard extends StatefulWidget {
  final AddonServiceModel addon;

  const AddonCard({super.key, required this.addon});

  @override
  State<AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends State<AddonCard> {
  bool _isHovered = false;
  bool _isFeaturesExpanded = false;

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
        transform:
            Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0) *
            Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: DColors.cardBackground,
                borderRadius: BorderRadius.circular(s.borderRadiusLg),
                border: Border.all(
                  color: _isHovered ? widget.addon.accentColor : DColors.cardBorder,
                  width: _isHovered ? 2 : 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? widget.addon.accentColor.withAlpha((255 * 0.3).round())
                        : Colors.black.withAlpha((255 * 0.08).round()),
                    blurRadius: _isHovered ? 25 : 12,
                    offset: Offset(0, _isHovered ? 12 : 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Icon
                  _buildHeader(fonts, s),

                  // Card Body
                  Padding(
                    padding: EdgeInsets.all(s.paddingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Service Name
                        _buildServiceName(fonts, s),
                        SizedBox(height: s.spaceBtwItems),

                        // Divider
                        Divider(color: DColors.cardBorder, height: 1),
                        SizedBox(height: s.spaceBtwItems),

                        // Price Range
                        _buildPriceRange(fonts, s),
                        SizedBox(height: s.paddingMd),

                        // Features Toggle
                        _buildFeaturesToggle(fonts, s),

                        // Expanded Features List
                        if (_isFeaturesExpanded) ...[SizedBox(height: s.paddingMd), _buildFeaturesList(fonts, s)],
                        SizedBox(height: s.spaceBtwItems),

                        // CTA Button
                        _buildCTAButton(fonts, s),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Popular Badge
            if (widget.addon.isPopular)
              Positioned(
                top: -10,
                right: context.responsiveValue(mobile: 15, tablet: 20, desktop: 20),
                child: _buildPopularBadge(fonts, s),
              ),
          ],
        ),
      ),
    );
  }

  /// Header with Emoji Icon
  Widget _buildHeader(DFontSizes fonts, DSizes s) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.responsiveValue(mobile: s.paddingLg, desktop: s.paddingXl)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [widget.addon.accentColor.withAlpha(38), widget.addon.accentColor.withAlpha(14)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(s.borderRadiusLg),
          topRight: Radius.circular(s.borderRadiusLg),
        ),
      ),
      child: Center(
        child: Text(
          widget.addon.emoji,
          style: TextStyle(fontSize: context.responsiveValue(mobile: 48, tablet: 56, desktop: 64)),
        ),
      ),
    );
  }

  /// Service Name + Description
  Widget _buildServiceName(DFontSizes fonts, DSizes s) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          widget.addon.name,
          style: fonts.titleLarge.rajdhani(
            fontSize: context.responsiveValue(mobile: 20, tablet: 22, desktop: 24),
            fontWeight: FontWeight.bold,
            color: widget.addon.accentColor,
          ),
        ),
        SizedBox(height: s.paddingSm),
        Text(
          widget.addon.description,
          style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// Price Range
  Widget _buildPriceRange(DFontSizes fonts, DSizes s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: widget.addon.accentColor.withAlpha(25),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: widget.addon.accentColor.withAlpha(76), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.payments_rounded, color: widget.addon.accentColor, size: 18),
          SizedBox(width: s.paddingSm),
          Text(
            widget.addon.priceRange,
            style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: widget.addon.accentColor),
          ),
        ],
      ),
    );
  }

  /// Features Toggle Button
  Widget _buildFeaturesToggle(DFontSizes fonts, DSizes s) {
    return InkWell(
      onTap: () => setState(() => _isFeaturesExpanded = !_isFeaturesExpanded),
      borderRadius: BorderRadius.circular(s.borderRadiusMd),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
        decoration: BoxDecoration(
          border: Border.all(color: widget.addon.accentColor.withAlpha((255 * 0.1).round()), width: 1),
          borderRadius: BorderRadius.circular(s.borderRadiusMd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isFeaturesExpanded ? 'Hide Features' : 'View Features',
              style: fonts.bodyMedium.rubik(
                fontSize: context.responsiveValue(mobile: 12, desktop: 14),
                fontWeight: FontWeight.w600,
                color: widget.addon.accentColor,
              ),
            ),
            SizedBox(width: s.paddingSm),
            Icon(
              _isFeaturesExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
              color: widget.addon.accentColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  /// Features List
  Widget _buildFeaturesList(DFontSizes fonts, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.addon.features.map((feature) {
        return Padding(
          padding: EdgeInsets.only(bottom: s.paddingSm),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              Icon(Icons.check_circle_rounded, color: widget.addon.accentColor, size: 16),
              SizedBox(width: s.paddingSm),
              Expanded(
                child: Text(
                  feature,
                  style: fonts.bodySmall.rubik(
                    fontSize: context.responsiveValue(mobile: 12, desktop: 14),
                    color: DColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// CTA Button
  Widget _buildCTAButton(DFontSizes fonts, DSizes s) {
    return CustomButton(
      width: double.infinity,
      height: 48,
      tittleText: 'Get Quote',
      onPressed: () => context.go('${RouteNames.contact}?service=${widget.addon.name}'),
    );
  }

  /// Popular Badge
  Widget _buildPopularBadge(DFontSizes fonts, DSizes s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm / 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)]),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(color: Color(0xFFFBBF24).withAlpha((255 * 0.5).round()), blurRadius: 15, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🔥', style: TextStyle(fontSize: 12)),
          SizedBox(width: 4),
          Text(
            'POPULAR',
            style: fonts.labelSmall.rubik(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
