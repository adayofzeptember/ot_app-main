import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/components/alert.dart';
import 'package:ot_app/components/kon_button.dart';
import 'package:ot_app/components/kon_card.dart';
import 'package:ot_app/components/kon_textfield.dart';
import 'package:ot_app/components/modal_camera.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/leave/page_leave_info.dart';
import 'package:ot_app/utils/app_icon.dart';
import 'package:ot_app/utils/app_image.dart';

import '../../blocs/leaves/leaves_bloc.dart';
import '../../components/AppBarRadius.dart';
import '../../components/custom_easy.dart';
import '../../components/photo_view.dart';
import '../../components/timepicker.dart';
import '../../utils/app_color.dart';

class LeaveCreate extends StatefulWidget {
  const LeaveCreate({Key? key}) : super(key: key);

  @override
  State<LeaveCreate> createState() => _LeaveCreateState();
}

class DateLeaveModel {
  final String numMonth;
  final String year;
  final String month;

  DateLeaveModel({required this.numMonth, required this.year, required this.month});
}

class _LeaveCreateState extends State<LeaveCreate> {
  String leaveMode = "", leaveType = "";
  String startDate = "", endDate = "";
  DateTime dateNow = DateTime.now();
  DateTime leaveStart = DateTime.now(), leaveEnd = DateTime.now();
  TextEditingController leaveCause = TextEditingController();

  int sDay = 0, sMonth = 0, sYear = 0;
  int eDay = 0, eMonth = 0, eYear = 0;
  int sYearInit = 1, eYearInit = 1;
  @override
  void initState() {
    super.initState();
    sDay = dateNow.day;
    sMonth = dateNow.month;
    sYear = dateNow.year;
    eDay = dateNow.day;
    eMonth = dateNow.month;
    eYear = dateNow.year;
    startDate = DateFormat.yMMMd().format(dateNow);
    endDate = DateFormat.yMMMd().format(dateNow);
  }

