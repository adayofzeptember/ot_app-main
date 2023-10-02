import 'package:flutter/material.dart';
import 'package:ot_app/screens/setting/page_confirm_pin.dart';
import 'package:ot_app/utils/app_color.dart';

import '../../routes/route_fade.dart';

class PageSetPin extends StatefulWidget {
  const PageSetPin({Key? key}) : super(key: key);

  @override
  _PageSetPinState createState() => _PageSetPinState();
}

class _PageSetPinState extends State<PageSetPin> {
  String pin = "";

  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.of(context).copyWith().size.width / 4) - 30;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Column(
        // shrinkWrap: true,
        children: [
          const SizedBox(height: 50),
          const Text(
            "กำหนดรหัสผ่าน",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const Text(
            "โปรดใส่รหัสผ่านที่คุณต้องการ",
            style: TextStyle(fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: w,
                    width: w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircleAvatar(
                        backgroundColor: (pin.length >= 1) ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: w,
                    width: w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircleAvatar(
                        backgroundColor: (pin.length >= 2) ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: w,
                    width: w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircleAvatar(
                        backgroundColor: (pin.length >= 3) ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: w,
                    width: w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CircleAvatar(
                        backgroundColor: (pin.length >= 4) ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      bottomNavigationBar: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                NumberWidget(
                  number: '1',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '1';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }

                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '2',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '2';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '3',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '3';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                NumberWidget(
                  number: '4',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '4';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '5',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '5';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '6',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '6';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                NumberWidget(
                  number: '7',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '7';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '8',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '8';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '9',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '9';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                NumberWidget(
                  number: '0',
                  onTap: () {
                    if (pin.length < 4) {
                      pin += '0';
                    }
                    if (pin.length == 4) {
                      Navigator.pushReplacement(context, RouteFade.noSlide(PageConfirmPin(pin: pin)));
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: 'x',
                  onTap: () {
                    if (pin.length > 0) {
                      pin = (pin.length > 0) ? pin.substring(0, pin.length - 1) : "";
                    }

                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({
    super.key,
    required this.number,
    required this.onTap,
  });
  final String number;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextButton(
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              number,
              style: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          style: TextButton.styleFrom(foregroundColor: Colors.black12, side: const BorderSide(width: 1, color: Colors.black)),
        ),
      ),
    );
  }
}
