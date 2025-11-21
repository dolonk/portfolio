import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class PopularBadge extends StatelessWidget {
  const PopularBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(mobile: s.paddingMd, desktop: s.paddingLg),
            vertical: s.paddingSm,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)]),
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            boxShadow: [
              BoxShadow(color: Color(0xFFFBBF24).withAlpha((255 * 0.6).round()), blurRadius: 20, offset: Offset(0, 5)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🔥', style: TextStyle(fontSize: 16)),
              SizedBox(width: 6),
              Text(
                'MOST POPULAR',
                style: fonts.labelSmall.rubik(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1),
              ),
            ],
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 2000.ms, color: Colors.white.withAlpha((255 * 0.6).round()))
        .then()
        .shake(duration: 500.ms, hz: 2, curve: Curves.easeInOut);
  }
}
