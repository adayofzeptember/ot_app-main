import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class PageContact extends StatefulWidget {
  const PageContact({Key? key}) : super(key: key);

  @override
  _PageContactState createState() => _PageContactState();
}

class _PageContactState extends State<PageContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.blue,
            centerTitle: true,
            title: const Text(
              "ติดต่อเรา",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ข้อมูลการติดต่อ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "บริษัท คอมพัฒนา จำกัด",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "369/11 ซอยเดชอุดม6 ตำบลในเมือง อำเภอเมือง จังหวัดนครราชสีมา 30000",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(
                        "โทร:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "093-979-4636",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "E-mail:",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "contact@compattana.com",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
