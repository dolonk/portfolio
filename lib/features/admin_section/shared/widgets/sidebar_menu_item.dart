import 'package:flutter/material.dart';
import '../../../../utility/constants/colors.dart';
import '../../../../utility/default_sizes/font_size.dart';
import '../../../../utility/default_sizes/default_sizes.dart';

class SidebarMenuItem extends StatefulWidget {
  final IconData? icon;
  final String title;
  final String route;
  final String currentRoute;
  final VoidCallback onTap;
  final bool isChild;
  final bool isExpandable;
  final bool isExpanded;
  final List<Widget>? children;

  const SidebarMenuItem({
    super.key,
    this.icon,
    required this.title,
    required this.route,
    required this.currentRoute,
    required this.onTap,
    this.isChild = false,
    this.isExpandable = false,
    this.isExpanded = false,
    this.children,
  });

  @override
  State<SidebarMenuItem> createState() => _SidebarMenuItemState();
}

class _SidebarMenuItemState extends State<SidebarMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final isActive = widget.currentRoute.startsWith(widget.route);

    return Column(
      children: [
        // Main Item
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: InkWell(
            onTap: widget.onTap,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: widget.isChild ? s.paddingLg : s.paddingSm),
              padding: EdgeInsets.symmetric(horizontal: s.paddingMd, vertical: s.paddingMd),
              decoration: BoxDecoration(
                color: isActive
                    ? DColors.primaryButton.withAlpha((255 * 0.1).round())
                    : (_isHovered ? DColors.cardBorder.withAlpha((255 * 0.5).round()) : Colors.transparent),
                borderRadius: BorderRadius.circular(s.borderRadiusSm),
                border: isActive
                    ? Border.all(color: DColors.primaryButton.withAlpha((255 * 0.3).round()), width: 1)
                    : null,
              ),
              child: Row(
                children: [
                  // Icon
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 20,
                      color: isActive ? DColors.primaryButton : DColors.textSecondary,
                    ),
                    SizedBox(width: s.paddingSm),
                  ],

                  // Indent for child items
                  if (widget.isChild) SizedBox(width: s.paddingMd),

                  // Title
                  Expanded(
                    child: Text(
                      widget.title,
                      style: context.fonts.bodyMedium.rubik(
                        color: isActive ? DColors.primaryButton : DColors.textPrimary,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),

                  // Expand icon
                  if (widget.isExpandable)
                    Icon(
                      widget.isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: DColors.textSecondary,
                    ),
                ],
              ),
            ),
          ),
        ),

        // Children (if expanded)
        if (widget.isExpandable && widget.isExpanded && widget.children != null)
          Padding(
            padding: EdgeInsets.only(top: s.paddingSm),
            child: Column(children: widget.children!),
          ),
      ],
    );
  }
}
