import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_website/route/route_name.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/common_function/style/custom_button.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_widget.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';
import 'package:responsive_website/features/home/widgets/get_in_touch/widgets/contact_image.dart';

/*class GetInTouchSection extends StatelessWidget {
  const GetInTouchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: ResponsiveWidget(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  // 📱 Mobile Layout - COMPLETELY NEW APPROACH
  Widget _buildMobileLayout(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFAB2E66), Color(0xFF834BA3), Color(0xFF3F397E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha((255 * 0.3).round()), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ✅ Image at top - centered
          Image.asset(
            "assets/home/projects/contact.png",
            width: 170,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: DColors.cardBorder,
                child: Icon(Icons.image_not_supported_outlined, size: 60, color: Colors.white54),
              );
            },
          ),
          SizedBox(height: s.spaceBtwItems),

          // ✅ Subtitle
          Text(
            "Have Any Projects in Mind?",
            style: fonts.titleLarge.rajdhani(
              fontWeight: FontWeight.w500,
              color: Colors.white.withAlpha((255 * 0.95).round()),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: s.paddingSm),

          // ✅ Main Title
          Text(
            "Get in Touch",
            style: fonts.displayMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // ✅ Contact Button
          ContactButton(),
        ],
      ),
    );
  }

  // 📱 Tablet Layout - Better positioned
  Widget _buildTabletLayout(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFAB2E66), Color(0xFF834BA3), Color(0xFF3F397E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha((255 * 0.3).round()), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Content on left
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Subtitle
              SizedBox(
                width: 400,
                child: Text(
                  "Have Any Projects in Mind?",
                  style: fonts.headlineMedium.rajdhani(
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withAlpha((255 * 0.95).round()),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: s.paddingSm),

              // Main Title
              Text("Get in Touch", style: fonts.displayLarge),
              SizedBox(height: s.spaceBtwItems),

              // Contact Button
              ContactButton(),
            ],
          ),

          // Image on right - better positioned
          Positioned(top: -50, right: 0, child: AnimatedContactImage(height: 300)),
        ],
      ),
    );
  }

  // 💻 Desktop Layout - Original design
  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      height: 320,
      padding: EdgeInsets.symmetric(horizontal: s.paddingLg * 1.5, vertical: s.paddingLg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFAB2E66), Color(0xFF834BA3), Color(0xFF3F397E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha((255 * 0.3).round()), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Subtitle
              SizedBox(
                width: 500,
                child: Text(
                  "Have Any Projects in Mind?",
                  style: fonts.headlineLarge.rajdhani(
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withAlpha((255 * 0.95).round()),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: s.paddingSm),

              // Main Title
              Text("Get in Touch", style: fonts.displayLarge),
              SizedBox(height: s.spaceBtwSections),

              // Contact Button
              ContactButton(),
            ],
          ),

          // Background Image
          Positioned(top: -80, right: 60, child: AnimatedContactImage(height: 300)),
        ],
      ),
    );
  }
}*/

class GetInTouchSection extends StatelessWidget {
  const GetInTouchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      backgroundColor: DColors.background,
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: ResponsiveWidget(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFAB2E66), Color(0xFF834BA3), Color(0xFF3F397E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/home/projects/contact.png",
            width: 170,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: DColors.cardBorder,
                child: Icon(Icons.image_not_supported_outlined, size: 60, color: Colors.white54),
              );
            },
          ),
          SizedBox(height: s.spaceBtwItems),

          Text(
            "Have Any Projects in Mind?",
            style: fonts.titleLarge.rajdhani(
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.95),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: s.paddingSm),

          Text(
            "Get in Touch",
            style: fonts.displayMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // ✅ IMPROVED: Using CustomButton
          CustomButton(
            width: double.infinity,
            height: 50,
            tittleText: 'Contact Us',
            isPrimary: false, // Outline button for contrast
            foregroundColor: Colors.white,
            onPressed: () => context.go(RouteNames.contact),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(s.paddingMd),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFAB2E66), Color(0xFF834BA3), Color(0xFF3F397E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: Text(
                  "Have Any Projects in Mind?",
                  style: fonts.headlineLarge.rajdhani(
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.95),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: s.paddingSm),

              Text("Get in Touch", style: fonts.displayLarge),
              SizedBox(height: s.spaceBtwItems),

              CustomButton(
                width: 200,
                height: 50,
                tittleText: 'Contact Us',
                isPrimary: false,
                foregroundColor: Colors.white,
                onPressed: () => context.go(RouteNames.contact),
              ),
            ],
          ),

          Positioned(top: -50, right: 0, child: AnimatedContactImage(height: 300)),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      width: double.infinity,
      height: 320,
      padding: EdgeInsets.symmetric(horizontal: s.paddingLg * 1.5, vertical: s.paddingLg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFAB2E66), Color(0xFF834BA3), Color(0xFF3F397E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                child: Text(
                  "Have Any Projects in Mind?",
                  style: fonts.headlineLarge.rajdhani(
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.95),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: s.paddingSm),

              Text("Get in Touch", style: fonts.displayLarge),
              SizedBox(height: s.spaceBtwSections),

              // ✅ IMPROVED: Using CustomButton
              CustomButton(
                width: 200,
                height: 50,
                tittleText: 'Contact Us',
                isPrimary: false,
                foregroundColor: Colors.white,
                onPressed: () => context.go(RouteNames.contact),
              ),
            ],
          ),

          Positioned(top: -80, right: 60, child: AnimatedContactImage(height: 300)),
        ],
      ),
    );
  }
}
