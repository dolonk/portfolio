import ' widgets/link_button.dart';
import ' widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/data_layer/model/portfolio/project_model.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class DemoLinksSection extends StatelessWidget {
  final ProjectModel project;

  const DemoLinksSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          _buildSectionHeading(context, s),
          SizedBox(height: s.spaceBtwSections),

          // YouTube Video Player - Show only if URL is not null and not empty
          if (project.demoVideoUrl.isNotEmpty) Center(child: YouTubeVideoPlayer(videoUrl: project.demoVideoUrl)),
          SizedBox(height: s.spaceBtwSections),

          // Links Grid
          _buildLinksGrid(context, s),
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
        Text('Project Demo & Links', style: fonts.displaySmall),
        SizedBox(height: s.paddingSm),
        Text('Watch the demo and access the project', style: fonts.bodyLarge.rubik(color: DColors.textSecondary)),
      ],
    );
  }

  /// Links Grid with Wrap Layout
  Widget _buildLinksGrid(BuildContext context, DSizes s) {
    final links = _getAvailableLinks(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = context.responsiveValue(
          mobile: (constraints.maxWidth - s.spaceBtwItems) / 2,
          tablet: (1000 - s.spaceBtwItems * 3) / 4,
          desktop: (1100 - s.spaceBtwItems * 4) / 5,
        );
        return Wrap(
          spacing: s.spaceBtwItems,
          runSpacing: s.spaceBtwItems,
          children: links.map((link) {
            return SizedBox(
              width: cardWidth,
              child: LinkButton(
                icon: link['icon'] as IconData,
                label: link['label'] as String,
                url: link['url'] as String?,
                color: link['color'] as Color,
                onPressed: link['onPressed'] as VoidCallback?,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  /// Get Available Links (Hide if URL is null or empty)
  List<Map<String, dynamic>> _getAvailableLinks(BuildContext context) {
    final links = <Map<String, dynamic>>[];

    // Live Demo
    if (project.liveUrl != null && project.liveUrl!.isNotEmpty) {
      links.add({
        'icon': FontAwesomeIcons.globe,
        'label': 'Live Demo',
        'url': project.liveUrl!,
        'color': const Color(0xFF3B82F6),
      });
    }

    // App Store
    if (project.appStoreUrl != null && project.appStoreUrl!.isNotEmpty) {
      links.add({
        'icon': FontAwesomeIcons.apple,
        'label': 'App Store',
        'url': project.appStoreUrl!,
        'color': const Color(0xFF7B1414),
      });
    }

    // Play Store
    if (project.playStoreUrl != null && project.playStoreUrl!.isNotEmpty) {
      links.add({
        'icon': FontAwesomeIcons.googlePlay,
        'label': 'Google Play',
        'url': project.playStoreUrl!,
        'color': const Color(0xFF3DDC84),
      });
    }

    // github
    if (project.githubUrl.isNotEmpty) {
      links.add({
        'icon': FontAwesomeIcons.github,
        'label': 'Source Code',
        'onPressed': () => _showRequestSourceCodeDialog(context, project),
        'color': const Color(0xFF2d3436),
      });
    }

    return links;
  }
}

void _showRequestSourceCodeDialog(BuildContext context, ProjectModel project) {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      // --- Dialog Styling Starts ---
      backgroundColor: DColors.secondaryCard, // ডার্ক ব্যাকগ্রাউন্ড
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // গোলাকার বর্ডার
        side: BorderSide(color: DColors.cardBorder, width: 1), // হালকা বর্ডার
      ),
      title: Row(
        children: [
          Icon(FontAwesomeIcons.paperPlane, color: DColors.primaryButton, size: 22),
          SizedBox(width: 12),
          Text('Get Source Code', style: TextStyle(color: DColors.textPrimary)),
        ],
      ),
      titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: DColors.textPrimary),

      // --- Dialog Styling Ends ---
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To receive the source code link, please provide your email address.',
              style: TextStyle(color: DColors.textSecondary),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              style: TextStyle(color: DColors.textPrimary), // লেখার রঙ
              decoration: InputDecoration(
                labelText: 'Your Email',
                labelStyle: TextStyle(color: DColors.textSecondary),
                prefixIcon: Icon(Icons.email_outlined, color: DColors.textSecondary),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: DColors.cardBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: DColors.primaryButton),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary)),
        ),
        // Submit Button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: DColors.primaryButton,
            foregroundColor: DColors.textPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context);

              // --- Centered Toast (SnackBar) ---
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  width: 350,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: DColors.primaryButton.withAlpha((255 * 0.9).round()),
                  duration: Duration(seconds: 3),
                  content: Center(
                    child: Text(
                      'Thank you! The link will be sent shortly.',
                      style: TextStyle(color: DColors.textPrimary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }
          },
          child: Text('Submit', style: context.fonts.bodyMedium),
        ),
      ],
    ),
  );
}
