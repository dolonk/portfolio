import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import 'package:portfolio/data_layer/model/contact/calendar_info_model.dart';

class InfoBadge extends StatelessWidget {
  final CalendarInfoModel info;

  const InfoBadge({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingSm),
      decoration: BoxDecoration(
        color: info.color.withAlpha((255 * 0.1).round()),
        borderRadius: BorderRadius.circular(s.borderRadiusLg),
        border: Border.all(color: info.color.withAlpha((255 * 0.3).round()), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(info.icon, size: 20, color: info.color),
          SizedBox(width: s.paddingSm),
          Flexible(
            child: Text(
              info.text,
              style: fonts.bodyMedium.rubik(color: DColors.textPrimary, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
