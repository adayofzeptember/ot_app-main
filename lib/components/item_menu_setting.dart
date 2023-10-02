import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemMenu extends StatelessWidget {
  ItemMenu({
    super.key,
    this.color,
    required this.onTap,
    required this.icon,
    required this.title,
  });
  Color? color;
  String title;
  var onTap, icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          // borderRadius: BorderRadius.circular(11),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Icon(Icons.keyboard_arrow_right, color: Colors.grey)
            ],
          ),
        ),
      ),
    );
  }
}
