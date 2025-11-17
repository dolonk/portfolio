import 'dart:async';
import 'widgets/testimonial_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/data_layer/model/contact/testimonial_model.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;
  Timer? _autoPlayTimer;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isHovered && mounted) {
        final testimonials = TestimonialModel.getAllTestimonials();
        final nextIndex = (_currentIndex + 1) % testimonials.length;
        _carouselController.animateToPage(nextIndex);
      }
    });
  }

  void _onHoverEnter() {
    setState(() => _isHovered = true);
  }

  void _onHoverExit() {
    setState(() => _isHovered = false);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final testimonials = TestimonialModel.getAllTestimonials();

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Column(
        children: [
          _buildSectionHeading(context, s),
          SizedBox(height: s.spaceBtwSections),
          MouseRegion(
            onEnter: (_) => _onHoverEnter(),
            onExit: (_) => _onHoverExit(),
            child: Column(
              children: [
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: testimonials.length,
                  itemBuilder: (context, index, realIndex) {
                    return TestimonialCard(testimonial: testimonials[index]);
                  },
                  options: CarouselOptions(
                    height: context.responsiveValue(mobile: 300.0, tablet: 380.0, desktop: 400.0),
                    viewportFraction: context.responsiveValue(mobile: 1, tablet: 0.7, desktop: 0.6),
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 6),
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index, reason) {
                      setState(() => _currentIndex = index);
                    },
                  ),
                ),
                SizedBox(height: s.spaceBtwItems),
                _buildPaginationDots(s, testimonials.length),
                SizedBox(height: s.spaceBtwItems),
                if (context.isDesktop) _buildNavigationArrows(s),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        Text(
          'What Clients Say',
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
            'Trusted by businesses worldwide',
            style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, duration: 600.ms);
  }

  Widget _buildPaginationDots(DSizes s, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == _currentIndex;

        return GestureDetector(
          onTap: () => _carouselController.animateToPage(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isActive ? 24 : 8,
            height: 8,
            margin: EdgeInsets.symmetric(horizontal: s.paddingSm * 0.5),
            decoration: BoxDecoration(
              color: isActive ? DColors.primaryButton : DColors.cardBorder,
              borderRadius: BorderRadius.circular(s.borderRadiusSm),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationArrows(DSizes s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildArrowButton(
          icon: Icons.arrow_back_ios_rounded,
          onPressed: () => _carouselController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ),
        ),
        SizedBox(width: s.paddingLg),
        _buildArrowButton(
          icon: Icons.arrow_forward_ios_rounded,
          onPressed: () => _carouselController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ),
        ),
      ],
    );
  }

  Widget _buildArrowButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: DColors.primaryButton,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
