import 'package:flutter/material.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/notification/page_chat.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:ot_app/utils/app_image.dart';

class PageNotification extends StatefulWidget {
  const PageNotification({Key? key}) : super(key: key);

  @override
  _PageNotificationState createState() => _PageNotificationState();
}

class _PageNotificationState extends State<PageNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          "การแจ้งเตือน",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.blue,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, RouteSide.slideLeft(PageChat()));
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
              child: Row(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Image.asset(
                        AppImages.profile,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "ยังไม่ได้ทำ",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text("10:20"),
                          ],
                        ),
                        Text(
                          "ยังไม่ได้ทำยังไม่ได้ทำยังไม่ได้ทำยังไม่ได้ทำยังไม่ได้ทำยังไม่ได้ทำยังไม่ได้ทำยังไม่ได้ทำ",
                          style: TextStyle(color: Colors.grey.shade500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
