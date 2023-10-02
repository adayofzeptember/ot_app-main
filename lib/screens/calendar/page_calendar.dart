import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../blocs/calendar/calendar_bloc.dart';
import '../../mockup/calendar_data.dart';
import '../../models/calendar_model.dart';
import '../../utils/app_color.dart';
import '../../utils/calendar.dart';

class PageCalendar extends StatefulWidget {
  const PageCalendar({Key? key}) : super(key: key);

  @override
  _PageCalendarState createState() => _PageCalendarState();
}

class _PageCalendarState extends State<PageCalendar> {
  Map<DateTime, List<EventCalendar>> selectedEvents = {};
  List<EventCalendar> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.blue,
        centerTitle: true,
        title: const Text("ปฏิทิน", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Hero(
                        tag: "calendar",
                        child: Container(
                          height: 330,
                          width: w,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
                          child: TableCalendar(
                            shouldFillViewport: true,
                            headerStyle: const HeaderStyle(
                              // formatButtonTextStyle: TextStyle(color: Colors.red),
                              formatButtonVisible: false,
                              titleCentered: true,
                              formatButtonDecoration: BoxDecoration(
                                color: AppColors.red,
                              ),
                              titleTextStyle: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
                              headerPadding: EdgeInsets.all(0),
                              leftChevronIcon: Icon(Icons.keyboard_arrow_left, color: AppColors.blue, size: 20),
                              rightChevronIcon: Icon(Icons.keyboard_arrow_right, color: AppColors.blue, size: 20),
                              leftChevronVisible: true,
                              rightChevronVisible: true,
                              formatButtonShowsNext: true,
                            ),
                            focusedDay: state.selectedDay,
                            firstDay: kFirstDay,
                            lastDay: kLastDay,
                            selectedDayPredicate: (day) {
                              return isSameDay(state.selectedDay, day);
                            },
                            calendarStyle: CalendarStyle(
                              markerDecoration: BoxDecoration(
                                color: const Color.fromARGB(49, 53, 207, 163),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              todayDecoration: const BoxDecoration(
                                color: AppColors.red,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: AppColors.red.withOpacity(.8),
                                shape: BoxShape.circle,
                              ),
                              markerSizeScale: 1,
                              markersAlignment: Alignment.center,
                              markersAutoAligned: false,
                            ),
                            onDaySelected: (selectedDay, focusedDay) {
                              context.read<CalendarBloc>().add(SelectDayEvent(select: selectedDay));
                            },
                            eventLoader: (day) {
                              if (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday) {
                                return selectedEvents[day] = [EventCalendar(title: 'วันหยุดประจำสัปดาห์')];
                              }
                              for (var el in calendarMockup) {
                                if ((DateTime.utc(DateTime.parse("${el['start']}").year, DateTime.parse("${el['start']}").month,
                                        DateTime.parse("${el['start']}").day)) ==
                                    day) {
                                  return selectedEvents[day] = [EventCalendar(title: el['title'].toString())];
                                }
                              }
                              return [];
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    DateFormat.yMMMMEEEEd().format(state.selectedDay),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _getEventsfromDay(state.selectedDay).isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            ..._getEventsfromDay(state.selectedDay).map(
                              (EventCalendar event) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "กิจกรรม",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "● " + event.title,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          "ไม่มีกิจกรรม",
                          style: TextStyle(color: Colors.grey),
                        ),
                ),
                const SizedBox(height: 50),
                // Center(
                //   child: KonButton(
                //     bgColor: AppColors.red,
                //     onpressed: () {},
                //     width: 250,
                //     title: "*ยังไม่ได้ทำเพิ่มeventสำหรับHR",
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
