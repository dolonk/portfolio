import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class QuoteBox extends StatelessWidget {
  final String quote;
  final String? author;

  const QuoteBox({super.key, required this.quote, this.author});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      margin: EdgeInsets.symmetric(vertical: s.spaceBtwItems),
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [DColors.primaryButton.withAlpha((20)), DColors.primaryButton.withAlpha((7))],
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusMd),
        border: Border.all(color: DColors.primaryButton.withAlpha((76)), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opening Quote Mark
          Icon(
            Icons.format_quote_rounded,
            size: context.responsiveValue(mobile: 32.0, tablet: 40.0, desktop: 48.0),
            color: DColors.primaryButton.withAlpha((127)),
          ),
          SizedBox(height: s.paddingSm),

          // Quote Text
          Text(
            quote,
            style: fonts.bodyLarge.rubik(
              color: DColors.textPrimary,
              height: 1.7,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Author (if provided)
          if (author != null) ...[
            SizedBox(height: s.paddingMd),
            Text(
              '— $author',
              style: fonts.bodyMedium.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: -0.1, duration: 600.ms, delay: 400.ms);
  }
}
