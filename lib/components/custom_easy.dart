import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../utils/app_color.dart';

void eazyShowSuccess({required String title}) {
  EasyLoadingStyle.custom;
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 70
    ..backgroundColor = Colors.white.withOpacity(0.9)
    ..indicatorColor = Colors.green
    ..textColor = Colors.red
    ..maskColor = Colors.white.withOpacity(0)
    ..radius = 22
    ..contentPadding = const EdgeInsets.all(18)
    ..boxShadow = [
      BoxShadow(
        color: AppColors.softBlue.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 2,
      ),
    ]
    ..textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)
    ..dismissOnTap = false;
  EasyLoading.showSuccess(title);
}

void eazyShowLoading() {
  EasyLoadingStyle.custom;
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 70
    ..maskColor = Colors.white.withOpacity(0.5)
    ..backgroundColor = Colors.white.withOpacity(0.5)
    ..indicatorColor = AppColors.blue
    ..textColor = Colors.red
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..boxShadow = <BoxShadow>[]
    ..contentPadding = EdgeInsets.zero
    ..dismissOnTap = false;
  EasyLoading.show(
    maskType: EasyLoadingMaskType.custom,
  );
}

void eazyShowError({required String title}) {
  EasyLoadingStyle.custom;
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 70
    ..backgroundColor = Colors.white.withOpacity(0.9)
    ..indicatorColor = Colors.red
    ..textColor = Colors.red
    ..maskColor = Colors.black.withOpacity(0.5)
    ..radius = 22
    ..contentPadding = const EdgeInsets.all(18)
    ..boxShadow = [
      BoxShadow(
        color: AppColors.softBlue.withOpacity(0.3),
        spreadRadius: 0,
        blurRadius: 2,
      ),
    ]
    ..textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15)
    ..dismissOnTap = false;
  EasyLoading.showError(title);
}

void eazyShowInfo({required String info}) {
  EasyLoadingStyle.custom;
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 5000)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 70
    ..maskColor = Colors.white.withOpacity(0)
    ..backgroundColor = Colors.white.withOpacity(1)
    ..indicatorColor = AppColors.blue
    ..textColor = Colors.black
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.custom
    ..loadingStyle = EasyLoadingStyle.custom
    ..boxShadow = <BoxShadow>[]
    ..contentPadding = const EdgeInsets.all(12)
    ..dismissOnTap = true;
  EasyLoading.showInfo(info);
}
