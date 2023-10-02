import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/utils/app_color.dart';

import '../../blocs/ot/ot_bloc.dart';
import '../../utils/app_icon.dart';

class OtHistory extends StatelessWidget {
  const OtHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: BlocBuilder<OtBloc, OtState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 15),
              Container(
                // height: 100,
                padding: const EdgeInsets.all(10),
                width: w,
                decoration: BoxDecoration(color: AppColors.orange, borderRadius: BorderRadius.circular(22)),
                child: Column(
                  children: [
                    const Text(
                      "ยอดเงินทั้งหมด",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      NumberFormat.decimalPattern().format(state.sumWages),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: state.dataOnly.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
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
                                        " : " + state.dataOnly[index].takeDate,
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
                                        " : " + state.dataOnly[index].takeTime + " น.",
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
                                        " : " + state.dataOnly[index].note,
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
                                        " : " + state.dataOnly[index].wages,
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
                                        color: (state.dataOnly[index].status == 'อนุมัติ')
                                            ? const Color.fromARGB(255, 231, 246, 228)
                                            : (state.dataOnly[index].status == 'รออนุมัติ')
                                                ? const Color.fromARGB(255, 250, 237, 220)
                                                : (state.dataOnly[index].status == "ปฏิเสธ")
                                                    ? Colors.red.shade100
                                                    : Colors.grey.shade300,
                                      ),
                                      child: Text(
                                        state.dataOnly[index].status,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: (state.dataOnly[index].status == 'อนุมัติ')
                                              ? const Color.fromARGB(255, 46, 172, 40)
                                              : (state.dataOnly[index].status == 'รออนุมัติ')
                                                  ? const Color.fromARGB(255, 220, 145, 43)
                                                  : (state.dataOnly[index].status == "ปฏิเสธ")
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
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
