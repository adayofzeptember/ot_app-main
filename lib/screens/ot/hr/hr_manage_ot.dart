import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../components/alert.dart';
import '../../../components/side_pane.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_icon.dart';
import '../../../utils/app_image.dart';

class HrManageOt extends StatelessWidget {
  const HrManageOt({Key? key}) : super(key: key);

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
                  showDetail(context: context);
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

void showDetail({required BuildContext context}) {
  double w = MediaQuery.of(context).copyWith().size.width;
  double h = MediaQuery.of(context).copyWith().size.height;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: Colors.red,
              size: 30,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
        content: Container(
          width: h,
          height: w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blueAccent,
                        backgroundImage: AssetImage(AppImages.profile),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "ชื่อ นามสกุลชื่อ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "compattana.compattana@compattana.com",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(Icons.calendar_month, size: 18),
                      Text(
                        " : 00/00/0000",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 18),
                      Text(
                        " : 17:00 - 22:00  ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "รายละเอียดการทำโอที: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ในการเขียน job description หรือใบบอกขอบเขตลักษณะงานนั้น หัวหน้างาน หรือที่เรียกกันว่า Line manager นั้น  ",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const ImageIcon(AssetImage(AppIcons.moneyBill), size: 18),
                      Text(
                        " : 0 บาท",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(11)),
                      child: const Text(
                        'ไม่อนุมัติ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(11)),
                      child: const Text(
                        'อนุมัติ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
