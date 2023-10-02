import 'package:flutter/material.dart';

import '../utils/app_color.dart';

// ignore: must_be_immutable
class KonCard extends StatelessWidget {
  KonCard({Key? key, required this.widget, this.height, this.padding, this.width, this.borderRadius}) : super(key: key);
  Widget widget;
  double? height, width, borderRadius;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? null,
      width: width ?? null,
      height: height ?? null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 22),
        boxShadow: [
          BoxShadow(
            color: AppColors.softBlue.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: widget,
    );
  }
}
