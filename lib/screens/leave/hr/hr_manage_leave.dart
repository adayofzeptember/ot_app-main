import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ot_app/components/alert.dart';

import '../../../components/photo_view.dart';
import '../../../components/side_pane.dart';
import '../../../routes/route_side.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_icon.dart';
import '../../../utils/app_image.dart';

//ส่วนของ HR ไว้จัดการคำขอลาของพนักงาน
// ignore: must_be_immutable
class HrManageLeave extends StatelessWidget {
  HrManageLeave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Slidable(
              key: const ValueKey(1),
              closeOnScroll: true,
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                openThreshold: 0.1,
                extentRatio: 0.33,
                children: [
                  SidePane(
                    onTap: () {
                      KonAlert().alert(
                        context: context,
                        onConfirm: () {
                          print("อนุมัติ");
                        },
                        title: "ต้องการอนุมัติ ?",
                        titleColor: Colors.green,
                        textConfirmColor: Colors.white,
                        backgroundConfirmColor: Colors.green,
                        textCancelColor: Colors.grey,
                        backgroundCancelColor: Colors.grey.shade200,
                      );
                    },
                    title: "อนุมัติ",
                    color: Colors.green,
                    icon: Icons.check_circle_outline_outlined,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                openThreshold: 0.1,
                extentRatio: 0.33,
                children: [
                  const SizedBox(width: 10),
                  SidePane(
                    onTap: () {
                      KonAlert().alert(
                        context: context,
                        onConfirm: () {
                          print("ไม่อนุมัติ");
                        },
                        title: "ไม่อนุมัติ ?",
                        titleColor: AppColors.red,
                        textConfirmColor: Colors.white,
                        backgroundConfirmColor: Colors.green,
                        textCancelColor: Colors.grey,
                        backgroundCancelColor: Colors.grey.shade200,
                      );
                    },
                    title: "ไม่อนุมัติ",
                    color: AppColors.red,
                    iconImage: AppIcons.close,
                  )
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  showDocument(context: context, images: []);
                  print("detail");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromRGBO(195, 219, 226, 0.30),
                        offset: Offset(3, 3),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blueAccent,
                        backgroundImage: AssetImage(AppImages.profile),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ชื่อ นามสกุลชื่อ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_month, size: 18),
                                Text(
                                  " : 00/00/0000",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                const Text(
                                  "ดูรายละเอียดเพิ่มเติม",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void showDocument({required BuildContext context, required List images}) {
  double w = MediaQuery.of(context).copyWith().size.width;
  double h = MediaQuery.of(context).copyWith().size.height;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        titlePadding: EdgeInsets.zero,
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.red),
          ),
        ),
        content: Container(
          width: h,
          height: w,
          child: ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    RouteSide.scalUp(
                      HeroPhotoViewRouteWrapper(
                        index: index.toString(),
                        imageProvider: NetworkImage(images[index]),
                      ),
                    )),
                child: Container(
                  width: w,
                  constraints: const BoxConstraints(minHeight: 200),
                  padding: const EdgeInsets.all(4),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.green,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
