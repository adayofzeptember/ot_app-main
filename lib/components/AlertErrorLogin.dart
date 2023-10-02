import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class AlertErrorLogin extends StatelessWidget {
  AlertErrorLogin({
    Key? key,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
    required this.title,
  }) : super(key: key);

  final Duration duration;
  final double deltaX;
  final Curve curve;
  final String title;
  double shake(double animation) => 2 * (0.5 - (0.5 - curve.transform(animation)).abs());
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: key,
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(deltaX * shake(animation), 0),
        child: child,
      ),
      child: Text(
        title,
        style: const TextStyle(color: AppColors.red, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
