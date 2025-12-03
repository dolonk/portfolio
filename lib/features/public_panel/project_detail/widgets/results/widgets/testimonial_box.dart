import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class TestimonialBox extends StatelessWidget {
  final String testimonial;
  final String? clientName;
  final String? clientRole;
  final String? clientCompany;

  const TestimonialBox({super.key, required this.testimonial, this.clientName, this.clientRole, this.clientCompany});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingXl),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DColors.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha((255 * 0.05).round()), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opening Quote Mark
          Icon(Icons.format_quote_rounded, size: 48, color: DColors.primaryButton.withAlpha((255 * 0.5).round())),
          SizedBox(height: s.paddingMd),

          // Testimonial Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
            child: Text(
              testimonial,
              style: fonts.bodyLarge.rubik(color: DColors.textSecondary, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Closing Quote Mark (Aligned Right)
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.format_quote_rounded,
              size: 48,
              color: DColors.primaryButton.withAlpha((255 * 0.5).round()),
            ),
          ),
          SizedBox(height: s.spaceBtwItems),

          // Author Info
          if (clientName != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Divider
                  Container(
                    width: 60,
                    height: 3,
                    decoration: BoxDecoration(color: DColors.primaryButton, borderRadius: BorderRadius.circular(2)),
                  ),
                  SizedBox(height: s.paddingMd),

                  // Client Name
                  Text(clientName!, style: fonts.bodyLarge.rubik(fontWeight: FontWeight.bold)),

                  // Role & Company
                  if (clientRole != null || clientCompany != null)
                    Text(
                      [clientRole, clientCompany].where((e) => e != null).join(', '),
                      style: fonts.bodyMedium.rubik(color: DColors.textSecondary),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
