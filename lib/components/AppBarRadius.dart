import 'package:flutter/material.dart';

class AppBarRadius extends StatelessWidget {
  const AppBarRadius({
    super.key,
    required this.title,
    required this.radius,
    required this.onBack,
    required this.actions,
    required this.color,
  });
  final String title;
  final BorderRadiusGeometry radius;
  final Function() onBack;
  final List<Widget> actions;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: AppBar(
        elevation: 0,
        backgroundColor: color,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        actions: actions,
      ),
    );
  }
}
