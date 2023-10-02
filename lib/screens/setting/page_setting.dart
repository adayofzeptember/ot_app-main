import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot_app/components/alert.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/login/page_login.dart';
import 'package:ot_app/screens/setting/page_contact.dart';
import 'package:ot_app/screens/setting/page_select_edit_info.dart';
import 'package:ot_app/screens/setting/page_set_notification.dart';
import 'package:ot_app/screens/setting/page_set_privacy.dart';
import 'package:ot_app/utils/app_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/account/account_bloc.dart';
import '../../components/item_menu_setting.dart';
import '../../utils/app_color.dart';
import 'hr/page_selecet_edit_info_employee.dart';

class PageSetting extends StatelessWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.blue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("ตั้งค่า", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.softBlue)),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                height: 165,
                width: w,
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, RouteSide.slideLeft(const PageSelectEditInfo()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  (state.urlProfile != '')
                                      ? CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 30,
                                          backgroundImage: NetworkImage(state.urlProfile),
                                        )
                                      : Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade50,
                                          child: const CircleAvatar(
                                            radius: 30,
                                          ),
                                        ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        (state.firstname != "")
                                            ? Text(
                                                "${state.firstname} ${state.lastname}",
                                                style:
                                                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : SizedBox(
                                                width: 200,
                                                height: 35,
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade50,
                                                  child: const Card(),
                                                ),
                                              ),
                                        (state.firstname != "")
                                            ? Text(
                                                state.email,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : SizedBox(
                                                width: 130,
                                                height: 35,
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade50,
                                                  child: const Card(),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right,
                              size: 30,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    //Executive Director
                    if (state.segment == "Executive Director")
                      ItemMenu(
                        onTap: () => Navigator.push(context, RouteSide.slideLeft(const PageSelecetEditInfoEmployee())),
                        icon: const ImageIcon(AssetImage(AppIcons.eidtPen)),
                        title: "ข้อมูลพนักงาน",
                      ),
                    ItemMenu(
                      color: Colors.grey.shade50,
                      onTap: () => Navigator.push(context, RouteSide.slideLeft(const PageSetNotification())),
                      icon: const Icon(Icons.notifications_none),
                      title: "ตั้งค่าแจ้งเตือน",
                    ),
                    ItemMenu(
                      onTap: () => Navigator.push(context, RouteSide.slideLeft(const PageSetPrivacy())),
                      icon: const Icon(Icons.back_hand_outlined),
                      title: "ตั้งค่าความเป็นส่วนตัว",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 25),
                child: ItemMenu(
                  onTap: () => Navigator.push(context, RouteSide.slideLeft(const PageContact())),
                  icon: Image.asset(
                    AppIcons.contact,
                    width: 18,
                    fit: BoxFit.fill,
                  ),
                  title: "ติดต่อเรา",
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                child: GestureDetector(
                  onTap: () {
                    KonAlert().alert(
                      context: context,
                      title: "ยืนยันออกจากระบบ ?",
                      titleColor: Colors.black,
                      textConfirmColor: Colors.white,
                      backgroundConfirmColor: AppColors.blue,
                      onConfirm: () async {
                        Navigator.pushReplacement(context, RouteFade.noSlide(PageLogin()));
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                      },
                      textCancelColor: AppColors.blue,
                      backgroundCancelColor: AppColors.softBlue,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/sign_out.png",
                            width: 18,
                            fit: BoxFit.fill,
                            color: Colors.black,
                          ),
                          const Text(
                            "  ออกจากระบบ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
