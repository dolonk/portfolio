import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../data_layer/model/home/blog_model.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../common_function/style/hoverable_card.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';

class BlogCard extends StatefulWidget {
  final BlogModel blog;

  const BlogCard({super.key, required this.blog});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  late AnimationController _animationController;
  late Animation<double> _buttonSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for button
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    // Button arrow slide animation
    _buttonSlideAnimation = Tween<double>(
      begin: 0.0,
      end: 4.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Handle button hover
  void _onButtonHover(bool isHovered) {
    setState(() {
      _isButtonHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return HoverableCard(
      padding: const EdgeInsets.all(8),
      onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BLOG IMAGE WITH ZOOM & OVERLAY
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
                  // Image with zoom animation
                  AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    scale: _isHovered ? 1.1 : 1.0,
                    child: Image.asset(
                      widget.blog.imagePath,
                      fit: BoxFit.cover,
                      cacheHeight: 400,
                      cacheWidth: 400,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),

                  // Gradient overlay on hover
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, DColors.primaryButton.withAlpha((255 * 0.6).round())],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: s.paddingSm),

          // BLOG CONTENT
          Padding(
            padding: EdgeInsets.symmetric(horizontal: s.paddingXs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Badge
                Text(
                  widget.blog.category,
                  style: fonts.bodySmall.rubik(color: DColors.primaryButton, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: s.spaceBtwItems / 2),

                // Title
                Text(
                  widget.blog.title,
                  style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: s.spaceBtwItems / 2),

                // Description
                Text(
                  widget.blog.description,
                  style: fonts.labelMedium.rubik(color: DColors.textSecondary, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: s.spaceBtwItems),

                // READ MORE BUTTON
                _buildReadMoreButton(context, s, fonts),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // READ MORE BUTTON BUILDER
  Widget _buildReadMoreButton(BuildContext context, DSizes s, AppFonts fonts) {
    return MouseRegion(
      onEnter: (_) => _onButtonHover(true),
      onExit: (_) => _onButtonHover(false),
      child: GestureDetector(
        onTap: () {
          context.go('/blog');
          debugPrint('Read blog: ${widget.blog.title}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: _isButtonHovered ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
            border: Border.all(color: _isButtonHovered ? DColors.primaryButton : DColors.cardBorder, width: 1.5),
            boxShadow: _isButtonHovered
                ? [
                    BoxShadow(
                      color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button text
              Text('Read More', style: fonts.labelLarge),
              const SizedBox(width: 4),

              // Animated arrow icon
              AnimatedBuilder(
                animation: _buttonSlideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_buttonSlideAnimation.value, 0),
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
