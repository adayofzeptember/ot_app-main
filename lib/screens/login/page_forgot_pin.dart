import 'package:flutter/material.dart';
import 'package:ot_app/components/custom_easy.dart';

import '../../utils/app_color.dart';

// ignore: must_be_immutable
class PagePin extends StatefulWidget {
  PagePin({Key? key, required this.getEmailOrPhone}) : super(key: key);
  String getEmailOrPhone;
  @override
  _PagePinState createState() => _PagePinState();
}

class _PagePinState extends State<PagePin> {
  String emailOrPhone = "", otp = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailOrPhone = widget.getEmailOrPhone;
  }

  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.of(context).copyWith().size.width / 4) - 30;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.softBlue,
        centerTitle: true,
        title: const Text(
          "ลืมรหัสผ่าน",
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.blue),
        ),
      ),
      backgroundColor: AppColors.softGreen,
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            height: 150,
            color: AppColors.background,
            child: Stack(
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    color: AppColors.softBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/image/forgot_password.png",
                    height: 150,
                  ),
                )
              ],
            ),
          ),
          Container(
            // height: 500,
            color: AppColors.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ป้อนโค้ด",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "เราได้ส่งโค้ด 4 ตัวไปที่",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    widget.getEmailOrPhone,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: w,
                        height: w,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11)),
                        child: (otp.length >= 1) ? const Icon(Icons.circle, color: AppColors.blue) : Container(),
                      ),
                      Container(
                        width: w,
                        height: w,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11)),
                        child: (otp.length >= 2) ? const Icon(Icons.circle, color: AppColors.blue) : Container(),
                      ),
                      Container(
                        width: w,
                        height: w,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11)),
                        child: (otp.length >= 3) ? const Icon(Icons.circle, color: AppColors.blue) : Container(),
                      ),
                      Container(
                        width: w,
                        height: w,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11)),
                        child: (otp.length >= 4) ? const Icon(Icons.circle, color: AppColors.blue) : Container(),
                      ),
                    ],
                  ),
                  Text(otp),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.softGreen,
                  ),
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "ไม่ได้รับรหัส",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "ส่งรหัสอีกครั้ง",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.softGreen,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberWidget(
                      number: "1",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "1";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                    NumberWidget(
                      number: "2",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "2";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                    NumberWidget(
                      number: "3",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "3";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberWidget(
                      number: "4",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "4";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                    NumberWidget(
                      number: "5",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "5";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                    NumberWidget(
                      number: "6",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "6";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberWidget(
                      number: "7",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "7";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                    NumberWidget(
                      number: "8",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "8";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                    NumberWidget(
                      number: "9",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "9";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Container()),
                    NumberWidget(
                      number: "0",
                      onTap: () {
                        if (otp.length < 4) {
                          otp += "0";
                        }
                        if (otp.length == 4) {
                          eazyShowError(title: "ยังไม่ได้ทำ");
                          otp = "";
                        }
                        setState(() {});
                      },
                    ),
                    NumberWidget(
                      number: "x",
                      onTap: () {
                        otp = (otp.length > 0) ? otp.substring(0, otp.length - 1) : "";
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
      child: TextButton(
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            number,
            style: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        style: TextButton.styleFrom(foregroundColor: Colors.black12),
      ),
    );
  }
}
