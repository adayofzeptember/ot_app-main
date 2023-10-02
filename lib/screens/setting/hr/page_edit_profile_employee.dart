import 'package:flutter/material.dart';
import 'package:ot_app/components/kon_button.dart';
import 'package:ot_app/components/kon_textfield.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';

// ignore: must_be_immutable
class PageEditProfileEmployee extends StatefulWidget {
  PageEditProfileEmployee({
    Key? key,
    required this.profile,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.birthDate,
    required this.gender,
  }) : super(key: key);
  String profile, firstname, lastname, phone, email, birthDate, gender;
  @override
  _PageEditProfileEmployeeState createState() => _PageEditProfileEmployeeState();
}

class _PageEditProfileEmployeeState extends State<PageEditProfileEmployee> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? birthDateController;
  String? genderController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstnameController.text = widget.firstname;
    lastnameController.text = widget.lastname;
    phoneController.text = widget.phone;
    emailController.text = widget.email;
    birthDateController = widget.birthDate;
    genderController = widget.gender;
  }

  TextStyle styleTitle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text("โปรไฟล์", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        width: w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                            widget.profile,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image.asset(AppImages.profile);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "แก้ไขรูปโปรไฟล์",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ชื่อ", style: styleTitle),
                      SizedBox(
                        width: (w / 2) - 40,
                        child: KonTextField(
                          enabled: false,
                          controller: firstnameController,
                          hint: "",
                          borderColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("นามสกุล", style: styleTitle),
                      SizedBox(
                        width: (w / 2) - 40,
                        child: KonTextField(
                          enabled: false,
                          controller: lastnameController,
                          hint: "",
                          borderColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text("เบอร์โทรศัพท์", style: styleTitle),
              SizedBox(
                width: w,
                child: KonTextField(
                  enabled: false,
                  controller: phoneController,
                  hint: "",
                  borderColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text("อีเมล", style: styleTitle),
              SizedBox(
                width: w,
                child: KonTextField(
                  enabled: false,
                  controller: emailController,
                  hint: "",
                  borderColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text('เพศ', style: styleTitle),
              SizedBox(
                width: w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: RadioListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(1),
                        activeColor: AppColors.blue,
                        title: const Align(
                          alignment: Alignment((-1), 0),
                          child: Text(
                            "ชาย",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        value: 'ชาย',
                        groupValue: genderController,
                        onChanged: (value) {
                          genderController = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0),
                        activeColor: AppColors.blue,
                        title: const Align(
                          alignment: Alignment((-1), 0),
                          child: Text(
                            "หญิง",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        value: 'หญิง',
                        groupValue: genderController,
                        onChanged: (value) {
                          genderController = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0),
                        activeColor: AppColors.blue,
                        title: const Align(
                          alignment: Alignment((-1), 0),
                          child: Text(
                            "ไม่ระบุ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        value: 'ไม่ระบุ',
                        groupValue: genderController,
                        onChanged: (value) {
                          genderController = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text("วันเกิด", style: styleTitle),
              Container(
                width: w,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(birthDateController!),
                    const Icon(Icons.calendar_month),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: KonButton(
                  width: 200,
                  bgColor: AppColors.blue,
                  onpressed: null,
                  title: "บันทึก",
                  titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
