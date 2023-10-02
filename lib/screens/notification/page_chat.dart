import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class PageChat extends StatelessWidget {
  const PageChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "HR",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.blue,
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
