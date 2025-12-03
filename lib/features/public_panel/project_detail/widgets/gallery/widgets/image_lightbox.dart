import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';

class ImageLightbox extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final List<String>? captions;

  const ImageLightbox({super.key, required this.images, required this.initialIndex, this.captions});

  @override
  State<ImageLightbox> createState() => _ImageLightboxState();
}

class _ImageLightboxState extends State<ImageLightbox> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _nextImage() {
    if (_currentIndex < widget.images.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withAlpha((255 * 0.9).round()),
          child: Stack(
            children: [
              // Main Image (Center)
              Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent closing when clicking image
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: Image.asset(
                      widget.images[_currentIndex],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: DColors.cardBackground,
                          child: Center(
                            child: Icon(Icons.broken_image_rounded, size: 100, color: DColors.textSecondary),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Close Button (Top-Right)
              Positioned(
                top: s.paddingLg,
                right: s.paddingLg,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close_rounded, color: Colors.white, size: 32),
                  style: IconButton.styleFrom(backgroundColor: Colors.black.withAlpha((255 * 0.5).round())),
                ),
              ),

              // Previous Button (Left)
              if (_currentIndex > 0)
                Positioned(
                  left: s.paddingLg,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      onPressed: _previousImage,
                      icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 32),
                      style: IconButton.styleFrom(backgroundColor: Colors.black.withAlpha((255 * 0.5).round())),
                    ),
                  ),
                ),

              // Next Button (Right)
              if (_currentIndex < widget.images.length - 1)
                Positioned(
                  right: s.paddingLg,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      onPressed: _nextImage,
                      icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 32),
                      style: IconButton.styleFrom(backgroundColor: Colors.black.withAlpha((255 * 0.5).round())),
                    ),
                  ),
                ),

              // Image Counter & Caption (Bottom)
              Positioned(
                bottom: s.paddingLg,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Counter
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha((255 * 0.7).round()),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentIndex + 1} of ${widget.images.length}',
                        style: fonts.bodyMedium.rubik(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),

                    // Caption (if available)
                    if (widget.captions != null && widget.captions![_currentIndex].isNotEmpty) ...[
                      SizedBox(height: s.paddingMd),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
                        margin: EdgeInsets.symmetric(horizontal: s.paddingXl),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha((255 * 0.7).round()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.captions![_currentIndex],
                          style: fonts.bodyMedium.rubik(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
