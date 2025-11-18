import 'package:flutter/material.dart';
import '../../../../../utility/constants/colors.dart';
import 'package:responsive_website/utility/default_sizes/font_size.dart';

class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final Duration duration;
  final Duration delay;
  final TextStyle? textStyle;
  final String suffix;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.duration = const Duration(milliseconds: 2000),
    this.delay = Duration.zero,
    this.textStyle,
    this.suffix = '+',
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> {
  int _animationEndValue = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _animationEndValue = widget.targetValue;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: _animationEndValue),
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Text(
          '$value${widget.suffix}',
          style: widget.textStyle ?? context.fonts.displayMedium.rajdhani(color: DColors.primaryButton),
        );
      },
    );
  }
}
