import 'package:flutter/material.dart';
import 'package:ot_app/utils/app_icon.dart';

class KonAlert {
  Future<void> alert({
    required BuildContext context,
    required Function() onConfirm,
    required String title,
    required Color titleColor,
    required Color textConfirmColor,
    required Color backgroundConfirmColor,
    required Color textCancelColor,
    required Color backgroundCancelColor,
  }) async {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 24,
          shadowColor: Colors.black.withOpacity(0.7),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Center(
              child: Column(
                children: [
                  const ImageIcon(
                    AssetImage(
                      AppIcons.question,
                    ),
                    size: 55,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    style: TextStyle(color: titleColor, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 90,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: backgroundCancelColor, borderRadius: BorderRadius.circular(11)),
                    child: Text(
                      'ยกลิก',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textCancelColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    width: 90,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: backgroundConfirmColor, borderRadius: BorderRadius.circular(11)),
                    child: Text(
                      'ยืนยัน',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textConfirmColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
