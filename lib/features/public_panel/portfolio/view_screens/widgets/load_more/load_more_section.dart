import 'package:flutter/material.dart';
import 'package:portfolio/utility/constants/colors.dart';
import 'package:portfolio/utility/default_sizes/font_size.dart';
import 'package:portfolio/utility/default_sizes/default_sizes.dart';
import '../../../../../../utility/responsive/responsive_helper.dart';

class LoadMoreSection extends StatelessWidget {
  final int displayedCount;
  final int totalCount;
  final bool isLoading;
  final VoidCallback onLoadMore;

  const LoadMoreSection({
    super.key,
    required this.displayedCount,
    required this.totalCount,
    required this.isLoading,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final fonts = context.fonts;

    // Hide section if all projects loaded
    if (displayedCount >= totalCount) return const SizedBox.shrink();

    return Center(
      child: Container(
        width: context.responsiveValue(mobile: double.infinity, tablet: 300, desktop: 300),
        padding: EdgeInsets.symmetric(vertical: s.spaceBtwSections, horizontal: s.paddingMd),
        child: ElevatedButton(
          onPressed: isLoading ? null : onLoadMore,
          style: ElevatedButton.styleFrom(
            backgroundColor: DColors.primaryButton,
            foregroundColor: Colors.white,
            disabledBackgroundColor: DColors.primaryButton.withAlpha((255 * 0.6).round()),
            disabledForegroundColor: Colors.white.withAlpha((255 * 0.7).round()),
            padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: isLoading ? 0 : 4,
          ),
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withAlpha((255 * 0.7).round())),
                      ),
                    ),
                    SizedBox(width: s.paddingMd),
                    Text('Loading...', style: fonts.labelLarge.rubik(fontWeight: FontWeight.bold)),
                  ],
                )
              : Text('Load More Projects', style: fonts.labelLarge.rubik(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
