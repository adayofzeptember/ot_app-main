import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ot_app/screens/check/page_check.dart';
import 'package:ot_app/screens/home/page_home.dart';
import 'package:ot_app/screens/setting/page_setting.dart';
import 'package:ot_app/utils/app_color.dart';
import 'package:ot_app/utils/app_icon.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../blocs/account/account_bloc.dart';
import '../blocs/calendar/calendar_bloc.dart';
import '../blocs/check_in_out/check_in_out_bloc.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({Key? key}) : super(key: key);

  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _selectedIndex = 0;
  late IO.Socket socket;
  // void load() async {
  //   print(FlutterAppBadger.isAppBadgeSupported());
  //   socket = IO.io('http://192.168.1.147:3000', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': false,
  //   });
  //   socket.connect();
  //   socket.on('chat_message', (data) async {
  //     print("object");
  //     // showNotification();
  //     NotificationService().showNotifications();
  //     await FlutterAppBadger.updateBadgeCount(1);

  //     setState(() {});
  //   });
  //   socket.onConnectError((_) => print('onConnectError $_'));
  // }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    EasyLoading.dismiss();
    context.read<AccountBloc>().add(LoadAccount(context: context));
    context.read<AccountBloc>().add(Announcement());
    context.read<CheckInOutBloc>().add(LoadCheckIn());
    context.read<CheckInOutBloc>().add(StreamLocation(context: context));
    context.read<CalendarBloc>().add(LoadDayEvent());
    // context.read<NotificationBloc>().add(GetMessage());
  }

  @override
  void dispose() {
    FlutterAppBadger.removeBadge(); // ยกเลิกการแจ้งเตือนทั้งหมดเมื่อปิดแอป
    super.dispose();
  }

  final List<Widget> screen = [
    PageHome(),
    const PageCheck(),
    const PageSetting(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(195, 219, 226, 0.30),
              offset: Offset(3, 3),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        // height: 120,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (index) {
                // เมื่อกดที่รายการใน Navigation Bar
                setState(() {
                  _selectedIndex = index;
                  // if (index == 1) {
                  //   Navigator.push(context, RouteSide.slideBottom(PageCheck()));
                  // }
                });
              },
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.amber,
                  icon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: ImageIcon(AssetImage(AppIcons.home)),
                  ),
                  activeIcon: ActiveIcon(AppIcons.active_home),
                  label: 'HOME',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: ImageIcon(AssetImage(AppIcons.check)),
                  ),
                  activeIcon: ActiveIcon(AppIcons.active_check),
                  label: 'CHECK',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: ImageIcon(AssetImage(AppIcons.setting)),
                  ),
                  activeIcon: ActiveIcon(AppIcons.active_setting),
                  label: 'SETTING',
                ),
              ],
              unselectedFontSize: 14,
              selectedFontSize: 14,
              fixedColor: AppColors.textBlue,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex,
            ),
          ),
        ),
      ),
    );
  }

  Container ActiveIcon(String icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      // margin: const EdgeInsets.only(top: 4),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.softBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Image.asset(
        icon,
        // width: 18,
      ),
    );
  }
}
