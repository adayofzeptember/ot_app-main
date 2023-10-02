import 'package:flutter/material.dart';
import 'package:ot_app/components/kon_button.dart';
import 'package:ot_app/components/kon_card.dart';
import 'package:ot_app/components/kon_textfield.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/screens/login/page_forgot_pin.dart';
import 'package:ot_app/utils/filter_email.dart';

import '../../utils/app_color.dart';

class PageForgotPassword extends StatefulWidget {
  const PageForgotPassword({Key? key}) : super(key: key);

  @override
  _PageForgotPasswordState createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {
  String? selectItem;
  bool formItem = false, checkEmailOrPhone = false;
  TextEditingController emailOrPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
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
      body: ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Stack(
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
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: (formItem)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "รหัสผ่าน",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (selectItem == "email")
                            ? "เราจะส่งหมายเลขรหัสผ่านไปที่อีเมลของคุณ"
                            : "เราจะส่งหมายเลขรหัสผ่านไปที่เบอร์โทรศัพท์ของคุณ",
                        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        (selectItem == "email") ? "อีเมล" : "เบอร์โทรศัพท์",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      KonTextField(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        controller: emailOrPhoneController,
                        hint: "",
                        borderColor: Colors.white,
                        lengthLimitText: (selectItem == "email") ? null : 10,
                        borderRadius: 50,
                        keyboardType: (selectItem == "email") ? TextInputType.emailAddress : TextInputType.phone,
                        onChanged: (val) {
                          if ((selectItem == "email")) {
                            print(val);
                            if (isEmailValid(val)) {
                              checkEmailOrPhone = true;
                              setState(() {});
                            } else {
                              checkEmailOrPhone = false;
                              setState(() {});
                            }
                          } else {
                            if (val.length == 10) {
                              checkEmailOrPhone = true;
                              setState(() {});
                            } else {
                              checkEmailOrPhone = false;
                              setState(() {});
                            }
                          }
                          print("checkEmailOrPhone $checkEmailOrPhone");
                        },
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "รหัสผ่าน",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "โปรดเลือกตัวเลือกเพื่อส่งลิ้งค์รีเซ็ตรหัสผ่าน",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 18),
                      CardForgot(
                        title: "ส่งรหัสไปที่อีเมล",
                        onTap: () {
                          selectItem = "email";
                          setState(() {});
                        },
                        icon: const Icon(Icons.mail_outline, color: AppColors.blue),
                        checkIcon: selectItem == "email" ? const Icon(Icons.check_circle_rounded, color: Colors.green) : null,
                      ),
                      const SizedBox(height: 18),
                      CardForgot(
                        title: "ส่งรหัสไปที่ SMS",
                        onTap: () {
                          selectItem = "sms";
                          setState(() {});
                        },
                        icon: const Icon(Icons.phone_android_outlined, color: AppColors.blue),
                        checkIcon: selectItem == "sms" ? const Icon(Icons.check_circle_rounded, color: Colors.green) : null,
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: KonButton(
        radius: 22,
        width: 200,
        height: 55,
        bgColor: AppColors.blue,
        title: formItem ? "ส่ง" : "ถัดไป",
        titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        onpressed: (selectItem == null)
            ? null
            : (!formItem)
                ? () {
                    print("ถัดไป");
                    formItem = true;
                    setState(() {});
                  }
                : (!checkEmailOrPhone)
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          RouteFade.noSlide(
                            PagePin(getEmailOrPhone: emailOrPhoneController.text),
                          ),
                        );
                      },
      ),
    );
  }
}

class CardForgot extends StatelessWidget {
  const CardForgot({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    required this.checkIcon,
  });
  final String title;
  final Function() onTap;
  final Icon icon;
  final Icon? checkIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: KonCard(
        padding: const EdgeInsets.all(18),
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: AppColors.softBlue.withOpacity(.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: icon),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
            checkIcon ?? Container()
          ],
        ),
      ),
    );
  }
}
