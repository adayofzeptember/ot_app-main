import 'package:flutter/material.dart';

class SidePane extends StatelessWidget {
  const SidePane({super.key, required this.onTap, required this.title, required this.color, this.icon, this.iconImage});
  final Function() onTap;
  final String title;
  final Color color;
  final IconData? icon;
  final String? iconImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 220,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(22.0),
              bottomRight: Radius.circular(22.0),
              topLeft: Radius.circular(22.0),
              bottomLeft: Radius.circular(22.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.white,
                  size: 33,
                ),
              if (iconImage != null)
                ImageIcon(
                  AssetImage(iconImage!),
                  color: Colors.white,
                  size: 33,
                ),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
