import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/contact/testimonial_model.dart';
import 'rating_stars.dart';

class TestimonialCard extends StatefulWidget {
  final TestimonialModel testimonial;

  const TestimonialCard({super.key, required this.testimonial});

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  final bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((255 * (_isHovered ? 0.15 : 0.08)).round()),
            blurRadius: _isHovered ? 25 : 15,
            offset: Offset(0, _isHovered ? 12 : 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Stars
            RatingStars(
              rating: widget.testimonial.rating,
              size: context.responsiveValue(mobile: 22.0, tablet: 24.0, desktop: 26.0),
            ),
            SizedBox(height: s.spaceBtwItems),

            // Testimonial Text
            Container(
              constraints: BoxConstraints(
                minHeight: context.responsiveValue(mobile: 120.0, tablet: 140.0, desktop: 160.0),
              ),
              child: Text(
                '"${widget.testimonial.testimonial}"',
                style: fonts.bodyLarge.rubik(color: DColors.textPrimary, height: 1.7, fontStyle: FontStyle.italic),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: s.spaceBtwItems),

            // Client Info
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: context.responsiveValue(mobile: 24.0, tablet: 28.0, desktop: 32.0),
                  backgroundColor: DColors.primaryButton.withAlpha((255 * 0.2).round()),
                  child: widget.testimonial.clientPhoto != null
                      ? ClipOval(
                          child: Image.network(
                            widget.testimonial.clientPhoto!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(context),
                          ),
                        )
                      : _buildDefaultAvatar(context),
                ),
                SizedBox(width: s.paddingMd),

                // Name, Role, Project Type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Client Name
                      Text(
                        widget.testimonial.clientName,
                        style: fonts.bodyLarge.rubik(fontWeight: FontWeight.bold, color: DColors.textPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: s.paddingSm * 0.5),

                      // Company/Role
                      Text(
                        widget.testimonial.companyRole,
                        style: fonts.bodySmall.rubik(color: DColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: s.paddingSm * 0.5),

                      // Project Type Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: s.paddingSm, vertical: s.paddingSm * 0.4),
                        decoration: BoxDecoration(
                          color: DColors.primaryButton.withAlpha((255 * 0.15).round()),
                          borderRadius: BorderRadius.circular(s.borderRadiusSm),
                          border: Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round())),
                        ),
                        child: Text(
                          widget.testimonial.projectType,
                          style: fonts.bodySmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Default Avatar Icon
  Widget _buildDefaultAvatar(BuildContext context) {
    return Icon(
      Icons.person_rounded,
      size: context.responsiveValue(mobile: 28.0, tablet: 32.0, desktop: 36.0),
      color: DColors.primaryButton,
    );
  }
}
