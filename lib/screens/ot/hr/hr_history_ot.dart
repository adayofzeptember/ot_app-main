import 'package:flutter/material.dart';
import 'package:ot_app/utils/app_color.dart';

import '../../../utils/app_icon.dart';
import '../../../utils/app_image.dart';

class HrHistoryOt extends StatelessWidget {
  const HrHistoryOt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: 25.0,
            left: (index % 2 == 0) ? 25 : 0,
            right: (index % 2 != 0) ? 25 : 0,
          ),
          child: GestureDetector(
            onTap: () {
              showDetail(context: context);
              print("detail");
            },
            child: SizedBox(
              height: 150,
              child: Row(
                children: [
                  if (index % 2 == 0)
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                      margin: const EdgeInsets.only(right: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Text(
                        "อนุมัติ",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  Expanded(
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
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
                  if (index % 2 != 0)
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                      margin: const EdgeInsets.only(left: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Text(
                        "ไม่อนุมัติ",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
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
          child: const Column(
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
        ),
      );
    },
  );
}
