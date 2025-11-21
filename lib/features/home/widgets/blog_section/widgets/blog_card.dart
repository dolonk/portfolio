import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../route/route_name.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../data_layer/model/home/blog_model.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../common_function/widgets/hoverable_card.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../common_function/widgets/animated_custom_button.dart';

class BlogCard extends StatefulWidget {
  final BlogModel blog;

  const BlogCard({super.key, required this.blog});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return HoverableCard(
      padding: const EdgeInsets.all(8),
      onHoverChanged: (v) => setState(() => _isHovered = v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE + OVERLAY
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(s.borderRadiusMd - 2),
                topRight: Radius.circular(s.borderRadiusMd - 2),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // IMAGE ZOOM (hover)
                  Image.asset(widget.blog.imagePath, fit: BoxFit.cover, cacheWidth: 400, cacheHeight: 400)
                      .animate(target: _isHovered ? 1 : 0)
                      .scale(
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                      ),

                  // OVERLAY GRADIENT FADE
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, DColors.primaryButton.withAlpha((255 * 0.6).round())],
                      ),
                    ),
                  ).animate(target: _isHovered ? 1 : 0).fade(duration: 300.ms),
                ],
              ),
            ),
          ),

          SizedBox(height: s.paddingSm),

          // TEXT + READ MORE BUTTON
          Padding(
            padding: EdgeInsets.symmetric(horizontal: s.paddingXs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.blog.category,
                  style: fonts.bodySmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: s.spaceBtwItems / 2),

                Text(
                  widget.blog.title,
                  style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: s.spaceBtwItems / 2),

                Text(
                  widget.blog.description,
                  style: fonts.labelMedium.rubik(color: DColors.textSecondary, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: s.spaceBtwItems),

                // READ MORE button with arrow slide
                AnimatedCustomButton(
                  onPressed: () => context.go(RouteNames.blog),
                  text: 'Read More',
                  icon: const Icon(Icons.arrow_forward_rounded, color: DColors.textSecondary, size: 20),
                  height: 44,
                  borderWidth: 1.5,
                  iconSlideDistance: 1,
                  textColor: DColors.textPrimary,
                  hoverTextColor: DColors.textPrimary,
                  hoverIconColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
