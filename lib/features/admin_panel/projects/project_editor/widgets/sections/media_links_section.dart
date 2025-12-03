import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../../common_function/widgets/custom_text_field.dart';

class MediaLinksSection extends StatelessWidget {
  final List<String> galleryImages;
  final TextEditingController demoVideoUrlController;
  final TextEditingController liveUrlController;
  final TextEditingController appStoreUrlController;
  final TextEditingController playStoreUrlController;
  final TextEditingController githubUrlController;
  final ValueChanged<List<String>> onGalleryChanged;

  const MediaLinksSection({
    super.key,
    required this.galleryImages,
    required this.demoVideoUrlController,
    required this.liveUrlController,
    required this.appStoreUrlController,
    required this.playStoreUrlController,
    required this.githubUrlController,
    required this.onGalleryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: DColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(context),
          SizedBox(height: s.paddingLg),

          // Gallery Images (Placeholder)
          _buildGallerySection(context, s),
          SizedBox(height: s.paddingLg),

          Divider(color: DColors.cardBorder),
          SizedBox(height: s.paddingLg),

          // URLs
          Text(
            'Project Links',
            style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingMd),

          CustomTextField(
            controller: demoVideoUrlController,
            label: 'Demo Video URL',
            hint: 'YouTube or Vimeo link',
            prefixIcon: Icon(Icons.play_circle_rounded),
          ),
          SizedBox(height: s.paddingMd),

          CustomTextField(
            controller: liveUrlController,
            label: 'Live URL',
            hint: 'https://example.com',
            prefixIcon: Icon(Icons.link_rounded),
          ),
          SizedBox(height: s.paddingMd),

          CustomTextField(
            controller: appStoreUrlController,
            label: 'App Store URL',
            hint: 'https://apps.apple.com/...',
            prefixIcon: Icon(Icons.apple_rounded),
          ),
          SizedBox(height: s.paddingMd),

          CustomTextField(
            controller: playStoreUrlController,
            label: 'Play Store URL',
            hint: 'https://play.google.com/...',
            prefixIcon: Icon(Icons.android_rounded),
          ),
          SizedBox(height: s.paddingMd),

          CustomTextField(
            controller: githubUrlController,
            label: 'GitHub URL',
            hint: 'https://github.com/...',
            prefixIcon: Icon(Icons.code_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.perm_media_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Media & Links',
          style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildGallerySection(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery Images',
          style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
        ),
        SizedBox(height: s.paddingSm),
        Text(
          'Add screenshots or images for the gallery',
          style: context.fonts.bodySmall.rubik(color: DColors.textSecondary),
        ),
        SizedBox(height: s.paddingMd),

        // Gallery Grid
        if (galleryImages.isEmpty)
          InkWell(
            onTap: () {
              // TODO: Implement multi-image picker
              final updated = List<String>.from(galleryImages)..add('assets/portfolio/ecommerce/main.png');
              onGalleryChanged(updated);
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: DColors.background,
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                border: Border.all(color: DColors.cardBorder, width: 2, style: BorderStyle.solid),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate_rounded, size: 40, color: DColors.textSecondary),
                    SizedBox(height: s.paddingSm),
                    Text(
                      'Add gallery images',
                      style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          Wrap(
            spacing: s.paddingSm,
            runSpacing: s.paddingSm,
            children: [
              ...galleryImages.asMap().entries.map((entry) {
                final index = entry.key;
                final image = entry.value;
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(s.borderRadiusSm),
                      child: Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () {
                          final updated = List<String>.from(galleryImages)..removeAt(index);
                          onGalleryChanged(updated);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.red.shade400, shape: BoxShape.circle),
                          child: Icon(Icons.close_rounded, color: Colors.white, size: 16),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
              // Add More Button
              InkWell(
                onTap: () {
                  // TODO: Add more images
                  final updated = List<String>.from(galleryImages)
                    ..add('assets/portfolio/ecommerce/main.png');
                  onGalleryChanged(updated);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: DColors.background,
                    borderRadius: BorderRadius.circular(s.borderRadiusSm),
                    border: Border.all(color: DColors.cardBorder, style: BorderStyle.solid),
                  ),
                  child: Icon(Icons.add_rounded, color: DColors.textSecondary),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