  @override
  void dispose() {
    super.dispose();
    leaveMode;
    sDay;
    sMonth;
    sYear;
    dateNow;
    imageFileList;
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;
    return Scaffold(
      appBar: 
      PreferredSize(
      
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarRadius(
          title: "ลา",
          color: AppColors.softGreen,
          radius: const BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
          ),
          onBack: () {
            if (leaveMode == "" || leaveType == "") {
              context.read<LeavesBloc>().add(ClearState());
              Navigator.pop(context);
            } else {
              KonAlert().alert(
                context: context,
                onConfirm: () {
                  context.read<LeavesBloc>().add(ClearState());
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                title: "คุณต้องการออกจากหน้านี้ ?",
                titleColor: AppColors.red,
                textConfirmColor: Colors.white,
                backgroundConfirmColor: Colors.green,
                textCancelColor: Colors.grey,
                backgroundCancelColor: Colors.grey.shade200,
              );
            }
          },
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () => Navigator.push(context, RouteFade.slideLeft(const PageLeaveInfo())),
                icon: const ImageIcon(
                  AssetImage(AppIcons.clock),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxReason(
                  reason: leaveMode,
                  title: "ลาป่วย",
                  ontap: () {
                    leaveMode = "ลาป่วย";
                    setState(() {});
                  },
                  image: AppImages.circleSick,
                  activeImage: AppImages.activeSick,
                ),
                BoxReason(
                  reason: leaveMode,
                  title: "ลากิจ",
                  ontap: () {
                    leaveMode = "ลากิจ";
                    setState(() {});
                  },
                  image: AppImages.circleWork,
                  activeImage: AppImages.activeWork,
                ),
                BoxReason(
                  reason: leaveMode,
                  title: "ลาพักร้อน",
                  ontap: () {
                    leaveMode = "ลาพักร้อน";
                    setState(() {});
                  },
                  image: AppImages.circleHoliday,
                  activeImage: AppImages.activeHoliday,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KonButton(
                  bgColor: (leaveType == "เต็มวัน") ? AppColors.green : Colors.grey.shade400,
                  onpressed: () {
                    leaveType = "เต็มวัน";
                    setState(() {});
                  },
                  title: "เต็มวัน",
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                  width: (w / 3) - 35,
                  height: 38,
                ),
                KonButton(
                  bgColor: (leaveType == "เช้า") ? AppColors.green : Colors.grey.shade400,
                  onpressed: () {
                    leaveType = "เช้า";
                    setState(() {});
                  },
                  title: "เช้า",
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                  width: (w / 3) - 35,
                  height: 38,
                ),
                KonButton(
                  bgColor: (leaveType == "บ่าย") ? AppColors.green : Colors.grey.shade400,
                  onpressed: () {
                    leaveType = "บ่าย";
                    setState(() {});
                  },
                  title: "บ่าย",
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold),
                  width: (w / 3) - 35,
                  height: 38,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ตั้งแต่วันที่",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isDismissible: true,
                          isScrollControlled: true,
                          enableDrag: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                          ),
                          builder: (context) {
                            return KonDatePicker(
                              initDay: sDay - 1,
                              initMonth: sMonth - 1,
                              initYear: sYearInit,
                              onConfirm: () {
                                startDate = DateFormat.yMMMd().format(DateTime(sYear, sMonth, sDay));
                                leaveStart = DateTime(sYear, sMonth, sDay);
                                setState(() {});
                                Navigator.pop(context);
                              },
                              onDaySelect: (val) {
                                // print("วัน: ${val + 1}");
                                sDay = val + 1;
                              },
                              onMonthSelect: (val) {
                                // print("เดือน: ${val + 1}");
                                sMonth = val + 1;
                              },
                              onYearSelect: (val) {
                                // print("ปี: ${DateTime.now().year + val - 1}");
                                sYearInit = val;
                                sYear = int.parse("${dateNow.year + val - 1}");
                              },
                            );
                          },
                        );
                      },
                      child: KonCard(
                        padding: const EdgeInsets.all(12),
                        borderRadius: 11,
                        width: (w / 2) - 40,
                        widget: Text(
                          startDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ถึงวันที่",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: (leaveType == "เต็มวัน")
                          ? () {
                              showModalBottomSheet(
                                context: context,
                                isDismissible: true,
                                isScrollControlled: true,
                                enableDrag: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                                ),
                                builder: (context) {
                                  return KonDatePicker(
                                    initDay: eDay - 1,
                                    initMonth: eMonth - 1,
                                    initYear: eYearInit,
                                    onConfirm: () {
                                      endDate = DateFormat.yMMMd().format(DateTime(eYear, eMonth, eDay));
                                      leaveEnd = DateTime(eYear, eMonth, eDay);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    onDaySelect: (val) {
                                      print("วัน: ${val + 1}");
                                      eDay = val + 1;
                                    },
                                    onMonthSelect: (val) {
                                      print("เดือน: ${val + 1}");
                                      eMonth = val + 1;
                                    },
                                    onYearSelect: (val) {
                                      print("ปี: ${DateTime.now().year + val - 1}");
                                      eYearInit = val;
                                      eYear = int.parse("${dateNow.year + val - 1}");
                                    },
                                  );
                                },
                              );
                            }
                          : null,
                      child: KonCard(
                        padding: const EdgeInsets.all(12),
                        borderRadius: 11,
                        width: (w / 2) - 40,
                        widget: Text(
                          (leaveType == "เต็มวัน") ? endDate : startDate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "หมายเหตุ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            KonCard(
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: KonTextField(
                  borderRadius: 11,
                  borderColor: Colors.white,
                  controller: leaveCause,
                  hint: "ระบุข้อความ",
                  line: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "เพิ่มไฟล์",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            (imageFileList.isNotEmpty)
                ? Container(
                    height: w / 2,
                    width: w / 2,
                    child: ListView.builder(
                      itemCount: imageFileList.length + 1,
                      // physics: const NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < imageFileList.length) {
                          return Container(
                            width: w / 2.5,
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          RouteSide.scalUp(
                                            HeroPhotoViewRouteWrapper(
                                              index: index.toString(),
                                              imageProvider: FileImage(File(
                                                imageFileList[index].path,
                                              )),
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      width: w / 2.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(imageFileList[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    imageFileList.remove(imageFileList[index]);
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration:
                                        BoxDecoration(color: AppColors.red.withOpacity(.1), borderRadius: BorderRadius.circular(5)),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete, size: 15, color: AppColors.red),
                                        Text(
                                          "ลบ",
                                          style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            width: w / 2.5,
                            child: Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      modalCamera(
                                        context: context,
                                        onTapCamera: () async {
                                          final XFile? photo = await imagePicker.pickImage(source: ImageSource.camera);
                                          await EasyLoading.show();
                                          if (photo != null) {
                                            imageFileList.add(photo);
                                          }
                                          await EasyLoading.dismiss();
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        onTapGallery: () async {
                                          List<XFile> _imageFileList = await imagePicker.pickMultiImage();
                                          await EasyLoading.show();

                                          for (var element in _imageFileList) {
                                            print(element.path);
                                            imageFileList.add(element);
                                          }
                                          await EasyLoading.dismiss();
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                      );
                                    },
                                    child: KonCard(
                                      borderRadius: 11,
                                      widget: Padding(
                                        padding: const EdgeInsets.all(38.0),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/icon/folder.png",
                                            width: w / 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 42),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      modalCamera(
                        context: context,
                        onTapCamera: () async {
                          final XFile? photo = await imagePicker.pickImage(source: ImageSource.camera);
                          await EasyLoading.show();
                          if (photo != null) {
                            imageFileList.add(photo);
                          }
                          Navigator.pop(context);
                          await EasyLoading.dismiss();
                          setState(() {});
                        },
                        onTapGallery: () async {
                          imageFileList = await imagePicker.pickMultiImage();
                          await EasyLoading.show();
                          Navigator.pop(context);

                          await EasyLoading.dismiss();
                          setState(() {});
                        },
                      );
                    },
                    child: KonCard(
                      height: 120,
                      widget: Center(
                        child: Image.asset(
                          "assets/icon/folder.png",
                          width: 70,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: KonButton(
          height: 55,
          bgColor: AppColors.blue,
          onpressed: (leaveMode == "" || leaveType == "")
              ? null
              : () {
                  modalConfirm(
                    context: context,
                    title: leaveMode,
                    content: "$startDate - $endDate\nจำนวน - วัน\nหมายเหตุ ${leaveCause.text}",
                    onConfirm: () {
                      Navigator.pop(context);
                      int _leaveMode = (leaveMode == "ลาป่วย")
                          ? 2
                          : (leaveMode == "ลากิจ")
                              ? 1
                              : (leaveMode == "ลาพักร้อน")
                                  ? 3
                                  : 0;
                      int _leaveType = (leaveType == "เต็มวัน")
                          ? 2
                          : (leaveType == "เช้า")
                              ? 3
                              : (leaveType == "เย็น")
                                  ? 4
                                  : 0;
                      if (leaveType == "เต็มวัน") {
                        if (startDate == endDate) {
                          _leaveType = 1;
                        } else {
                          _leaveType = 2;
                        }
                      } else if (leaveType == "เช้า") {
                        _leaveType = 3;
                      } else if (leaveType == "บ่าย") {
                        _leaveType = 4;
                      }
                      eazyShowLoading();
                      context.read<LeavesBloc>().add(SubmitLeave(
                            context: context,
                            leaveCause: leaveCause.text == "" ? "-" : leaveCause.text,
                            leaveMode: _leaveMode,
                            leaveType: _leaveType,
                            leaveStart: leaveStart,
                            leaveEnd: leaveEnd,
                            imageFileList: imageFileList,
                          ));
                    },
                  );
                },
          title: "บันทึก",
          titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}

class BoxReason extends StatelessWidget {
  const BoxReason({
    super.key,
    required this.reason,
    required this.title,
    required this.ontap,
    required this.image,
    required this.activeImage,
  });

  final String reason, title;
  final double active = 100, notActive = 80;
  final Function() ontap;
  final String image, activeImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            height: reason == title ? active : notActive,
            width: reason == title ? active : notActive,
            child: reason == title ? Image.asset(activeImage, fit: BoxFit.fill) : Image.asset(image, fit: BoxFit.fill),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

void modalConfirm({
  required BuildContext context,
  required String title,
  required String content,
  required Function() onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.all(8),
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
          ),
          // alignment: Alignment.center,
          child: Text(
            content,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
            // textAlign: TextAlign.center,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 90,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(11)),
              child: Text(
                'ยกลิก',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: onConfirm,
            child: Container(
              width: 90,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(11)),
              child: const Text(
                'ยืนยัน',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    },
  );
}
