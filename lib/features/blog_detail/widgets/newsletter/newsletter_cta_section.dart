import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class NewsletterCtaSection extends StatefulWidget {
  const NewsletterCtaSection({super.key});

  @override
  State<NewsletterCtaSection> createState() => _NewsletterCtaSectionState();
}

class _NewsletterCtaSectionState extends State<NewsletterCtaSection> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _subscribe() async {
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('Please enter a valid email address'),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // TODO: Implement newsletter subscription API
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('✅ Successfully subscribed to newsletter!'),
            ],
          ),
          backgroundColor: DColors.primaryButton,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(
            context.responsiveValue(mobile: s.paddingXl, tablet: s.paddingXl, desktop: s.paddingXl),
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [DColors.primaryButton, Color(0xFF8B5CF6), Color(0xFFD4003D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(s.borderRadiusLg),
            boxShadow: [
              BoxShadow(
                color: DColors.primaryButton.withAlpha((255 * 0.4).round()),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              // Icon
              _buildIcon(context, s),
              SizedBox(height: s.paddingMd),

              // Heading
              _buildHeading(context, s),
              SizedBox(height: s.paddingSm),

              // Subheading
              _buildSubheading(context, s),
              SizedBox(height: s.spaceBtwItems),

              // Email Input + Subscribe Button
              context.isMobile ? _buildMobileForm(context, s) : _buildDesktopForm(context, s),

              SizedBox(height: s.paddingMd),

              // Social Proof
              _buildSocialProof(context, s),
            ],
          ),
        ),
      ),
    );
  }

  /// Icon
  Widget _buildIcon(BuildContext context, DSizes s) {
    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(color: Colors.white.withAlpha((255 * 0.2).round()), shape: BoxShape.circle),
      child: Icon(
        Icons.email_rounded,
        color: Colors.white,
        size: context.responsiveValue(mobile: 40.0, tablet: 48.0, desktop: 56.0),
      ),
    );
  }

  /// Heading
  Widget _buildHeading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Text(
      'Want More Flutter Tips?',
      style: fonts.displaySmall.rajdhani(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: context.responsiveValue(mobile: 28.0, tablet: 36.0, desktop: 42.0),
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Subheading
  Widget _buildSubheading(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Text(
      'Get weekly Flutter tutorials, best practices, and exclusive content delivered straight to your inbox.',
      style: fonts.bodyLarge.rubik(
        color: Colors.white.withAlpha((255 * 0.95).round()),
        height: 1.6,
        fontSize: context.responsiveValue(mobile: 14.0, tablet: 16.0, desktop: 16.0),
      ),
      textAlign: TextAlign.center,
    );
  }

  /// Desktop Form (Horizontal)
  Widget _buildDesktopForm(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      children: [
        // Email Input
        Expanded(
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: fonts.bodyMedium.rubik(color: DColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Enter your email address',
              hintStyle: fonts.bodyMedium.rubik(color: DColors.textSecondary),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
              prefixIcon: Icon(Icons.email_outlined, color: DColors.textSecondary),
            ),
          ),
        ),
        SizedBox(width: s.paddingMd),

        // Subscribe Button
        _SubscribeButton(onPressed: _subscribe, isLoading: _isLoading),
      ],
    );
  }

  /// Mobile Form (Vertical)
  Widget _buildMobileForm(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Column(
      children: [
        // Email Input
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,

          //style: fonts.bodyMedium.rubik(color: DColors.primaryButton),
          decoration: InputDecoration(
            hintText: 'Enter your email address',
            hintStyle: fonts.bodyMedium.rubik(color: DColors.textSecondary),

            //filled: true,
            //fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(s.borderRadiusMd),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
            prefixIcon: Icon(Icons.email_outlined, color: DColors.textSecondary),
          ),
        ),
        SizedBox(height: s.paddingMd),

        // Subscribe Button
        SizedBox(
          width: double.infinity,
          child: _SubscribeButton(onPressed: _subscribe, isLoading: _isLoading),
        ),
      ],
    );
  }

  /// Social Proof
  Widget _buildSocialProof(BuildContext context, DSizes s) {
    final fonts = context.fonts;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.people_rounded, color: Colors.white.withAlpha((255 * 0.9).round()), size: 20),
        SizedBox(width: s.paddingSm),
        Text(
          'Join 500+ Flutter developers',
          style: fonts.bodySmall.rubik(
            color: Colors.white.withAlpha((255 * 0.9).round()),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Subscribe Button Widget
class _SubscribeButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const _SubscribeButton({required this.onPressed, required this.isLoading});

  @override
  State<_SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<_SubscribeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(
              mobile: s.paddingLg,
              tablet: s.paddingXl,
              desktop: s.paddingXl,
            ),
            vertical: context.responsiveValue(mobile: s.paddingMd, tablet: s.paddingMd, desktop: s.paddingMd),
          ),
          decoration: BoxDecoration(
            color: _isHovered ? DColors.background : Colors.white,
            borderRadius: BorderRadius.circular(s.borderRadiusMd),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha((255 * 0.3).round()),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: widget.isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(DColors.primaryButton),
                  ),
                )
              : Text(
                  'Subscribe',
                  style: fonts.titleSmall.rubik(
                    color: _isHovered ? DColors.textPrimary : DColors.background,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
