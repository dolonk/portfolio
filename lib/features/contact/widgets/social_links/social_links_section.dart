import 'package:flutter/material.dart';
import '../../../../common_function/widgets/section_header.dart';
import '../../../../common_function/widgets/animation_social_icon.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/section_container.dart';

class SocialLinksSection extends StatelessWidget {
  const SocialLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return SectionContainer(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd),
      child: Column(
        children: [
          // Section Heading
          DSectionHeader(
            label: 'STAY CONNECTED',
            title: 'Connect With Me',
            subtitle: 'Follow for updates, tips, and insights on Flutter development',
            alignment: TextAlign.center,
          ),
          SizedBox(height: s.spaceBtwItems),

          // Social Icons Grid
          AnimationSocialIcon(),
        ],
      ),
    );
  }
}
