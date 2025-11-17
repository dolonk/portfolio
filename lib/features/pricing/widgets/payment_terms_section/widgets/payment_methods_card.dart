import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/pricing/payment_terms_model.dart';

class PaymentMethodsCard extends StatelessWidget {
  const PaymentMethodsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    final methods = PaymentMethod.getAllMethods();

    return Container(
      padding: EdgeInsets.all(context.responsiveValue(mobile: s.paddingLg, tablet: s.paddingXl, desktop: s.paddingXl)),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(Icons.payment_rounded, color: DColors.primaryButton, size: 28),
              SizedBox(width: s.paddingMd),
              Text(
                'Payment Methods Accepted',
                style: fonts.titleLarge.rajdhani(
                  fontSize: context.responsiveValue(mobile: 22, tablet: 26, desktop: 28),
                  fontWeight: FontWeight.bold,
                  color: DColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: s.spaceBtwItems),

          // Methods Grid
          _buildMethodsGrid(methods, fonts, s),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.2, duration: 600.ms, delay: 600.ms);
  }

  Widget _buildMethodsGrid(List<PaymentMethod> methods, AppFonts fonts, DSizes s) {
    return Wrap(
      spacing: s.paddingMd,
      runSpacing: s.paddingMd,
      children: methods.asMap().entries.map((entry) {
        final index = entry.key;
        final method = entry.value;

        return _PaymentMethodItem(method: method, delay: index * 100);
      }).toList(),
    );
  }
}

class _PaymentMethodItem extends StatefulWidget {
  final PaymentMethod method;
  final int delay;

  const _PaymentMethodItem({required this.method, this.delay = 0});

  @override
  State<_PaymentMethodItem> createState() => _PaymentMethodItemState();
}

class _PaymentMethodItemState extends State<_PaymentMethodItem> {
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
            transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
              decoration: BoxDecoration(
                color: widget.method.accentColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                border: Border.all(
                  color: _isHovered ? widget.method.accentColor : widget.method.accentColor.withOpacity(0.3),
                  width: _isHovered ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Text(widget.method.icon, style: TextStyle(fontSize: 24)),
                  SizedBox(width: s.paddingSm),

                  // Name + Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.method.name,
                            style: fonts.bodyMedium.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
                          ),
                          if (widget.method.isPreferred) ...[
                            SizedBox(width: 4),
                            Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                          ],
                        ],
                      ),
                      Text(widget.method.description, style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: widget.delay))
        .fadeIn(duration: 600.ms)
        .scale(begin: Offset(0.8, 0.8), duration: 600.ms);
  }
}
