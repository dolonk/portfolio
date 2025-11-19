import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/constants/image_string.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Diamond Gradient Shape
        DiamondGradiantShape(
          vector1Width: context.responsiveValue(mobile: 500, tablet: 500, desktop: 530),
          vector1Height: context.responsiveValue(mobile: 400, tablet: 450, desktop: 500),
          vector2Width: context.responsiveValue(mobile: 350, tablet: 420, desktop: 440),
          vector2Height: context.responsiveValue(mobile: 400, tablet: 450, desktop: 500),
        ),

        // Top Text
        Positioned(
          top: context.responsiveValue(mobile: 60, desktop: 80),
          child: Text("APP DEVELOPMENT", style: context.fonts.displayLarge)
              .animate(onComplete: (controller) => controller.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: 2000.ms,
                curve: Curves.easeInOut,
              )
              .then()
              .scale(
                begin: const Offset(1.05, 1.05),
                end: const Offset(1, 1),
                duration: 2000.ms,
                curve: Curves.easeInOut,
              ),
        ),

        // Center Image
        Image.asset(
          DImages.profileImage,
          height: context.responsiveValue(mobile: 400, tablet: 450, desktop: 500),
          fit: BoxFit.cover,
          cacheHeight: context.responsiveValue(mobile: 400, tablet: 450, desktop: 500).toInt(),
          filterQuality: FilterQuality.medium,
        ),

        // Bottom Text Stroke
        Positioned(
          bottom: context.responsiveValue(mobile: 6, desktop: 20),
          child:
              Text(
                    "FLUTTER EXPERT",
                    style: context.fonts.displayLarge.copyWith(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = DColors.textPrimary,
                    ),
                  )
                  .animate(onComplete: (c) => c.repeat())
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: 2000.ms,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    begin: const Offset(1.05, 1.05),
                    end: const Offset(1, 1),
                    duration: 2000.ms,
                    curve: Curves.easeInOut,
                  ),
        ),
      ],
    );
  }
}
