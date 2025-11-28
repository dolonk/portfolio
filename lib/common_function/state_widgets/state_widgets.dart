import 'package:flutter/material.dart';
import '../../utility/constants/colors.dart';
import '../../utility/default_sizes/font_size.dart';
import '../../utility/default_sizes/default_sizes.dart';

class DLoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;

  const DLoadingWidget({super.key, this.message, this.size});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size ?? 40,
            height: size ?? 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(DColors.primaryButton),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: s.paddingMd),
            Text(
              message!,
              style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// ============================================================
/// DErrorWidget - Error State Widget
/// ============================================================

class DErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryButtonText;

  const DErrorWidget({super.key, required this.message, this.onRetry, this.retryButtonText});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Error Icon
          Container(
            padding: EdgeInsets.all(s.paddingLg),
            decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle),
            child: Icon(Icons.error_outline_rounded, size: 48, color: Colors.red.shade400),
          ),
          SizedBox(height: s.paddingLg),

          // Error Message
          Text(
            'Oops! Something went wrong',
            style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: s.paddingSm),

          Text(
            message,
            style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
            textAlign: TextAlign.center,
          ),

          // Retry Button
          if (onRetry != null) ...[
            SizedBox(height: s.paddingLg),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, size: 20),
              label: Text(retryButtonText ?? 'Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: DColors.primaryButton,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusMd)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// ============================================================
/// DEmptyWidget - Empty State Widget
/// ============================================================

class DEmptyWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const DEmptyWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            icon ?? Icons.inbox_rounded,
            size: 80,
            color: DColors.textSecondary.withAlpha((255 * 0.5).round()),
          ),
          SizedBox(height: s.paddingLg),

          // Title
          Text(
            title,
            style: context.fonts.titleLarge.rajdhani(fontWeight: FontWeight.bold, color: DColors.textPrimary),
            textAlign: TextAlign.center,
          ),

          // Subtitle
          if (subtitle != null) ...[
            SizedBox(height: s.paddingSm),
            Text(
              subtitle!,
              style: context.fonts.bodyMedium.rubik(color: DColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],

          // Action Button
          if (onAction != null && actionLabel != null) ...[
            SizedBox(height: s.paddingLg),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: DColors.primaryButton,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(s.borderRadiusMd)),
              ),
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}
