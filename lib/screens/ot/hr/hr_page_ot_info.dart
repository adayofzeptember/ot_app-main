import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/blocs/ot/ot_bloc.dart';

import '../../../models/month_model.dart';
import '../../../utils/app_color.dart';
import 'hr_history_ot.dart';
import 'hr_manage_ot.dart';

class HrPageOtInfo extends StatefulWidget {
  const HrPageOtInfo({Key? key}) : super(key: key);

  @override
  _HrPageOtInfoState createState() => _HrPageOtInfoState();
}

class _HrPageOtInfoState extends State<HrPageOtInfo> with TickerProviderStateMixin {
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
    context.read<OtBloc>().add(OtWait());
    context.read<OtBloc>().add(OtOnly(
          selectItem: "${months[0].numMonth} ${months[0].year}",
          month: int.parse(months[0].numMonth),
          year: int.parse(months[0].year),
        ));
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.blue,
        centerTitle: true,
        title: const Text(
          "ลงเวลาโอที",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.read<OtBloc>().add(ClearState());
            Navigator.pop(context);
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
                    color: AppColors.blue,
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
                                "จัดการโอที",
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
                                "ประวัติโอที",
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
              children: <Widget>[
                const HrManageOt(),
                const HrHistoryOt(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
