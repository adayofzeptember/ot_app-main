import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardTime extends StatelessWidget {
  CardTime({
    super.key,
    required this.title,
    required this.color,
  });
  var color;
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0, 0),
              blurRadius: 1,
            ),
            const BoxShadow(color: Colors.white)
          ],
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
