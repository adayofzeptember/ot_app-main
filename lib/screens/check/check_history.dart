import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/month_model.dart';
import '../../utils/app_color.dart';

class CheckHistory extends StatefulWidget {
  const CheckHistory({Key? key}) : super(key: key);

  @override
  State<CheckHistory> createState() => _CheckHistoryState();
}

class _CheckHistoryState extends State<CheckHistory> {
  List<Month> months = [];
  String selectDate = "";
  void getData() {
    final DateTime now = DateTime.now();
    for (int i = 0; i < 12; i++) {
      final DateTime currentMonth = DateTime(now.year, now.month - i, 1);
      final String monthName = DateFormat.MMMM().format(currentMonth);
      final String numMonth = DateFormat.M().format(currentMonth);
      final String year = DateFormat.y().format(currentMonth);

      months.add(Month(numMonth: numMonth, year: year, month: monthName));
    }
    // context.read<LeavesBloc>().add(HistoryOnly(
    //       selectItem: "${months[0].numMonth} ${months[0].year}",
    //       month: int.parse(months[0].numMonth),
    //       year: int.parse(months[0].year),
    //     ));
    selectDate = "${months[0].numMonth} ${months[0].year}";
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.yellow,
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
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 75,
            child: Stack(
              children: [
                Container(
                  height: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0), // Set the radius
                      color: Colors.white, // Set the background color
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    width: double.infinity,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(22),
                      dropdownColor: Colors.white,
                      focusColor: Colors.white,
                      underline: Container(height: 0),
                      value: selectDate,
                      onChanged: (newValue) {
                        // List select = newValue!.split(" ");
                        // context.read<LeavesBloc>().add(HistoryOnly(
                        //       selectItem: newValue,
                        //       month: int.parse("${select[0]}"),
                        //       year: int.parse("${select[1]}"),
                        //     ));
                      },
                      items: months.map<DropdownMenuItem<String>>((Month month) {
                        return DropdownMenuItem<String>(
                          value: "${month.numMonth} ${month.year}",
                          child: Text('${month.month} ${month.year}',
                              style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).copyWith().size.width - 60,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).copyWith().size.width - 60,
                        margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
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
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(30, 25, 20, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on_outlined, size: 18),
                                    Text(
                                      " : " + "ยังไม่ได้ทำ",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.calendar_month, size: 18),
                                    Text(
                                      " : " + "d/m/y",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.access_time, size: 18, color: Colors.green),
                                    Text(
                                      " : " + "00.00v",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.access_time, size: 18, color: Colors.red),
                                    Text(
                                      " : " + "00.00",
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: -4,
                        child: Container(
                          width: 80,
                          height: 80,
                          child: Image.asset(
                            "assets/image/check_map.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
