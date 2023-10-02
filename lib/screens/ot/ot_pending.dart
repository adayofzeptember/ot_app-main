import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/ot/ot_bloc.dart';
import '../../components/alert.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icon.dart';

class OtPending extends StatelessWidget {
  const OtPending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<OtBloc, OtState>(
        builder: (context, state) {
          if (state.pageLoading) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 200.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                );
              },
            );
          }
          if (state.dataWait.isEmpty) {
            return const Center(
              child: Text(
                'ไม่พบข้อมูล',
                style: TextStyle(fontSize: 30, color: AppColors.softBlue),
              ),
            );
          } else {
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: w,
                      decoration: const BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          )),
                      child: const Text(
                        "สิงหาคม 2566",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(14),
                        width: w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 236, 180, 94).withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            )),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 18,
                                      color: Colors.grey.shade700,
                                    ),
                                    Text(
                                      " จำนวนชั่วโมง",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  NumberFormat.decimalPattern().format(state.sumWages),
                                  style: const TextStyle(
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage(AppIcons.moneyBill),
                                      size: 18,
                                      color: Colors.grey.shade700,
                                    ),
                                    Text(
                                      " จำนวนเงิน",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  NumberFormat.decimalPattern().format(state.sumWages),
                                  style: const TextStyle(
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.dataWait.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Slidable(
                          key: const ValueKey(1),
                          closeOnScroll: true,
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            openThreshold: 0.1,
                            extentRatio: 0.33,
                            children: [
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    print(state.dataWait[index].id);
                                    KonAlert().alert(
                                      context: context,
                                      onConfirm: () {
                                        context.read<OtBloc>().add(CancelOtTime(
                                              context: context,
                                              id: state.dataWait[index].id.toString(),
                                            ));
                                      },
                                      title: "ต้องการยกเลิก ?",
                                      titleColor: AppColors.red,
                                      textConfirmColor: Colors.white,
                                      backgroundConfirmColor: Colors.green,
                                      textCancelColor: Colors.grey,
                                      backgroundCancelColor: Colors.grey.shade200,
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 220,
                                    decoration: const BoxDecoration(
                                      color: AppColors.red,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(22.0),
                                        bottomRight: Radius.circular(22.0),
                                        topLeft: Radius.circular(22.0),
                                        bottomLeft: Radius.circular(22.0),
                                      ),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ImageIcon(
                                          AssetImage(AppIcons.close),
                                          color: Colors.white,
                                          size: 33,
                                        ),
                                        const Text(
                                          "ยกเลิก",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
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
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 15, 20, 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.calendar_month, size: 18),
                                          Text(
                                            " : " + state.dataWait[index].takeDate,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.access_time, size: 18),
                                          Text(
                                            " : " + state.dataWait[index].takeTime + " น.",
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const ImageIcon(AssetImage(AppIcons.commentDot), size: 18),
                                          Text(
                                            " : " + state.dataWait[index].note,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const ImageIcon(AssetImage(AppIcons.moneyBill), size: 18),
                                          Text(
                                            " : " + state.dataWait[index].wages,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(22),
                                            color: (state.dataWait[index].status == 'อนุมัติ')
                                                ? const Color.fromARGB(255, 231, 246, 228)
                                                : (state.dataWait[index].status == 'รออนุมัติ')
                                                    ? const Color.fromARGB(255, 250, 237, 220)
                                                    : (state.dataWait[index].status == "ปฏิเสธ")
                                                        ? Colors.red.shade100
                                                        : Colors.grey.shade300,
                                          ),
                                          child: Text(
                                            state.dataWait[index].status,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: (state.dataWait[index].status == 'อนุมัติ')
                                                  ? const Color.fromARGB(255, 46, 172, 40)
                                                  : (state.dataWait[index].status == 'รออนุมัติ')
                                                      ? const Color.fromARGB(255, 220, 145, 43)
                                                      : (state.dataWait[index].status == "ปฏิเสธ")
                                                          ? AppColors.red
                                                          : Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(22.0),
                                        bottomLeft: Radius.circular(22.0),
                                      ),
                                    ),
                                    child: Image.asset(
                                      "assets/image/bg-ot.png",
                                      fit: BoxFit.scaleDown,
                                      height: 80,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
