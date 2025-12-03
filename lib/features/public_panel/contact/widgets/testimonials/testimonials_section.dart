import 'widgets/testimonial_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:portfolio/common_function/widgets/section_header.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import 'package:portfolio/data_layer/model/contact/testimonial_model.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final testimonials = TestimonialModel.getAllTestimonials();

    return SectionContainer(
      backgroundColor: DColors.secondaryBackground,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Column(
        children: [
          DSectionHeader(
            label: 'NEXT STEPS',
            title: 'What Happens Next?',
            subtitle: 'Here\'s my transparent process from first contact to project completion',
            alignment: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwSections),

          Column(
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
        ],
      ),
    );
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
          onPressed: () =>
              _carouselController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
        ),
        SizedBox(width: s.paddingLg),
        _buildArrowButton(
          icon: Icons.arrow_forward_ios_rounded,
          onPressed: () =>
              _carouselController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
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
