import 'package:flutter/material.dart';
import '../../../../../../utility/constants/colors.dart';
import '../../../../../../utility/default_sizes/font_size.dart';

class LikeButton extends StatefulWidget {
  final int likes;
  final VoidCallback onTap;
  final bool isLiked;
  final bool small;

  const LikeButton({super.key, required this.likes, required this.onTap, this.isLiked = false, this.small = false});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final fonts = context.fonts;
    final iconSize = widget.small ? 14.0 : 18.0;
    final fontSize = widget.small ? 11.0 : 13.0;

    return GestureDetector(
      onTap: _handleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(
              widget.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: widget.isLiked ? Colors.red : DColors.textSecondary,
              size: iconSize,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${widget.likes}',
            style: fonts.labelSmall.rubik(
              color: widget.isLiked ? Colors.red : DColors.textSecondary,
              fontWeight: widget.isLiked ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
