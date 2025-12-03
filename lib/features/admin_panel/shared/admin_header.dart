import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/providers/admin_auth_provider.dart';
import '../../../utility/constants/colors.dart';
import '../../../utility/default_sizes/font_size.dart';
import '../../../utility/default_sizes/default_sizes.dart';
import '../../../utility/responsive/responsive_helper.dart';

class AdminHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final List<Widget>? actions;

  const AdminHeader({super.key, required this.title, this.onMenuPressed, this.actions});

  @override
  Widget build(BuildContext context) {
    final s = context.sizes;
    final authProvider = context.watch<AdminAuthProvider>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.paddingLg, vertical: s.paddingMd),
      decoration: BoxDecoration(
        color: DColors.cardBackground,
        border: Border(bottom: BorderSide(color: DColors.cardBorder, width: 1)),
      ),
      child: Row(
        children: [
          // Hamburger Menu (Mobile only)
          if (onMenuPressed != null) ...[
            IconButton(
              onPressed: onMenuPressed,
              icon: Icon(Icons.menu_rounded, color: DColors.textPrimary),
            ),
            SizedBox(width: s.paddingSm),
          ],

          // Title
          Expanded(
            child: Text(
              title,
              style: context.fonts.titleLarge.rajdhani(
                fontWeight: FontWeight.bold,
                color: DColors.textPrimary,
              ),
            ),
          ),

          // Actions
          if (actions != null) ...actions!,

          // Admin Info
          if (!context.isMobile) ...[
            SizedBox(width: s.paddingMd),
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: DColors.primaryButton.withAlpha((255 * 0.1).round()),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person_rounded, color: DColors.primaryButton, size: 18),
                ),
                SizedBox(width: s.paddingSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      authProvider.adminName ?? 'Admin',
                      style: context.fonts.bodyMedium.rubik(
                        fontWeight: FontWeight.w600,
                        color: DColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Administrator',
                      style: context.fonts.labelSmall.rubik(color: DColors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
