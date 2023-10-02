// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/screens/leave/hr/hr_manage_leave.dart';
import 'package:ot_app/utils/app_color.dart';

import '../../../models/month_model.dart';
import '../../../blocs/leaves/leaves_bloc.dart';
import 'hr_history_leave.dart';

class HrPageLeaveInfo extends StatefulWidget {
  const HrPageLeaveInfo({
    Key? key,
    // required bool fromSaveData, //เช็คว่ามาจากการบันทึก
  }) : super(key: key);

  @override
  _HrPageLeaveInfoState createState() => _HrPageLeaveInfoState();
}

class _HrPageLeaveInfoState extends State<HrPageLeaveInfo> with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Month> months = [];
  void getData() {
    final DateTime now = DateTime.now();
    for (int i = 0; i < 12; i++) {
      final DateTime currentMonth = DateTime(now.year, now.month - i, 1);
      final String monthName = DateFormat.MMMM().format(currentMonth);
      final String numMonth = DateFormat.M().format(currentMonth);
      final String year = DateFormat.y().format(currentMonth);

      months.add(Month(numMonth: numMonth, year: year, month: monthName));
    }
    context.read<LeavesBloc>().add(HistoryOnly(
          selectItem: "${months[0].numMonth} ${months[0].year}",
          month: int.parse(months[0].numMonth),
          year: int.parse(months[0].year),
        ));
    context.read<LeavesBloc>().add(LeaveSummary());
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.softGreen,
        centerTitle: true,
        title: const Text(
          "ข้อมูลการลา",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<LeavesBloc>().add(ClearState());
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 70,
            width: w,
            child: Stack(
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.softGreen,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        const BoxShadow(
                          color: Color.fromRGBO(195, 219, 226, 0.30),
                          offset: Offset(1, 1),
                          blurRadius: 20,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TabBar(
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.blue,
                      ),
                      controller: _tabController,
                      onTap: (value) {
                        print(_tabController.index);
                        setState(() {});
                      },
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "จัดการลางาน",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "ประวัติการลา",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Text("ยังไม่มีAPI", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[HrManageLeave(), const HrHistoryLeave()],
            ),
          ),
        ],
      ),
    );
  }
}
