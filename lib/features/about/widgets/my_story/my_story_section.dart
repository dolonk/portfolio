import 'dart:math';
import 'widgets/quote_box.dart';
import 'widgets/story_paragraph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../common_function/widgets/section_header.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';

class MyStorySection extends StatelessWidget {
  const MyStorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only(left: s.paddingMd, right: s.paddingMd, bottom: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 900, desktop: 1400),
          ),
          child: Column(
            children: [
              const DSectionHeader(
                label: 'JOURNEY',
                title: 'My Story',
                subtitle: 'How I became a Flutter developer',
                alignment: TextAlign.center,
              ),
              SizedBox(height: s.spaceBtwItems),
              _buildStoryContent(context, s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryContent(BuildContext context, DSizes s) {
    final isMobile = context.isMobile;
    final storyText = _buildStoryText(context, s);
    final illustration = _buildIllustration(context, s);

    if (isMobile) {
      return Column(
        children: [
          illustration,
          SizedBox(height: s.spaceBtwItems),
          storyText,
          const _QuoteAndMission(),
        ],
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 4, child: illustration),
            SizedBox(width: s.spaceBtwSections),
            Expanded(flex: 6, child: storyText),
          ],
        ),
        const _QuoteAndMission(),
      ],
    );
  }

  Widget _buildIllustration(BuildContext context, DSizes s) {
    final gradientColors = [
      DColors.primaryButton.withAlpha(38),
      const Color(0xFF8B5CF6).withAlpha(38),
      const Color(0xFF10B981).withAlpha(38),
    ];

    return Container(
          width: double.infinity,
          height: context.responsiveValue(mobile: 250.0, tablet: 400.0, desktop: 460.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: gradientColors),
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            border: Border.all(color: DColors.primaryButton.withAlpha(76), width: 2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(s.borderRadiusLg - 2),
                  child: CustomPaint(painter: _CodePatternPainter()),
                ),
              ),
              _buildIllustrationContent(context, s),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 200.ms)
        .scale(begin: const Offset(0.95, 0.95), duration: 800.ms, delay: 200.ms);
  }

  Widget _buildIllustrationContent(BuildContext context, DSizes s) {
    final iconSize = context.responsiveValue(mobile: 60.0, tablet: 80.0, desktop: 100.0);
    final fontSize = context.responsiveValue(mobile: 20.0, tablet: 24.0, desktop: 28.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.code_rounded,
          size: iconSize,
          color: DColors.primaryButton.withAlpha(204), // ~0.8 * 255
        ),
        SizedBox(height: s.paddingMd),
        Text(
          'From Code\nTo Creation',
          style: context.fonts.headlineSmall.rajdhani(
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStoryText(BuildContext context, DSizes s) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StoryParagraph(delay: 300, text: _StoryTexts.beginning),
        StoryParagraph(delay: 400, text: _StoryTexts.flutterRevelation),
      ],
    );
  }
}

class _QuoteAndMission extends StatelessWidget {
  const _QuoteAndMission();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        QuoteBox(quote: _StoryTexts.quote, author: 'Dolon Kumar Mondol'),
        StoryParagraph(delay: 500, text: _StoryTexts.mission),
      ],
    );
  }
}

class _StoryTexts {
  static const String beginning =
      'My journey in software development began with a passion for creating solutions that make a difference. After graduating from Bangladesh University of Business and Technology (BUBT) in 2022 with a degree in Computer Science & Engineering, I dove deep into the world of mobile application development.\n\n'
      'I started exploring both native Android (Java, Kotlin) and iOS (Swift) development, gaining valuable insights into platform-specific nuances. This foundation of understanding both ecosystems would later become instrumental in my Flutter journey.';

  static const String flutterRevelation =
      'What started as curiosity about cross-platform development quickly evolved into a love affair with Flutter. The ability to create beautiful, performant applications for mobile, web, and desktop from a single codebase fascinated me. In April 2023, I joined THT Space Electrical Company LTD as a Software Engineer, where I\'ve been architecting scalable solutions ever since.';

  static const String quote =
      'I don\'t just write code – I architect solutions that balance modern design, optimal performance, and exceptional user experience.';

  static const String mission =
      'Today, I specialize in advanced Flutter techniques that go beyond the basics. Multi-threading with Isolates, native code integration through FFI, custom animations and painting, CI/CD automation – these aren\'t just buzzwords in my CV; they\'re tools I use daily to solve real-world problems.\n\n'
      'With over 2 years of hands-on Flutter experience and 10+ projects under my belt, including 2 live applications on App Store and Play Store, I\'ve learned that great development is about more than technical skills. It\'s about understanding user needs, writing clean maintainable code, and delivering solutions that drive business value.\n\n'
      'My mission is clear: leverage cutting-edge technology to create innovative, efficient, and scalable applications that not only meet business goals but exceed user expectations. Whether it\'s implementing state-of-the-art state management, optimizing performance, or creating pixel-perfect UIs, I approach every project with dedication and a problem-solving mindset.';
}

/// Custom Painter for Code Pattern Background
class _CodePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final symbols = [
      'Widget',
      '{...}',
      'build(context)',
      '=>',
      'final',
      'const',
      'Container()',
      '</>',
      'async',
      'await',
      'Future<void>',
      'class',
      'setState',
      'void main()',
      'Stream',
      'Navigator.push',
      'Color(0xff)',
      'Alignment.center',
      '...',
      'runApp(MyApp());',
    ];

    final random = Random();

    for (int i = 0; i < 25; i++) {
      final text = symbols[random.nextInt(symbols.length)];
      final fontSize = 14 + random.nextDouble() * 10;
      final opacity = 0.1 + random.nextDouble() * 0.2;

      final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: DColors.primaryButton.withAlpha((255 * opacity).round()),
            fontSize: fontSize,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final x = random.nextDouble() * (size.width - textPainter.width);
      final y = random.nextDouble() * (size.height - textPainter.height);

      canvas.save();
      canvas.translate(x + textPainter.width / 2, y + textPainter.height / 2);
      final rotation = (random.nextDouble() - 0.5) * (pi / 12);
      canvas.rotate(rotation);
      canvas.translate(-(x + textPainter.width / 2), -(y + textPainter.height / 2));

      textPainter.paint(canvas, Offset(x, y));

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
