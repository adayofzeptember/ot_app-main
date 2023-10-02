import 'package:flutter/material.dart';

import '../../components/kon_button.dart';
import '../../utils/app_color.dart';

class PageChangePassword extends StatefulWidget {
  const PageChangePassword({Key? key}) : super(key: key);

  @override
  _PageChangePasswordState createState() => _PageChangePasswordState();
}

class _PageChangePasswordState extends State<PageChangePassword> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: const Text("รหัสผ่าน", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            TextField(
              controller: oldPassController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "รหัสผ่านปัจจุบัน",
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "รหัสผ่านใหม่",
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "ยืนยันรหัสผ่านใหม่",
              ),
            ),
            const SizedBox(height: 55),
            Center(
              child: KonButton(
                width: w,
                bgColor: AppColors.blue,
                onpressed: null,
                title: "บันทึก",
                titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
