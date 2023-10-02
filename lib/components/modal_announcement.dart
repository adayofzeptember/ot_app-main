import 'package:flutter/material.dart';

void modalAnnouncement({required BuildContext context, required String text, required String dateTime}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
        title: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, size: 30, color: Colors.black45),
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
            ],
          ),
        ),
      );
    },
  );
}
