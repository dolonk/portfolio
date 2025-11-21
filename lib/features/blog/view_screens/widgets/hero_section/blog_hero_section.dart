import 'widgets/blog_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class BlogHeroSection extends StatelessWidget {
  final Function(String) onSearch;

  const BlogHeroSection({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Column(
        children: [
          // Heading with Gradient
          _buildHeading(context, s),
          SizedBox(height: s.paddingMd),

          // Subheading
          _buildSubheading(context, s),
          SizedBox(height: s.spaceBtwSections),

          // Search Bar
          BlogSearchBar(onSearch: onSearch),
        ],
      ),
    );
  }

  /// Heading with Gradient Effect
  Widget _buildHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [DColors.textPrimary, DColors.primaryButton, Color(0xFF8B5CF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text('Flutter Insights & Tutorials', style: fonts.displayLarge, textAlign: TextAlign.center),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, duration: 600.ms);
  }

  /// Subheading
  Widget _buildSubheading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Container(
      constraints: BoxConstraints(
        maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
      ),
      child: Text(
        'Learn best practices, advanced techniques, and real-world solutions for Flutter development',
        style: fonts.bodyLarge.rubik(color: DColors.textSecondary),
        textAlign: TextAlign.center,
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, duration: 600.ms, delay: 200.ms);
  }
}
