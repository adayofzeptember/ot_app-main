// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class KonTimepicker extends StatelessWidget {
  KonTimepicker({
    Key? key,
    required this.onConfirm,
    this.onCancel,
    required this.onHourSelect,
    required this.onMinSelect,
    this.initHour,
    this.initMin,
  }) : super(key: key);
  dynamic onConfirm, onCancel, onHourSelect, onMinSelect;
  int? initHour, initMin;

  final List<int> sec = List.generate(12, (index) => (index) * 5);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onCancel ?? () => Navigator.pop(context),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: onConfirm,
                child: const Text(
                  'เสร็จสิ้น',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.blue),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 200,
                child: CupertinoPicker(
                  looping: true,
                  itemExtent: 30,
                  onSelectedItemChanged: onHourSelect,
                  magnification: 1.2,
                  squeeze: 1,
                  useMagnifier: true,
                  scrollController: FixedExtentScrollController(initialItem: initHour ?? 0),
                  children: List.generate(24, (i) {
                    return Text(
                      '$i',
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    );
                  }),
                ),
              ),
              const Text(
                ':',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(
                width: 120,
                height: 200,
                child: CupertinoPicker(
                  looping: true,
                  itemExtent: 30,
                  onSelectedItemChanged: onMinSelect,
                  magnification: 1.2,
                  squeeze: 1,
                  useMagnifier: true,
                  scrollController: FixedExtentScrollController(initialItem: initMin ?? 0),
                  children: sec.map((int item) {
                    return Center(
                      child: Text(item < 10 ? "0$item" : "$item"),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KonDatePicker extends StatelessWidget {
  KonDatePicker(
      {Key? key,
      required this.onConfirm,
      this.onCancel,
      required this.onDaySelect,
      required this.onMonthSelect,
      required this.onYearSelect,
      required this.initDay,
      required this.initMonth,
      required this.initYear})
      : super(key: key);
  dynamic onConfirm, onCancel, onDaySelect, onMonthSelect, onYearSelect;
  int initDay, initMonth, initYear;
  List<String> month = [
    "มกราคม",
    "กุมภาพันธ์",
    "มีนาคม",
    "เมษายน",
    "พฤษภาคม",
    "มิถุนายน",
    "กรกฎาคม",
    "สิงหาคม",
    "กันยายน",
    "ตุลาคม",
    "พฤศจิกายน",
    "ธันวาคม",
  ];
  final List<String> yearItems = generateYears();
  DateTime dateNow = DateTime.now();
  static List<String> generateYears() {
    int currentYear = DateTime.now().year - 1;
    List<String> years = [];
    for (int i = currentYear; i <= currentYear + 2; i++) {
      years.add(i.toString());
    }
    return years;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onCancel ?? () => Navigator.pop(context),
                  child: const Text(
                    'ยกเลิก',
                    style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: onConfirm,
                  child: const Text(
                    'เสร็จสิ้น',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.blue),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height / 3 - 50,
                  child: CupertinoPicker(
                    looping: true,
                    itemExtent: 30,
                    onSelectedItemChanged: onDaySelect,
                    magnification: 1.2,
                    squeeze: 1,
                    useMagnifier: true,
                    scrollController: FixedExtentScrollController(initialItem: initDay),
                    children: List.generate(31, (i) {
                      return Text(
                        '${i + 1}',
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height / 3 - 50,
                  child: CupertinoPicker(
                    looping: true,
                    itemExtent: 30,
                    onSelectedItemChanged: onMonthSelect,
                    magnification: 1.2,
                    squeeze: 1,
                    useMagnifier: true,
                    scrollController: FixedExtentScrollController(initialItem: initMonth),
                    children: month.map((String item) {
                      return Center(
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height / 3 - 50,
                  child: CupertinoPicker(
                    looping: false,
                    itemExtent: 30,
                    onSelectedItemChanged: onYearSelect,
                    magnification: 1.2,
                    squeeze: 1,
                    useMagnifier: true,
                    scrollController: FixedExtentScrollController(initialItem: initYear),
                    children: yearItems.map((String item) {
                      return Center(
                        child: Text(item),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
