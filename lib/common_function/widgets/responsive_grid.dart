import 'package:flutter/material.dart';
import '../../utility/default_sizes/default_sizes.dart';
import '../../utility/responsive/responsive_helper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DResponsiveGrid extends StatelessWidget {
  /// Grid items (required)
  final List<Widget> children;

  /// Number of columns on mobile (default: 1)
  final int mobileColumns;

  /// Number of columns on tablet (default: 2)
  final int tabletColumns;

  /// Number of columns on desktop (default: 3)
  final int desktopColumns;

  /// Horizontal spacing between items
  final double? spacing;

  /// Vertical spacing between rows
  final double? runSpacing;

  /// Grid alignment
  final WrapAlignment alignment;

  /// Enable staggered fade-in animations
  final bool animate;

  /// Animation duration per item
  final Duration animationDuration;

  /// Animation delay between items (milliseconds)
  final int animationDelay;

  /// Maintain aspect ratio for grid items
  final double? aspectRatio;

  /// Custom item builder (for advanced customization)
  final Widget Function(BuildContext context, int index, Widget child)? itemBuilder;

  const DResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing,
    this.runSpacing,
    this.alignment = WrapAlignment.start,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationDelay = 100,
    this.aspectRatio,
    this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final crossAxisCount = context.responsiveValue(
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );
    final itemSpacing = spacing ?? s.spaceBtwItems;
    final lineSpacing = runSpacing ?? s.spaceBtwItems;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate item width based on columns and spacing
        final totalSpacing = itemSpacing * (crossAxisCount - 1);
        final availableWidth = constraints.maxWidth - totalSpacing;
        final itemWidth = availableWidth / crossAxisCount;

        // Build grid items
        final List<Widget> gridItems = children.asMap().entries.map((entry) {
          final index = entry.key;
          Widget child = entry.value;

          // Wrap in SizedBox for consistent sizing
          child = SizedBox(
            width: context.isMobile ? double.infinity : itemWidth,
            height: aspectRatio != null ? (itemWidth / aspectRatio!) : null,
            child: child,
          );

          // Apply custom item builder if provided
          if (itemBuilder != null) {
            child = itemBuilder!(context, index, child);
          }

          // Apply staggered animation if enabled
          if (animate) {
            child = AnimationConfiguration.staggeredList(
              position: index,
              duration: animationDuration,
              delay: Duration(milliseconds: animationDelay),
              child: SlideAnimation(verticalOffset: 50.0, child: FadeInAnimation(child: child)),
            );
          }

          return child;
        }).toList();

        // Return animated grid or static grid
        if (animate) {
          return AnimationLimiter(
            child: Wrap(spacing: itemSpacing, runSpacing: lineSpacing, alignment: alignment, children: gridItems),
          );
        }

        return Wrap(spacing: itemSpacing, runSpacing: lineSpacing, alignment: alignment, children: gridItems);
      },
    );
  }
}
