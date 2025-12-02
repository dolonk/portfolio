import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconHelper {
  static IconData getFontAwesomeIcon(String? iconName) {
    if (iconName == null || iconName.isEmpty) {
      return FontAwesomeIcons.circleQuestion;
    }

    // Convert to lowercase for case-insensitive matching
    final name = iconName.toLowerCase().trim();

    // Icon mapping dictionary
    final iconMap = <String, IconData>{
      // Tech Stack Icons
      'flutter': FontAwesomeIcons.code,
      'code': FontAwesomeIcons.code,
      'dart': FontAwesomeIcons.code,
      'firebase': FontAwesomeIcons.fire,
      'fire': FontAwesomeIcons.fire,
      'bloc': FontAwesomeIcons.layerGroup,
      'layer_group': FontAwesomeIcons.layerGroup,
      'layers': FontAwesomeIcons.layerGroup,
      'stripe': FontAwesomeIcons.stripe,
      'cloud': FontAwesomeIcons.cloud,
      'rest_api': FontAwesomeIcons.cloud,
      'api': FontAwesomeIcons.cloud,
      'get_it': FontAwesomeIcons.boxesStacked,
      'boxes_stacked': FontAwesomeIcons.boxesStacked,
      'dependency': FontAwesomeIcons.boxesStacked,
      'git': FontAwesomeIcons.gitAlt,
      'git_alt': FontAwesomeIcons.gitAlt,
      'github': FontAwesomeIcons.github,
      'figma': FontAwesomeIcons.figma,

      // Feature Icons
      'user_check': FontAwesomeIcons.userCheck,
      'user': FontAwesomeIcons.user,
      'authentication': FontAwesomeIcons.userCheck,
      'magnifying_glass': FontAwesomeIcons.magnifyingGlass,
      'search': FontAwesomeIcons.magnifyingGlass,
      'cart_shopping': FontAwesomeIcons.cartShopping,
      'cart': FontAwesomeIcons.cartShopping,
      'shopping': FontAwesomeIcons.cartShopping,
      'credit_card': FontAwesomeIcons.creditCard,
      'payment': FontAwesomeIcons.creditCard,
      'truck_fast': FontAwesomeIcons.truckFast,
      'truck': FontAwesomeIcons.truck,
      'delivery': FontAwesomeIcons.truckFast,
      'bell': FontAwesomeIcons.bell,
      'notification': FontAwesomeIcons.bell,
      'heart': FontAwesomeIcons.heart,
      'wishlist': FontAwesomeIcons.heart,
      'favorite': FontAwesomeIcons.heart,
      'language': FontAwesomeIcons.language,
      'globe': FontAwesomeIcons.globe,
      'multilingual': FontAwesomeIcons.language,

      // Common Icons
      'check': FontAwesomeIcons.check,
      'checkmark': FontAwesomeIcons.check,
      'circle_check': FontAwesomeIcons.circleCheck,
      'star': FontAwesomeIcons.star,
      'info': FontAwesomeIcons.circleInfo,
      'warning': FontAwesomeIcons.triangleExclamation,
      'error': FontAwesomeIcons.circleXmark,
      'lock': FontAwesomeIcons.lock,
      'unlock': FontAwesomeIcons.unlock,
      'shield': FontAwesomeIcons.shield,
      'database': FontAwesomeIcons.database,
      'server': FontAwesomeIcons.server,
      'mobile': FontAwesomeIcons.mobile,
      'desktop': FontAwesomeIcons.desktop,
      'tablet': FontAwesomeIcons.tablet,
      'laptop': FontAwesomeIcons.laptop,
      'chart': FontAwesomeIcons.chartLine,
      'analytics': FontAwesomeIcons.chartPie,
      'settings': FontAwesomeIcons.gear,
      'gear': FontAwesomeIcons.gear,
      'cog': FontAwesomeIcons.gear,
      'download': FontAwesomeIcons.download,
      'upload': FontAwesomeIcons.upload,
      'image': FontAwesomeIcons.image,
      'video': FontAwesomeIcons.video,
      'play': FontAwesomeIcons.play,
      'pause': FontAwesomeIcons.pause,
    };

    return iconMap[name] ?? FontAwesomeIcons.circleQuestion;
  }

  /// Get Material icon from string name
  static IconData getMaterialIcon(String? iconName) {
    if (iconName == null || iconName.isEmpty) {
      return Icons.help_outline_rounded;
    }
    final name = iconName.toLowerCase().trim();

    final iconMap = <String, IconData>{
      'explore': Icons.explore_rounded,
      'explore_rounded': Icons.explore_rounded,
      'psychology': Icons.psychology_rounded,
      'psychology_rounded': Icons.psychology_rounded,
      'settings_suggest': Icons.settings_suggest_rounded,
      'settings_suggest_rounded': Icons.settings_suggest_rounded,
      'code': Icons.code_rounded,
      'code_rounded': Icons.code_rounded,
      'lightbulb': Icons.lightbulb_rounded,
      'lightbulb_rounded': Icons.lightbulb_rounded,
      'architecture': Icons.architecture_rounded,
      'architecture_rounded': Icons.architecture_rounded,
      'build': Icons.build_rounded,
      'build_rounded': Icons.build_rounded,
      'speed': Icons.speed_rounded,
      'speed_rounded': Icons.speed_rounded,
    };

    return iconMap[name] ?? Icons.help_outline_rounded;
  }
}
