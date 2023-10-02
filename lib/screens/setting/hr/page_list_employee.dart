import 'package:flutter/material.dart';
import 'package:ot_app/screens/setting/hr/page_edit_profile_employee.dart';

import '../../../routes/route_side.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_image.dart';

class PageListEmployee extends StatefulWidget {
  const PageListEmployee({Key? key}) : super(key: key);

  @override
  _PageListEmployeeState createState() => _PageListEmployeeState();
}

class _PageListEmployeeState extends State<PageListEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.blue,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        centerTitle: true,
        title: const Text("แก้ไขข้อมูลพนักงาน", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
      ),
      backgroundColor: AppColors.blue,
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: ListView.builder(
          itemCount: 9,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    RouteSide.slideLeft(PageEditProfileEmployee(
                      profile: "urlProfile",
                      firstname: "firstname",
                      lastname: "lastname",
                      phone: "phone",
                      email: "email",
                      birthDate: "birthDateEdit",
                      gender: "gender",
                    )));
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blueAccent,
                        backgroundImage: AssetImage(AppImages.profile),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ชื่อนามสกุล",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3),
                            Text(
                              "อีเมล",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
    );
  }
}
