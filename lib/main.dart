import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/blocs/account/account_bloc.dart';
import 'package:ot_app/blocs/calendar/calendar_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ot_app/blocs/check_in_out/check_in_out_bloc.dart';
import 'package:ot_app/blocs/leaves/leaves_bloc.dart';
import 'package:ot_app/blocs/local_auth/local_auth_bloc.dart';
import 'package:ot_app/blocs/login/login_bloc.dart';
import 'package:ot_app/blocs/ot/ot_bloc.dart';
import 'package:ot_app/screens/login/page_login.dart';
import 'package:ot_app/screens/login/page_login_pin.dart';
import 'package:ot_app/screens/main_navigation_bar.dart';
import 'package:ot_app/services/firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/app_color.dart';
import '/utils/notification_service.dart';
import 'blocs/notification/notification_bloc.dart';

String? checkToken, checkPin, checkAuthLocal;
//! email chawanthon.wirajarnyaphan@compattana.com
void main() async {
  Intl.defaultLocale = 'th';
  initializeDateFormatting();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding;
  NotificationService().init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final prefs = await SharedPreferences.getInstance();
  checkToken = await prefs.getString('token');
  checkPin = await prefs.getString('pin_auth');

  print('token: -------------' + checkToken.toString());

  print(checkPin);
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Text(
            "ERROR Widget\n${details.exception}",
          ),
        ),
      );
  // init firebase
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  runApp(MyApp());

  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OtBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => LeavesBloc()),
        BlocProvider(create: (context) => CalendarBloc()),
        BlocProvider(create: (context) => CheckInOutBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => LocalAuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData(
          fontFamily: 'ibmx',
          canvasColor: AppColors.background,
        ),
        home: (checkToken == null)
            ? PageLogin()
            : (checkPin == null)
                ? const MainNavigationBar()
                : const PageLoginPin(),
      ),
    );
  }
}
