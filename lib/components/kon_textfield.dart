import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class KonTextField extends StatelessWidget {
  KonTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.obscure,
    this.borderColor,
    this.lengthLimitText,
    this.suffix,
    this.onChanged,
    this.keyboardType,
    this.borderRadius,
    this.line,
    this.contentPadding,
    this.enabled,
  }) : super(key: key);
  TextEditingController controller;
  TextInputType? keyboardType;
  String hint;
  bool? obscure, enabled;
  Color? borderColor;
  int? lengthLimitText, line;
  Widget? suffix;
  Function(String)? onChanged;
  double? borderRadius;
  EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: line ?? 1,
      maxLines: line ?? 1,
      cursorColor: Colors.grey,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscure ?? false,
      textAlignVertical: TextAlignVertical.top,
      enabled: enabled ?? true,
      inputFormatters: (lengthLimitText != null)
          ? [
              LengthLimitingTextInputFormatter(lengthLimitText),
            ]
          : null,
      keyboardType: keyboardType ?? TextInputType.text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        suffix: suffix,
        contentPadding: contentPadding ?? const EdgeInsets.only(left: 8, right: 4),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: (enabled == false) ? Colors.grey.shade300 : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10), // กำหนดรัศมีของกรอบ
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? Colors.grey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? Colors.grey,
          ),
        ),
      ),
    );
  }
}
