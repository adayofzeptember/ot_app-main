import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';

class PageSetNotification extends StatefulWidget {
  const PageSetNotification({Key? key}) : super(key: key);

  @override
  State<PageSetNotification> createState() => _PageSetNotificationState();
}

class _PageSetNotificationState extends State<PageSetNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool checkNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.blue,
            centerTitle: true,
            title: const Text(
              "ตั้งค่าการแจ้งเตือน",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            MenuSetting(
              bottomLine: true,
              switchOpen: checkNotification,
              title: "การแจ้งเตือน",
              detail: "การบังคับปิดแอพอาจทำให้คุณได้รับการแจ้งเตือนช้าหรือไม่ได้รับการแจ้งเตือน",
              onChanged: (value) async {
                checkNotification = value;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuSetting extends StatelessWidget {
  const MenuSetting({
    super.key,
    required this.switchOpen,
    this.detail,
    this.bottomLine,
    required this.title,
    required this.onChanged,
  });

  final bool switchOpen;
  final bool? bottomLine;
  final String? detail;
  final String title;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: (bottomLine == true) ? Border(bottom: BorderSide(width: 1.5, color: Colors.grey.shade300)) : const Border(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                if (detail != null)
                  Text(
                    detail!,
                    style: const TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: switchOpen,
            onChanged: onChanged,
            activeColor: const Color.fromARGB(255, 135, 188, 192),
            focusColor: Colors.red,
            thumbColor: AppColors.blue,
            trackColor: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
