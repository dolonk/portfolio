import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../data_layer/model/home/reviews_model.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';

class ReviewsCard extends StatefulWidget {
  final ReviewsModel reviews;
  const ReviewsCard({super.key, required this.reviews});

  @override
  State<ReviewsCard> createState() => _ReviewsCardState();
}

class _ReviewsCardState extends State<ReviewsCard> {
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
        curve: Curves.easeInOut,
        width: context.isMobile ? double.infinity : 420,
        padding: EdgeInsets.all(s.paddingMd),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(s.borderRadiusSm),
          gradient: LinearGradient(
            colors: [Color(0xBF262425), Color(0x99750C2D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: _isHovered ? DColors.primaryButton : DColors.cardBorder, width: 2),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Rating Stars
              Row(
                children: List.generate(
                  widget.reviews.rating,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: s.paddingXs),
                    child: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: context.responsiveValue(mobile: 16, tablet: 18, desktop: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: s.spaceBtwItems16),

              // Quote
              Text(
                widget.reviews.quote,
                style: fonts.labelMedium.rajdhani(color: DColors.textPrimary, height: 1.6),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: s.spaceBtwItems16),

              // Author Info Row
              Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.reviews.imagePath),
                    radius: context.responsiveValue(mobile: 20, tablet: 22, desktop: 24),
                    backgroundColor: DColors.cardBorder,
                  ),
                  SizedBox(width: s.spaceBtwItems),

                  // Name & Role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.reviews.name,
                          style: fonts.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          widget.reviews.role,
                          style: fonts.bodySmall.rubik(color: DColors.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Quote Icon
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isHovered ? 1.0 : 0.3,
                    child: ImageIcon(
                      AssetImage('assets/home/icon/background_icon.png'),
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
