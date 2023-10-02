import 'package:flutter/material.dart';

import '../utils/app_color.dart';

void modalCamera({
  required BuildContext context,
  required Function() onTapCamera,
  required Function() onTapGallery,
}) {
  double w = MediaQuery.of(context).copyWith().size.width;
  double h = MediaQuery.of(context).copyWith().size.height;
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: h / 2.8,
        width: w,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.softGreen,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22.0),
            topRight: Radius.circular(22.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 8,
              margin: const EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTapCamera,
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Image.asset("assets/icon/camera.png"),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "ถ่ายภาพ",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                GestureDetector(
                  onTap: onTapGallery,
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Image.asset("assets/icon/folder.png"),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "เลือกรูป",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    },
  );
}
