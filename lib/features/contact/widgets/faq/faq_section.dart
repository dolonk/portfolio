import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/data_layer/model/services/faq_model.dart';
import 'widgets/faq_item.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 700, desktop: 900),
          ),
          child: Column(
            children: [
              // Section Heading
              _buildSectionHeading(context, s),
              SizedBox(height: s.spaceBtwSections),

              // FAQ Items List
              _buildFaqList(context, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Heading
  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        Text(
          'Frequently Asked Questions',
          style: fonts.headlineLarge.rajdhani(
            fontSize: context.responsiveValue(mobile: 28, tablet: 32, desktop: 36),
            fontWeight: FontWeight.bold,
            color: DColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: s.paddingSm),
        Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(mobile: double.infinity, tablet: 600, desktop: 700),
          ),
          child: Text(
            'Everything you need to know before starting your project',
            style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms);
  }

  /// FAQ Items List with Staggered Animation
  Widget _buildFaqList(BuildContext context, DSizes s) {
    final faqs = FaqModel.getAllFaqs();

    return AnimationLimiter(
      child: Column(
        children: List.generate(faqs.length, (index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: FaqItem(
                  faq: faqs[index],
                  isExpanded: _expandedIndex == index,
                  onToggle: () => _toggleFaq(index),
                ),
              ),
            ),
          );
        }),
      ),
    ).animate(delay: 300.ms).fadeIn(duration: 600.ms);
  }

  /// Toggle FAQ (Single Expand Mode)
  void _toggleFaq(int index) {
    setState(() {
      if (_expandedIndex == index) {
        // Clicking same FAQ - collapse it
        _expandedIndex = null;
      } else {
        // Clicking different FAQ - expand it (and collapse previous)
        _expandedIndex = index;
      }
    });
  }
}
