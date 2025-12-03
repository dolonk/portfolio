import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';

class GalleryImage extends StatefulWidget {
  final String imagePath;
  final String? caption;
  final VoidCallback onTap;

  const GalleryImage({super.key, required this.imagePath, this.caption, required this.onTap});

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with Hover Effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((255 * 0.1).round()),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Image
                    AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: _isHovered ? 1.1 : 1.0,
                      child: Image.asset(
                        widget.imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: DColors.cardBackground,
                            child: Center(child: Icon(Icons.image_rounded, size: 64, color: DColors.textSecondary)),
                          );
                        },
                      ),
                    ),

                    // Hover Overlay
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _isHovered ? 1.0 : 0.0,
                      child: Container(
                        color: Colors.black.withAlpha((255 * 0.6).round()),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search_rounded, size: 48, color: Colors.white),
                              SizedBox(height: s.paddingSm),
                              Text(
                                'View',
                                style: fonts.labelLarge.rubik(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Caption (if provided)
            if (widget.caption != null) ...[
              SizedBox(height: s.paddingMd),
              Text(
                widget.caption!,
                style: fonts.bodySmall.rubik(color: DColors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
