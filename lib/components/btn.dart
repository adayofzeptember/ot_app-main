import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonLogin extends StatelessWidget {
  String title;
  var color, onpressed;
  ButtonLogin({
    Key? key,
    required this.color,
    required this.title,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(MediaQuery.of(context).size.width, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
      ),
      onPressed: onpressed,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
