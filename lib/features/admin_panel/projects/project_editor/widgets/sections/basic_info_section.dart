import 'dart:io';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/snack_bar_toast/snack_bar.dart';
import '../../../../../../../utility/constants/colors.dart';
import '../../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../../../common_function/widgets/custom_text_field.dart';
import '../../../../../../common_function/widgets/custom_dropdown.dart';
import '../../../../../../core/config/supabase_config.dart';
import '../../../../../../utility/helpers/file_picker_helper.dart';

class BasicInfoSection extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController taglineController;
  final TextEditingController descriptionController;
  final String category;
  final String imagePath;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onImageChanged;

  const BasicInfoSection({
    super.key,
    required this.titleController,
    required this.taglineController,
    required this.descriptionController,
    required this.category,
    required this.imagePath,
    required this.onCategoryChanged,
    required this.onImageChanged,
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

          // Title Field
          CustomTextField(
            controller: titleController,
            label: 'Project Title',
            hint: 'Enter project title',
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Title is required';
              }
              if (value.trim().length < 3) {
                return 'Title must be at least 3 characters';
              }
              return null;
            },
          ),
          SizedBox(height: s.paddingMd),

          // Tagline Field
          CustomTextField(
            controller: taglineController,
            label: 'Tagline',
            hint: 'Short catchy tagline',
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Tagline is required';
              }
              return null;
            },
          ),
          SizedBox(height: s.paddingMd),

          // Category Dropdown
          CustomDropdown<String>(
            label: 'Category',
            hint: 'Select category',
            value: category,
            items: const [
              'Mobile App',
              'Web Application',
              'Desktop App',
              'Full Stack',
              'UI/UX Design',
              'API Development',
              'Other',
            ],
            itemLabel: (cat) => cat,
            onChanged: (value) {
              if (value != null) onCategoryChanged(value);
            },
            isRequired: true,
          ),
          SizedBox(height: s.paddingMd),

          // Cover Image Picker (Placeholder)
          _buildImagePicker(context, s),
          SizedBox(height: s.paddingMd),

          // Description Field
          CustomTextField(
            controller: descriptionController,
            label: 'Description',
            hint: 'Write a detailed description',
            maxLines: 5,
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Description is required';
              }
              if (value.trim().length < 20) {
                return 'Description must be at least 20 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.info_outline_rounded, color: DColors.primaryButton, size: 24),
        SizedBox(width: 8),
        Text(
          'Basic Information',
          style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildImagePicker(BuildContext context, DSizes s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Cover Image',
            style: context.fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red.shade400),
              ),
            ],
          ),
        ),
        SizedBox(height: s.paddingSm),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: DColors.background,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: DColors.cardBorder, width: 2),
          ),
          child: imagePath.isEmpty
              ? InkWell(
                  onTap: () async {
                    final File? imageFile = await FilePickerHelper.pickSingleImage();
                    if (imageFile == null) return;

                    try {
                      // TODO: একটি লোডিং ইন্ডিকেটর দেখান
                      // যেমন: showDialog(context: context, builder: (_) => Center(child: CircularProgressIndicator()));

                      final supabaseUploader = SupabaseConfig();
                      final String imageUrl = await supabaseUploader.uploadImage(
                        file: imageFile,
                        bucketName: SupabaseConfig.projectImagesBucket,
                        folder: 'project-covers',
                      );

                      // TODO: লোডিং ইন্ডিকেটর লুকান
                      // Navigator.of(context).pop();

                      onImageChanged(imageUrl);
                    } catch (e) {
                      // TODO: লোডিং ইন্ডিকেটর লুকান (যদি দেখানো হয়)
                      // Navigator.of(context).pop();

                      DSnackBar.error(title: 'Image upload failed: $e');
                    }
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_rounded, size: 48, color: DColors.textSecondary),
                        SizedBox(height: s.paddingSm),
                        Text(
                          'Click to upload image',
                          style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(s.borderRadiusMd),
                      child: Image.asset(
                        imagePath,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: () => onImageChanged(''),
                        icon: Icon(Icons.close_rounded, color: Colors.white),
                        style: IconButton.styleFrom(backgroundColor: Colors.red.shade400),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
