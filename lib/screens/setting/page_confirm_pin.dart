import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot_app/blocs/local_auth/local_auth_bloc.dart';
import 'package:ot_app/components/AlertErrorLogin.dart';
import 'package:ot_app/components/custom_easy.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageConfirmPin extends StatefulWidget {
  const PageConfirmPin({Key? key, required this.pin}) : super(key: key);
  final String pin;

  @override
  _PageConfirmPinState createState() => _PageConfirmPinState();
}

class _PageConfirmPinState extends State<PageConfirmPin> {
  String confirmPin = "";
  bool checkPin = false;

  void checkConfirm() async {
    final prefs = await SharedPreferences.getInstance();
    if (widget.pin == confirmPin) {
      checkPin = false;

      await prefs.setString("pin_auth", confirmPin);
      context.read<LocalAuthBloc>().add(PinAuth());
      eazyShowSuccess(title: "ตั้งรหัสสำเร็จ");
      Navigator.pop(context);
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        checkPin = true;
        confirmPin = "";

        setState(() {});
      });
    }
    setState(() {});
  }

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
            "ยืนยันรหัสผ่าน",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                      backgroundColor: (confirmPin.length >= 1) ? Colors.black : Colors.white,
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
                      backgroundColor: (confirmPin.length >= 2) ? Colors.black : Colors.white,
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
                      backgroundColor: (confirmPin.length >= 3) ? Colors.black : Colors.white,
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
                      backgroundColor: (confirmPin.length >= 4) ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          (checkPin) ? AlertErrorLogin(title: "รหัสไม่ตรงกัน") : Container()
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
                    if (confirmPin.length < 4) {
                      confirmPin += '1';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '2',
                  onTap: () {
                    if (confirmPin.length < 4) {
                      confirmPin += '2';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '3',
                  onTap: () {
                    if (confirmPin.length < 4) {
                      confirmPin += '3';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
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
                    if (confirmPin.length < 4) {
                      confirmPin += '4';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '5',
                  onTap: () {
                    if (confirmPin.length < 4) {
                      confirmPin += '5';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '6',
                  onTap: () {
                    if (confirmPin.length < 4) {
                      confirmPin += '6';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
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
                    if (confirmPin.length < 4) {
                      confirmPin += '7';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '8',
                  onTap: () {
                    if (confirmPin.length < 4) {
                      confirmPin += '8';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: '9',
                  onTap: () {
                    if (confirmPin.length < 4) {
                      confirmPin += '9';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
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
                    if (confirmPin.length < 4) {
                      confirmPin += '0';
                    }
                    if (confirmPin.length == 4) {
                      checkConfirm();
                    }
                    setState(() {});
                  },
                ),
                NumberWidget(
                  number: 'x',
                  onTap: () {
                    if (confirmPin.length > 0) {
                      confirmPin = (confirmPin.length > 0) ? confirmPin.substring(0, confirmPin.length - 1) : "";
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
