import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;

  const SectionContainer({super.key, required this.child, this.backgroundColor, this.padding});

  @override
  Widget build(BuildContext context) {
    final s = DSizes.of(context);
    return Container(
      width: double.infinity,
      color: backgroundColor ?? DColors.secondaryBackground,
      padding: padding ?? EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingLg),
      child: child,
    );
  }
}
