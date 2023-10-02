import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/blocs/account/account_bloc.dart';
import 'package:ot_app/components/kon_card.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/calendar/page_calendar.dart';
import 'package:ot_app/screens/leave/hr/hr_page_leave_info.dart';
import 'package:ot_app/screens/leave/leave_create.dart';
import 'package:ot_app/screens/notification/page_notification.dart';
import 'package:ot_app/screens/ot/hr/hr_page_ot_info.dart';
import 'package:ot_app/screens/ot/ot_create.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/calendar/calendar_bloc.dart';
import '../../components/modal_announcement.dart';
import '../../utils/app_image.dart';

// ignore: must_be_immutable
class PageHome extends StatelessWidget {
  PageHome({Key? key}) : super(key: key);

  final double margin = 20;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        elevation: 0,
        backgroundColor: AppColors.blue,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          //ไอคอนแจ้งเตือน
          Container(
            padding: const EdgeInsets.only(right: 22, top: 26),
            color: AppColors.blue,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, RouteSide.slideLeft(const PageNotification()));
              },
              child: const Icon(
                Icons.notifications_none,
                color: AppColors.softBlue,
                size: 30,
              ),
            ),
          ),
          //โปรไฟล์และประกาศ
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return Container(
                height: 280,
                child: Stack(
                  children: [
                    Container(
                      height: 190,
                      decoration: const BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
                      ),
                      child: Padding(
                        //ภาพโปรไฟล์ ชื่อนามสกุล
                        padding: const EdgeInsets.only(left: 30, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (state.urlProfile != '')
                                ? CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 40,
                                    backgroundImage: NetworkImage(state.urlProfile),
                                  )
                                : Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade50,
                                    child: const CircleAvatar(
                                      radius: 40,
                                    ),
                                  ),
                            const SizedBox(width: 18),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                (state.firstname != "")
                                    ? Text(
                                        "${state.firstname} ${state.lastname}",
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                                      )
                                    : SizedBox(
                                        width: 200,
                                        height: 35,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade50,
                                          child: const Card(),
                                        ),
                                      ),
                                (state.firstname != "")
                                    ? Text(
                                        state.segment,
                                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.softBlue),
                                      )
                                    : SizedBox(
                                        width: 130,
                                        height: 35,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade50,
                                          child: const Card(),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    //ส่วนประกาศ
                    Positioned(
                      bottom: 20,
                      left: margin,
                      right: margin,
                      child: GestureDetector(
                        onTap: () {
                          modalAnnouncement(
                            context: context,
                            text: state.announcement.text,
                            dateTime: state.announcement.dateTime,
                          );
                        },
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.softGreen.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.green.withOpacity(.3),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(22.0),
                                    bottomLeft: Radius.circular(22.0),
                                  ),
                                ),
                                child: Image.asset(
                                  AppImages.bgAnnounce,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 0, 8, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        "ประกาศ",
                                        style: const TextStyle(color: AppColors.blue, fontSize: 28, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        state.announcement.text,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          //ปฏิทิน
          Padding(
            padding: EdgeInsets.only(top: 4, left: margin, right: margin),
            child: Hero(
              tag: "calendar",
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, RouteFade.noSlide(const PageCalendar()));
                },
                child: KonCard(
                  height: 190,
                  padding: const EdgeInsets.all(20),
                  widget: BlocBuilder<CalendarBloc, CalendarState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                    decoration: const BoxDecoration(
                                      color: AppColors.red,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(11.0),
                                        topRight: Radius.circular(11.0),
                                      ),
                                    ),
                                    child: Text(
                                      "${DateFormat.EEEE().format(state.dayNow)}",
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                    decoration: const BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(11.0),
                                        bottomRight: Radius.circular(11.0),
                                      ),
                                    ),
                                    child: Text(
                                      "${DateFormat.d().format(state.dayNow)}",
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 55),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            width: 2,
                            height: 150,
                            color: AppColors.grey,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: state.dayEvents.isNotEmpty
                                ? ListView.builder(
                                    itemCount: state.dayEvents.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        "● " + state.dayEvents[index],
                                        // overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.black),
                                      );
                                    },
                                  )
                                : const Text(
                                    "ไม่มีกิจกรรม",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          //เมนู
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(top: 0, left: margin, right: margin),
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxMenu(
                      w: w,
                      title: "ลงเวลาโอที",
                      image: AppImages.ot,
                      onTap: () {
                        print(state.department);
                        if (state.segment == "Executive Director") {
                          Navigator.push(context, RouteSide.slideLeft(const HrPageOtInfo()));
                        } else {
                          Navigator.push(context, RouteSide.slideLeft(const OtCreate()));
                        }
                      },
                      color: const Color.fromARGB(255, 231, 168, 94),
                    ),
                    BoxMenu(
                      w: w,
                      title: "ลางาน",
                      image: AppImages.leave,
                      onTap: () {
                        // int month = DateTime.now().month;
                        // int year = DateTime.now().year;
                        // context.read<LeavesBloc>().add(HistoryOnly(month: month, year: year));
                        if (state.segment == "Executive Director") {
                          Navigator.push(context, RouteSide.slideLeft(const HrPageLeaveInfo()));
                        } else {
                          Navigator.push(context, RouteSide.slideLeft(const LeaveCreate()));
                        }
                      },
                      color: const Color.fromARGB(255, 253, 173, 141),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BoxMenu extends StatelessWidget {
  const BoxMenu({
    super.key,
    required this.w,
    required this.title,
    required this.image,
    required this.onTap,
    required this.color,
  });

  final double w;
  final Function() onTap;
  final String title;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 175,
        width: (w / 2) - 30,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: KonCard(
                height: 165,
                width: (w / 2) - 30,
                widget: Container(),
              ),
            ),
            Positioned(
              top: 10,
              child: Container(
                height: 125,
                width: (w / 2) - 30,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 135, child: Image.asset(image, fit: BoxFit.fitHeight)),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(color: AppColors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
