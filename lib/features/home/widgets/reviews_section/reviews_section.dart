import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:portfolio/utility/constants/icon_string.dart';
import 'package:portfolio/utility/responsive/section_container.dart';
import '../../../../data_layer/model/home/reviews_model.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/utility/responsive/responsive_helper.dart';
import 'package:portfolio/utility/responsive/responsive_widget.dart';
import 'package:portfolio/features/home/widgets/reviews_section/widgets/reviews_card.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  List<ReviewsModel> _getReviewsData() {
    return [
      ReviewsModel(
        name: "UJJOL KD",
        role: "Startup Founder of Dayzo",
        rating: 5,
        imagePath: "assets/home/icon/sul.png",
        quote:
            "Working with this team was a game changer. They delivered a fully functional iOS and Android app ahead of schedule with flawless performance. The communication was clear and responsive throughout the process.",
      ),
      ReviewsModel(
        name: "Mir Sultan",
        role: "Startup Founder of Space IT",
        rating: 5,
        imagePath: "assets/home/icon/sul.png",
        quote:
            "Working with this developer was a game changer. The communication was clear and responsive throughout the process. Highly recommended!",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.only( left: s.paddingMd, right: s.paddingMd,),
      child: Container(
        decoration: BoxDecoration(gradient: DColors.reviewsSectionGradient),
        child: ResponsiveWidget(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
          desktop: _buildDesktopLayout(context),
        ),
      ),
    );
  }

  // 📱 Mobile Layout
  Widget _buildMobileLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwSections),
        _buildReviewsCards(context, isMobile: true),
      ],
    );
  }

  // 📱 Tablet Layout
  Widget _buildTabletLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context),
        SizedBox(height: s.spaceBtwSections),
        _buildReviewsCards(context, isMobile: false),
      ],
    );
  }

  // 💻 Desktop Layout
  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildSectionHeader(context)),
            SizedBox(width: s.spaceBtwItems16),

            Expanded(
              flex: 3,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: -100,
                    bottom: -90,
                    child: Container(
                      width: 260,
                      height: 240,
                      decoration: BoxDecoration(shape: BoxShape.circle, gradient: DColors.pinkGradient),
                    ),
                  ),
                  _buildReviewsCards(context, isMobile: false),
                  Positioned(
                    top: -34,
                    left: 0,
                    child: SvgPicture.asset(
                      DIcons.quoteIcon,
                      width: 60,
                      height: 60,
                      colorFilter: ColorFilter.mode(DColors.primaryButton, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: context.sizes.spaceBtwSections * 2),
      ],
    );
  }

  // SECTION HEADER
  Widget _buildSectionHeader(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      crossAxisAlignment: context.isMobile || context.isTablet ? .center : .start,
      children: [
        // Subtitle
        Text("Reviews", style: fonts.headlineMedium.rajdhani(color: DColors.primaryButton)),
        SizedBox(height: s.paddingSm),

        // Title
        RichText(
          text: TextSpan(
            style: fonts.displayLarge,
            children: [
              const TextSpan(text: "What Clients "),
              TextSpan(
                text: "Say",
                style: TextStyle(color: DColors.primaryButton),
              ),
            ],
          ),
        ),
        SizedBox(height: s.spaceBtwItems),

        // Description
        SizedBox(
          width: context.isDesktop ? 350 : double.infinity,
          child: Text(
            "Android app ahead of schedule with flawless performance. The communication was clear and responsive throughout.",
            style: fonts.labelLarge.rajdhani(color: DColors.textSecondary, height: 1.6),
            maxLines: 4,
            textAlign: context.isMobile || context.isTablet ? TextAlign.center : TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Reviews CARDS
  Widget _buildReviewsCards(BuildContext context, {required bool isMobile}) {
    final s = context.sizes;
    final reviews = _getReviewsData();

    if (isMobile) {
      return Column(
        children: reviews
            .map(
              (review) => Padding(
                padding: EdgeInsets.only(bottom: s.spaceBtwItems),
                child: ReviewsCard(reviews: review),
              ),
            )
            .toList(),
      );
    }

    return CarouselSlider.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index, realIndex) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ReviewsCard(reviews: review),
        );
      },
      options: CarouselOptions(
        height: context.isTablet ? 220 : 246,
        padEnds: false,
        autoPlay: true,
        enlargeFactor: 0.3,
        viewportFraction: 0.6,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        scrollPhysics: NeverScrollableScrollPhysics(),
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayOnManualNavigate: true,
      ),
    );
  }
}
