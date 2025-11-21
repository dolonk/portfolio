import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class NewsletterWidget extends StatefulWidget {
  const NewsletterWidget({super.key});

  @override
  State<NewsletterWidget> createState() => _NewsletterWidgetState();
}

class _NewsletterWidgetState extends State<NewsletterWidget> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _subscribe() async {
    if (_emailController.text.isEmpty) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('✅ Successfully subscribed!'), backgroundColor: DColors.primaryButton));
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.all(s.paddingLg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [DColors.primaryButton, Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: DColors.primaryButton.withAlpha((255 * 0.3).round()),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Icon(Icons.email_rounded, color: DColors.textPrimary, size: 32),
          SizedBox(height: s.paddingMd),

          // Heading
          Text(
            'Get Flutter Tips Weekly',
            style: fonts.titleMedium.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
          ),
          SizedBox(height: s.paddingSm),

          // Subheading
          Text(
            'Join 500+ developers receiving Flutter insights, tutorials, and best practices.',
            style: fonts.bodySmall.rubik(color: DColors.textPrimary.withAlpha((255 * 0.9).round()), height: 1.5),
          ),
          SizedBox(height: s.paddingMd),

          // Email Input
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: fonts.bodySmall.rubik(color: DColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Enter your email',
              hintStyle: fonts.bodySmall.rubik(color: DColors.textPrimary.withAlpha((255 * 0.6).round())),
              filled: true,
              fillColor: Colors.white.withAlpha((255 * 0.2).round()),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s.borderRadiusMd),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
            ),
          ),
          SizedBox(height: s.paddingMd),

          // Subscribe Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _subscribe,
              style: ElevatedButton.styleFrom(
                backgroundColor: DColors.background,
                padding: EdgeInsets.symmetric(vertical: s.paddingMd),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusMd)),
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(DColors.textPrimary),
                      ),
                    )
                  : Text(
                      'Subscribe',
                      style: fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w600),
                    ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: 0.1, duration: 600.ms, delay: 400.ms);
  }
}
