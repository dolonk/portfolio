import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';

class FileUploadWidget extends StatefulWidget {
  final void Function(String?) onFileSelected;

  const FileUploadWidget({super.key, required this.onFileSelected});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  String? _fileName;
  bool _isHovered = false;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'zip'],
        withData: false,
        withReadStream: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        // Check file size (max 10MB)
        if (file.size > 10 * 1024 * 1024) {
          _showError('File size must be less than 10MB');
          return;
        }

        setState(() => _fileName = file.name);
        widget.onFileSelected(file.name);
      }
    } catch (e) {
      _showError('Error picking file: $e');
    }
  }

  void _removeFile() {
    setState(() => _fileName = null);
    widget.onFileSelected(null);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red.shade400));
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Icon(Icons.attach_file_rounded, size: 18, color: DColors.textPrimary),
            SizedBox(width: s.paddingSm * 0.5),
            Text(
              'Attach Files (Optional)',
              style: fonts.bodyMedium.rubik(fontWeight: FontWeight.w600, color: DColors.textPrimary),
            ),
          ],
        ),
        SizedBox(height: s.paddingSm),

        // Upload Container
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _fileName == null ? _pickFile : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: EdgeInsets.all(s.paddingLg),
              decoration: BoxDecoration(
                color: _isHovered && _fileName == null
                    ? DColors.primaryButton.withAlpha((255 * 0.05).round())
                    : DColors.secondaryBackground,
                border: Border.all(
                  color: _isHovered && _fileName == null ? DColors.primaryButton : DColors.cardBorder,
                  width: 2,
                  style: _fileName == null ? BorderStyle.solid : BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
              ),
              child: _fileName == null ? _buildUploadPrompt(fonts, s) : _buildFileInfo(fonts, s),
            ),
          ),
        ),

        // File format info
        SizedBox(height: s.paddingSm),
        Text('Supported: PDF, DOC, DOCX, ZIP (Max 10MB)', style: fonts.bodySmall.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  Widget _buildUploadPrompt(AppFonts fonts, DSizes s) {
    return Column(
      children: [
        Icon(Icons.cloud_upload_outlined, size: 40, color: DColors.primaryButton.withAlpha((255 * 0.5).round())),
        SizedBox(height: s.paddingSm),
        Text(
          'Click to upload or drag and drop',
          style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFileInfo(AppFonts fonts, DSizes s) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(s.paddingSm),
          decoration: BoxDecoration(
            color: DColors.primaryButton.withAlpha((255 * 0.15).round()),
            borderRadius: BorderRadius.circular(s.borderRadiusSm),
          ),
          child: Icon(Icons.description_outlined, color: DColors.primaryButton, size: 24),
        ),
        SizedBox(width: s.paddingMd),
        Expanded(
          child: Text(
            _fileName!,
            style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: _removeFile,
          icon: const Icon(Icons.close_rounded),
          color: Colors.red.shade400,
          tooltip: 'Remove file',
        ),
      ],
    );
  }
}
