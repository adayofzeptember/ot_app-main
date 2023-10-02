import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../blocs/leaves/leaves_bloc.dart';

class SectionLeaveSummary extends StatelessWidget {
  const SectionLeaveSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0),
                  ),
                ),
                child: const Text(
                  'ประจำปี',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(22.0),
                    bottomRight: Radius.circular(22.0),
                  ),
                ),
                child: Text(
                  '${DateTime.now().year + 543}',
                  style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold, fontSize: 32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<LeavesBloc, LeavesState>(
            builder: (context, state) {
              return Column(
                children: [
                  BoxSummary(
                    w: w,
                    color: AppColors.blue,
                    usage: state.leaveSummary.sick!.usage ?? 0,
                    total: double.parse('${state.leaveSummary.sick!.total}'),
                    title: 'ลาป่วย',
                    remain: state.leaveSummary.sick!.remain ?? 0,
                  ),
                  const SizedBox(height: 20),
                  BoxSummary(
                    w: w,
                    color: AppColors.green,
                    usage: state.leaveSummary.personal!.usage ?? 0,
                    total: double.parse('${state.leaveSummary.personal!.total}'),
                    title: 'ลากิจ',
                    remain: state.leaveSummary.personal!.remain ?? 0,
                  ),
                  const SizedBox(height: 20),
                  BoxSummary(
                    w: w,
                    color: AppColors.sofrOrange,
                    usage: state.leaveSummary.annual!.usage ?? 0,
                    total: double.parse('${state.leaveSummary.annual!.total}'),
                    title: 'ลาพักร้อน/วันเกิด',
                    remain: state.leaveSummary.annual!.remain ?? 0,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(30, 12, 12, 12),
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0),
                  ),
                ),
                child: const Text(
                  'หมายเหตุ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(30, 12, 30, 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22.0),
                    bottomRight: Radius.circular(22.0),
                  ),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'วันลาของพนักงาน',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Row(
                          children: [
                            CircleAvatar(backgroundColor: AppColors.blue, radius: 12),
                            SizedBox(width: 6),
                            CircleAvatar(backgroundColor: AppColors.green, radius: 12),
                            SizedBox(width: 6),
                            CircleAvatar(backgroundColor: AppColors.sofrOrange, radius: 12),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'จำนวนคงเหลือ',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Row(
                          children: [
                            CircleAvatar(backgroundColor: Colors.grey.shade400, radius: 12),
                            const SizedBox(width: 6),
                            const CircleAvatar(backgroundColor: Colors.white, radius: 12),
                            const SizedBox(width: 6),
                            const CircleAvatar(backgroundColor: Colors.white, radius: 12),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BoxSummary extends StatelessWidget {
  BoxSummary({
    super.key,
    required this.w,
    required this.usage,
    required this.total,
    required this.color,
    required this.title,
    required this.remain,
  });

  final double w;
  double usage, remain, total;
  Color color;
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (w / 2) - 40,
      width: w, //(w / 2) - 40,
      constraints: const BoxConstraints(
        maxHeight: 180,
      ),
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(15),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            alignment: Alignment.center,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  canScaleToFit: true,
                  maximum: total,
                  axisLineStyle: AxisLineStyle(
                    thickness: 20,
                    // cornerStyle: CornerStyle.bothCurve,
                    color: Colors.grey.shade400,
                  ),
                  showTicks: false,
                  interval: 20,
                  showLabels: false,
                  canRotateLabels: true,
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: usage <= 0.5 ? usage + 0.040 : usage,
                      width: 20,
                      enableAnimation: true,
                      color: color,
                      animationDuration: 1500,
                      // cornerStyle: CornerStyle.bothCurve,
                    ),
                    MarkerPointer(
                      value: (usage > total)
                          ? total - 0.14
                          : (usage == 0)
                              ? usage + 0.14
                              : usage - 0.14,
                      markerHeight: 18,
                      markerWidth: 18,
                      elevation: 0,
                      enableAnimation: true,
                      animationDuration: 1500,
                      markerType: MarkerType.image,
                      color: Colors.white,
                      borderColor: color,
                      borderWidth: 2,
                      overlayColor: color,
                      offsetUnit: GaugeSizeUnit.factor,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      axisValue: total / 2,
                      positionFactor: 0.4,
                      widget: Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Text(
                          '${usage.toStringAsFixed(1)}/${total.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Row(
                  children: [
                    const Text(
                      'วันลาที่ใช้ :',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      ' ${usage.toStringAsFixed(1)} ',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.red),
                    ),
                    const Text(
                      'วัน',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'วันลาคงเหลือ :',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      ' ${remain.toStringAsFixed(1)} ',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.green),
                    ),
                    const Text(
                      'วัน',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'วันลาทั้งหมด :',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      ' ${total.toStringAsFixed(0)} ',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blue),
                    ),
                    const Text(
                      'วัน',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// เก่า
// class BoxSummary extends StatelessWidget {
//   BoxSummary({
//     super.key,
//     required this.w,
//     required this.count,
//     required this.all,
//     required this.color,
//     required this.title,
//   });

//   final double w;
//   double count, all;
//   Color color;
//   String title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: (w / 2) - 40,
//       width: w, //(w / 2) - 40,
//       constraints: new BoxConstraints(
//         maxHeight: 180,
//       ),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Color.fromRGBO(195, 219, 226, 0.30),
//             offset: Offset(3, 3),
//             blurRadius: 20,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 12.0),
//             child: SfRadialGauge(
//               axes: <RadialAxis>[
//                 RadialAxis(
//                   maximum: all,
//                   axisLineStyle: AxisLineStyle(
//                     thickness: 20,
//                     cornerStyle: CornerStyle.bothCurve,
//                     color: Colors.grey.shade400,
//                   ),
//                   showTicks: false,
//                   interval: 20,
//                   showLabels: false,
//                   canRotateLabels: true,
//                   pointers: <GaugePointer>[
//                     RangePointer(
//                       value: count - 0.1,
//                       width: 20,
//                       enableAnimation: true,
//                       color: color,
//                       animationDuration: 1500,
//                       cornerStyle: CornerStyle.bothCurve,
//                     ),
//                     MarkerPointer(
//                       value: (count > all)
//                           ? all - 0.14
//                           : (count == 0)
//                               ? count + 0.14
//                               : count - 0.14,
//                       markerHeight: 18,
//                       markerWidth: 18,
//                       elevation: 0,
//                       enableAnimation: true,
//                       animationDuration: 1500,
//                       markerType: MarkerType.circle,
//                       color: Colors.white,
//                       borderColor: color,
//                       borderWidth: 2,
//                       overlayColor: color,
//                       offsetUnit: GaugeSizeUnit.factor,
//                     ),
//                   ],
//                   annotations: <GaugeAnnotation>[
//                     GaugeAnnotation(
//                       axisValue: all / 2,
//                       positionFactor: 0.4,
//                       widget: Padding(
//                         padding: const EdgeInsets.only(top: 28.0),
//                         child: Text(
//                           "${count.toStringAsFixed(1)}/${all.toStringAsFixed(0)}",
//                           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Text(
//               title,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
