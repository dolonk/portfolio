import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import '../../../../../utility/default_sizes/font_size.dart';

class LikeButton extends StatefulWidget {
  final int likes;
  final VoidCallback onTap;

  const LikeButton({super.key, required this.likes, required this.onTap});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isHovered = false;
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final fonts = context.fonts;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() => _isLiked = !_isLiked);
          widget.onTap();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border_rounded,
              color: _isLiked ? Colors.red : (_isHovered ? DColors.primaryButton : DColors.textSecondary),
              size: 18,
            ),
            SizedBox(width: 4),
            Text(
              '${widget.likes}',
              style: fonts.labelSmall.rubik(
                color: _isLiked ? Colors.red : (_isHovered ? DColors.primaryButton : DColors.textSecondary),
                fontWeight: _isLiked ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
