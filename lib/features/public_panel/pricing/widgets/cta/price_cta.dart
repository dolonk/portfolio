import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../route/route_name.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';
import '../../../../../utility/default_sizes/default_sizes.dart';
import '../../../../../utility/responsive/responsive_helper.dart';
import '../../../../../utility/responsive/section_container.dart';
import '../../../../../common_function/widgets/custom_button.dart';

class PriceCta extends StatelessWidget {
  const PriceCta({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;
    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.spaceBtwSections),
      child: Container(
        padding: EdgeInsets.all(s.paddingXl),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [DColors.primaryButton.withAlpha(25), DColors.primaryButton.withAlpha(12)],
          ),
          borderRadius: BorderRadius.circular(s.borderRadiusLg),
          border: Border.all(color: DColors.primaryButton.withAlpha(76), width: 1),
        ),
        child: Column(
          children: [
            Text('❓', style: TextStyle(fontSize: 48)),
            SizedBox(height: s.paddingMd),
            Text('Still have questions?', style: fonts.titleLarge, textAlign: TextAlign.center),
            SizedBox(height: s.paddingSm),
            Text(
              'Can\'t find the answer you\'re looking for? Feel free to contact us.',
              style: fonts.bodyLarge.rubik(color: DColors.textSecondary, height: 1.6),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: s.paddingSm),
            CustomButton(
              width: context.responsiveValue(mobile: double.infinity, tablet: 200, desktop: 220),
              height: 50,
              tittleText: '💬 Contact Us',
              onPressed: () => context.go(RouteNames.contact),
            ),
          ],
        ),
      ),
    );
  }
}
