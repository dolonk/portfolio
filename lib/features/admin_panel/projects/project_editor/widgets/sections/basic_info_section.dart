import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/utility/snack_bar_toast/snack_bar.dart';
import '../../../../../../../utility/constants/colors.dart';
import '../../../../../../../utility/default_sizes/font_size.dart';
import '../../../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../../../common_function/widgets/custom_text_field.dart';
import '../../../../../../common_function/widgets/custom_dropdown.dart';
import '../../../../../../core/config/supabase_config.dart';

class BasicInfoSection extends StatefulWidget {
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
  State<BasicInfoSection> createState() => _BasicInfoSectionState();
}

class _BasicInfoSectionState extends State<BasicInfoSection> {
  final supabaseUploader = SupabaseConfig();
  bool _isUploading = false;
  bool _isDeleting = false;

  /// Handles picking and uploading an image to Supabase.
  Future<void> _pickAndUploadImage() async {
    if (_isUploading) return;
    setState(() => _isUploading = true);

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);

      // If user cancels the picker, stop the loading indicator.
      if (result == null) {
        if (mounted) setState(() => _isUploading = false);
        return;
      }

      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      if (fileBytes == null) throw Exception('Failed to read file bytes');

      final String imageUrl = await supabaseUploader.uploadImage(
        fileBytes: fileBytes,
        bucketName: SupabaseConfig.projectImagesBucket,
        folder: 'project-covers',
        fileName: fileName,
      );

      // Update parent widget with the new image URL
      widget.onImageChanged(imageUrl);
    } catch (e) {
      DSnackBar.error(title: 'Image upload failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  /// Handles deleting an image from Supabase and updating the UI.
  Future<void> _deleteImage() async {
    if (_isDeleting) return;
    setState(() => _isDeleting = true);

    try {
      await supabaseUploader.deleteImage(
        bucketName: SupabaseConfig.projectImagesBucket,
        imageUrlOrPath: widget.imagePath,
      );
      // Notify state
      widget.onImageChanged('');
      DSnackBar.success(title: 'Image successfully deleted.');
    } catch (e) {
      DSnackBar.error(title: 'Failed to delete image: $e');
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

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
            controller: widget.titleController,
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
            controller: widget.taglineController,
            label: 'Tagline',
            hint: 'Short catchy tagline',
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Tagline is required';
              return null;
            },
          ),
          SizedBox(height: s.paddingMd),

          // Category Dropdown
          CustomDropdown<String>(
            label: 'Category',
            hint: 'Select category',
            value: widget.category,
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
              if (value != null) widget.onCategoryChanged(value);
            },
            isRequired: true,
          ),
          SizedBox(height: s.paddingMd),

          // Cover Image Picker (Placeholder)
          _buildImagePicker(context, s),
          SizedBox(height: s.paddingMd),

          // Description Field
          CustomTextField(
            controller: widget.descriptionController,
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
        Text('Basic Information', style: context.fonts.titleLarge),
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
          width: double.infinity,
          decoration: BoxDecoration(
            color: DColors.background,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            border: Border.all(color: DColors.cardBorder, width: 2),
          ),
          child: widget.imagePath.isEmpty
              ? _isUploading
                    ? const Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: _pickAndUploadImage,
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
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(s.borderRadiusMd - 2),
                      child: Image.network(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        // Shows a progress indicator while the image is loading from the network
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.error, color: Colors.red)),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: _isDeleting ? null : _deleteImage,
                        icon: _isDeleting
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0),
                              )
                            : const Icon(Icons.close_rounded, color: Colors.white),
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
