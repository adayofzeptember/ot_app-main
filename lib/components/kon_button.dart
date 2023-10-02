import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KonButton extends StatelessWidget {
  String? title;
  TextStyle? titleStyle;
  Color bgColor;
  Color? surfaceColor;
  Function()? onpressed;
  double? radius, elevation, width, height;
  Widget? icon;
  KonButton({
    Key? key,
    required this.bgColor,
    this.title,
    required this.onpressed,
    this.titleStyle,
    this.radius,
    this.elevation,
    this.width,
    this.height,
    this.surfaceColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 0,
        backgroundColor: bgColor,
        fixedSize: Size(width ?? MediaQuery.of(context).size.width, height ?? 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        surfaceTintColor: surfaceColor ?? Colors.white,
      ),
      onPressed: onpressed,
      child: (title != null)
          ? Text(
              title!,
              style: titleStyle,
            )
          : icon,
    );
  }
}
