import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot_app/screens/setting/hr/page_create_employee.dart';
import 'package:ot_app/screens/setting/hr/page_list_employee.dart';

import '../../../blocs/account/account_bloc.dart';
import '../../../components/item_menu_setting.dart';
import '../../../components/kon_card.dart';
import '../../../routes/route_side.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_icon.dart';

class PageSelecetEditInfoEmployee extends StatelessWidget {
  const PageSelecetEditInfoEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
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
        title: const Text("ตั้งค่า", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Container(
            height: 230,
            child: Stack(
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                  child: KonCard(
                    padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                    borderRadius: 22,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ItemMenu(
                          onTap: () {
                            Navigator.push(context, RouteSide.slideLeft(const PageCreateEmployee()));
                          },
                          icon: const Icon(Icons.note_add_outlined),
                          title: "สร้างบัญชีพนักงาน",
                        ),
                        ItemMenu(
                          onTap: () {
                            Navigator.push(context, RouteSide.slideLeft(const PageListEmployee()));
                          },
                          icon: const ImageIcon(AssetImage(AppIcons.eidtUser)),
                          title: "แก้ไขข้อมูลพนักงาน",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
