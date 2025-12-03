import 'widgets/gallery_image.dart';
import 'widgets/image_lightbox.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class GallerySection extends StatelessWidget {
  final List<String> imagesGallery;

  const GallerySection({super.key, required this.imagesGallery});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          _buildSectionHeading(context, s),
          SizedBox(height: s.spaceBtwItems),

          // Image Gallery Grid
          _buildGalleryGrid(context, s),
        ],
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Image Gallery', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text(
          'Screenshots and mockups showcasing the application',
          style: fonts.bodyLarge.rubik(color: DColors.textSecondary),
        ),
      ],
    );
  }

  /// Gallery Grid with Wrap Layout
  Widget _buildGalleryGrid(BuildContext context, DSizes s) {
    final images = imagesGallery;
    final captions = _getImageCaptions();
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = context.responsiveValue(
          mobile: double.infinity,
          tablet:  (constraints.maxWidth - s.spaceBtwItems) / 2,
          desktop: (1100 - s.spaceBtwItems * 2) / 3,
        );
        return Wrap(
          spacing: s.spaceBtwItems,
          runSpacing: s.spaceBtwItems,
          children: List.generate(images.length, (index) {
            return SizedBox(
              width: context.isMobile ? double.infinity : cardWidth,
              child: GalleryImage(
                imagePath: images[index],
                caption: captions.length > index ? captions[index] : null,
                onTap: () {
                  _openLightbox(context, index, captions);
                },
              ),
            );
          }),
        );
      },
    );
  }

  /// Open Lightbox
  void _openLightbox(BuildContext context, int initialIndex, List<String> captions) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => ImageLightbox(
        images: imagesGallery,
        initialIndex: initialIndex,
        captions: captions.isNotEmpty ? captions : null,
      ),
    );
  }

  /// Get Image Captions (optional)
  List<String> _getImageCaptions() {
    // In production, these would come from the model
    return [
      'Home screen with featured products and categories',
      'Product detail page with high-quality images',
      'Shopping cart with real-time price calculations',
      'Secure checkout with multiple payment options',
    ];
  }
}
