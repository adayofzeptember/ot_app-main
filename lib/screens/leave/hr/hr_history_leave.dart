import 'package:flutter/material.dart';

import '../../../components/photo_view.dart';
import '../../../routes/route_side.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_icon.dart';
import '../../../utils/app_image.dart';

class HrHistoryLeave extends StatelessWidget {
  const HrHistoryLeave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          // height: 220,
          margin: const EdgeInsets.fromLTRB(30, 25, 30, 0),
          child: GestureDetector(
            onTap: () {
              showDocument(context: context, images: []);
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
              child: const Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 25, 20, 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "พักร้อน",
                          style: TextStyle(color: Color.fromARGB(255, 17, 52, 137), fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blueAccent,
                              backgroundImage: AssetImage(AppImages.profile),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 60.0),
                                child: Text(
                                  " : ชื่อ นามสกุลชื่อ นามสกุลชื่อ นามสกุลชื่อ นามสกุลชื่อ นามสกุล",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month, size: 18),
                            Text(
                              " : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.access_time, size: 18),
                            Text(
                              " : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageIcon(AssetImage(AppIcons.commentDot), size: 18),
                            Text(
                              " : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     (state.dataOnly[index].images.length == 0)
                        //         ? Container()
                        //         : const Row(
                        //             children: [
                        //               Text(
                        //                 "ดูเอกสารเพิ่มเติม ",
                        //                 style: TextStyle(
                        //                   fontSize: 15,
                        //                   color: Colors.grey,
                        //                 ),
                        //               ),
                        //               Icon(
                        //                 Icons.arrow_forward_ios_sharp,
                        //                 size: 14,
                        //                 color: Colors.grey,
                        //               ),
                        //             ],
                        //           ),
                        //     KonButton(
                        //       onpressed: () {},
                        //       bgColor: (state.dataOnly[index].status == 'Approve')
                        //           ? const Color.fromARGB(255, 231, 246, 228)
                        //           : (state.dataOnly[index].status == 'Pending')
                        //               ? const Color.fromARGB(255, 250, 237, 220)
                        //               : (state.dataOnly[index].status == "Reject")
                        //                   ? Colors.red.shade100
                        //                   : Colors.grey.shade300,
                        //       width: 100,
                        //       height: 30,
                        //       title: state.dataOnly[index].status,
                        //       titleStyle: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: (state.dataOnly[index].status == 'Approve')
                        //             ? const Color.fromARGB(255, 46, 172, 40)
                        //             : (state.dataOnly[index].status == 'Pending')
                        //                 ? const Color.fromARGB(255, 220, 145, 43)
                        //                 : (state.dataOnly[index].status == "Reject")
                        //                     ? AppColors.red
                        //                     : Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Container(
                  //     width: 80,
                  //     height: 80,
                  //     child: Image.asset(
                  //       state.dataOnly[index].mode == "ลาป่วย"
                  //           ? AppImages.cardSick
                  //           : state.dataOnly[index].mode == "พักร้อน"
                  //               ? AppImages.cardHoliday
                  //               : state.dataOnly[index].mode == "ลากิจ"
                  //                   ? AppImages.cardWork
                  //                   : AppImages.cardSpacial,
                  //       fit: BoxFit.scaleDown,
                  //       height: 80,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
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
