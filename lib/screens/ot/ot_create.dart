import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/components/alert.dart';
import 'package:ot_app/components/custom_easy.dart';
import 'package:ot_app/screens/ot/page_ot_info.dart';

import '../../blocs/ot/ot_bloc.dart';
import '../../components/AppBarRadius.dart';
import '../../components/kon_card.dart';
import '../../components/kon_textfield.dart';
import '../../components/timepicker.dart';
import '../../routes/route_side.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icon.dart';

class OtCreate extends StatefulWidget {
  const OtCreate({Key? key}) : super(key: key);

  @override
  _OtCreateState createState() => _OtCreateState();
}

class _OtCreateState extends State<OtCreate> {
  int sDay = 0, sMonth = 0, sYear = 0;
  int sYearInit = 1;
  DateTime dateNow = DateTime.now();
  DateTime otDate = DateTime.now();
  String otSelect = DateFormat.yMMMd().format(DateTime.now());

  int startHour = 0, startMin = 0, endHour = 0, endMin = 0;

  int _startCheck = 0, _endCheck = 0;

  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    sDay = dateNow.day;
    sMonth = dateNow.month;
    sYear = dateNow.year;
    otSelect = DateFormat.yMMMd().format(dateNow);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarRadius(
          title: "ลงเวลาโอที",
          color: AppColors.blue,
          radius: const BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
          ),
          onBack: () {
            if ((_startCheck + _endCheck) < 3600) {
              context.read<OtBloc>().add(ClearState());
              Navigator.pop(context);
            } else {
              KonAlert().alert(
                context: context,
                onConfirm: () {
                  context.read<OtBloc>().add(ClearState());
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
                onPressed: () => Navigator.push(context, RouteSide.slideLeft(const PageOtInfo())),
                icon: const ImageIcon(
                  AssetImage(AppIcons.clock),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
        child: BlocBuilder<OtBloc, OtState>(
          builder: (context, state) {
            if ((state.startTime != "") && (state.endTime != "")) {
              List<String> _startTime = state.startTime.split(':');
              List<String> _endTime = state.endTime.split(':');

              int _hoursStart = int.parse(_startTime[0]);
              int _minutesStart = int.parse(_startTime[1]);
              _startCheck = _hoursStart * 3600 + _minutesStart * 60;

              int _hoursEnd = int.parse(_endTime[0]);
              int _minutesEnd = int.parse(_endTime[1]);
              _endCheck = _hoursEnd * 3600 + _minutesEnd * 60;
            }

            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 40), //----------------------------------------------------------
                const Text("วันที่ทำงาน", style: TextStyle(fontWeight: FontWeight.bold)),
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
                            otSelect = DateFormat.yMMMd().format(DateTime(sYear, sMonth, sDay));
                            otDate = DateTime(sYear, sMonth, sDay);
                            context.read<OtBloc>().add(ChangefocusedDay(focusedDay: otDate));
                            Navigator.pop(context);
                          },
                          onDaySelect: (val) {
                            sDay = val + 1;
                          },
                          onMonthSelect: (val) {
                            sMonth = val + 1;
                          },
                          onYearSelect: (val) {
                            sYearInit = val;
                            sYear = int.parse("${dateNow.year + val - 1}");
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: w,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: AppColors.softBlue,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(state.focusedDay),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.calendar_month, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10), //----------------------------------------------------------
                const Text("เวลาเริ่มต้น", style: TextStyle(fontWeight: FontWeight.bold)),
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
                        return KonTimepicker(
                          initHour: startHour,
                          initMin: startMin * 5,
                          onConfirm: () {
                            String startTime =
                                "${(startHour < 10) ? '0$startHour' : startHour}:${(startMin < 10) ? '0$startMin' : startMin}";
                            context.read<OtBloc>().add(ChangeStartTime(startTime: startTime));
                            Navigator.pop(context);
                          },
                          onHourSelect: (val) {
                            startHour = val;
                          },
                          onMinSelect: (val) {
                            startMin = val * 5;
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: w,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: AppColors.softBlue,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.startTime != "" ? "${state.startTime} น." : "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.access_time, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10), //----------------------------------------------------------
                const Text("เวลาสิ้นสุด", style: TextStyle(fontWeight: FontWeight.bold)),
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
                        return KonTimepicker(
                          initHour: endHour,
                          initMin: endMin * 5,
                          onConfirm: () {
                            String endTime = "${(endHour < 10) ? '0$endHour' : endHour}:${(endMin < 10) ? '0$endMin' : endMin}";
                            context.read<OtBloc>().add(ChangeEndTime(endTime: endTime));
                            Navigator.pop(context);
                          },
                          onHourSelect: (val) {
                            endHour = val;
                          },
                          onMinSelect: (val) {
                            endMin = val * 5;
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    width: w,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: AppColors.softBlue,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.endTime != "" ? "${state.endTime} น." : "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.access_time, color: Colors.black54),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30), //----------------------------------------------------------
                const Text("บันทึกช่วยจำ", style: TextStyle(fontWeight: FontWeight.bold)),
                KonCard(
                  borderRadius: 8,
                  widget: KonTextField(
                    borderRadius: 11,
                    borderColor: AppColors.softBlue,
                    controller: noteController,
                    hint: "",
                    line: 1,
                  ),
                ),
                const SizedBox(height: 20), //----------------------------------------------------------

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.2),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.blue,
                      fixedSize: Size(w, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      surfaceTintColor: Colors.white,
                    ),
                    onPressed: ((_startCheck + _endCheck) < 3600)
                        ? null
                        : () {
                            KonAlert().alert(
                                context: context,
                                onConfirm: () async {
                                  Navigator.pop(context);
                                  eazyShowLoading();
                                  context.read<OtBloc>().add(SendOtTime(context: context, note: noteController.text));
                                },
                                title: "ยืนยันลงโอที",
                                titleColor: Colors.grey,
                                textConfirmColor: Colors.white,
                                backgroundConfirmColor: Colors.green,
                                textCancelColor: Colors.white,
                                backgroundCancelColor: Colors.grey);
                          },
                    child: const Text(
                      "ลงข้อมูล",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
