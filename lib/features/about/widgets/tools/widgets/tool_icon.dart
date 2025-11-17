import 'package:flutter/material.dart';
import 'package:responsive_website/utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';
import 'package:responsive_website/utility/default_sizes/default_sizes.dart';
import 'package:responsive_website/utility/responsive/responsive_helper.dart';
import 'package:responsive_website/data_layer/model/about/tool_model.dart';

class ToolIcon extends StatelessWidget {
  final ToolModel tool;

  const ToolIcon({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(s.paddingMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: tool.iconColor, width: 1.5),
          ),
          child: Icon(
            tool.icon,
            size: context.responsiveValue(mobile: 32.0, tablet: 36.0, desktop: 40.0),
            color: tool.iconColor,
          ),
        ),
        SizedBox(height: s.spaceBtwItems),
        Text(
          tool.name,
          textAlign: TextAlign.center,
          style: fonts.bodySmall.rubik(color: DColors.textSecondary),
        ),
      ],
    );
  }
}
