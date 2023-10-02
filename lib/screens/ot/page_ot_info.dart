import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/blocs/ot/ot_bloc.dart';
import 'package:ot_app/screens/ot/ot_history.dart';
import 'package:ot_app/screens/ot/ot_pending.dart';

import '../../models/month_model.dart';
import '../../utils/app_color.dart';

class PageOtInfo extends StatefulWidget {
  const PageOtInfo({Key? key}) : super(key: key);

  @override
  _PageOtInfoState createState() => _PageOtInfoState();
}

class _PageOtInfoState extends State<PageOtInfo> with TickerProviderStateMixin {
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
          "ประวัติ",
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
                                "รออนุมัติ",
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
                                "ประวัติ",
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
          if (_tabController.index == 1)
            BlocBuilder<OtBloc, OtState>(
              builder: (context, state) {
                if (state.selectDate != "") {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0), // Set the radius
                      color: Colors.white, // Set the background color
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    width: double.infinity,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(22),
                      dropdownColor: Colors.white,
                      focusColor: Colors.white,
                      underline: Container(height: 0),
                      value: state.selectDate,
                      onChanged: (newValue) {
                        List select = newValue!.split(" ");
                        context.read<OtBloc>().add(OtOnly(
                              selectItem: newValue,
                              month: int.parse("${select[0]}"),
                              year: int.parse("${select[1]}"),
                            ));
                      },
                      items: months.map<DropdownMenuItem<String>>((Month month) {
                        return DropdownMenuItem<String>(
                          value: "${month.numMonth} ${month.year}",
                          child: Text('${month.month} ${month.year}',
                              style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: <Widget>[
                const OtPending(),
                const OtHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
