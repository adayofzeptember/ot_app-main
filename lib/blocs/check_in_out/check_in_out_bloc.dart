import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/screens/main_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_easy.dart';
import '../../config/app_config.dart';
// import '../../widgets/layout/main_menu.dart';

part 'check_in_out_event.dart';
part 'check_in_out_state.dart';

class CheckInOutBloc extends Bloc<CheckInOutEvent, CheckInOutState> {
  CheckInOutBloc()
      : super(CheckInOutState(
          distance: "0.0",
          checkIn: DateTime.now(),
          checkOut: DateTime.now(),
          checkBtn: false,
          ifIn: false,
          ifOut: false,
          lat: 0.0,
          lng: 0.0,
          scanText: "",
        )) {
    on<StreamLocation>((event, emit) async {
      Map<Permission, PermissionStatus>? statusLocation = await [
        Permission.locationWhenInUse,
        // Permission.locationAlways,
      ].request();
      if (statusLocation[Permission.locationWhenInUse]!.isGranted) {
        // print("Location Permission is granted");
        LocationSettings locationSettings;
        if (defaultTargetPlatform == TargetPlatform.android) {
          locationSettings = AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 25,
            forceLocationManager: false,
            intervalDuration: const Duration(seconds: 5),
          );
        } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
          locationSettings = AppleSettings(
            accuracy: LocationAccuracy.high,
            activityType: ActivityType.fitness,
            distanceFilter: 25,
            pauseLocationUpdatesAutomatically: true,
            showBackgroundLocationIndicator: false,
          );
        } else {
          locationSettings = const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 25, // ความถี่ในการรับตำแหน่ง
          );
        }
        Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) async {
          double distance = calculateDistance(14.980237252731254, 102.07856504186218, position!.latitude, position.longitude);
          add(DistanceEvent(
            distance: distance,
            lat: position.latitude,
            lng: position.longitude,
          ));
        });
      } else {
        print("Location Permission is denied.");
        showGeneralDialog(
          barrierDismissible: false,
          barrierLabel: '',
          barrierColor: Colors.black38,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (ctx, anim1, anim2) => AlertDialog(
            title: const Text('แอปพลิเคชั่นต้องการเข้าถึงตำแหน่ง'),
            content: const Text(
                'ต้องการอนุญาตการเข้าถึงตำแหน่งตลอดเวลา เพื่อเปิดใช้งาน\nกดยืนยัน->สิทธิการเข้าถึง->ตำแหน่ง->อนุญาติตลอดเวลา กลับมาที่แอปแล้วกดลองใหม่'),
            elevation: 2,
            actions: [
              TextButton(
                onPressed: () async {
                  // Navigator.pushAndRemoveUntil(
                  //   event.context,
                  //   MaterialPageRoute(builder: (context) => MainMenuBar()), // this mymainpage is your page to refresh
                  //   (Route<dynamic> route) => false,
                  // );
                  Navigator.pushReplacement(event.context, RouteFade.noSlide(const MainNavigationBar()));
                },
                child: const Text(
                  'ลองใหม่',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                },
                child: const Text('ตั้งค่า'),
              ),
            ],
          ),
          transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
            child: FadeTransition(
              child: child,
              opacity: anim1,
            ),
          ),
          context: event.context,
        );
        return null;
      }
    });

    on<DistanceEvent>((event, emit) async {
      emit(state.copyWith(
        distance: event.distance.toStringAsFixed(3),
        lat: event.lat,
        lng: event.lng,
      ));
    });

    on<LoadCheckIn>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();
      try {
        final response = await dio.get(
          "$apiProduction/assign",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (_) => true,
          ),
        );
        if (response.statusCode == 200) {
          if (response.data["data"].length != 0) {
            if (response.data["data"]["check_in"] != null) {
              DateTime check_in = DateTime.parse(response.data["data"]["check_in"]);
              emit(state.copyWith(
                checkIn: check_in,
                checkBtn: true,
                ifIn: true,
              ));
            }
            if (response.data["data"]["check_out"] != null) {
              DateTime check_out = DateTime.parse(response.data["data"]["check_out"]);
              emit(state.copyWith(
                checkOut: check_out,
                checkBtn: false,
                ifOut: true,
              ));
            }
          }
        } else {
          eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        print("Exception $e");
      }
    });

    on<CheckInTime>((event, emit) async {
      // DateTime dateNow = DateTime.now();
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();

      if (state.checkBtn == false) {
        // emit(state.copyWith(checkIn: dateNow, checkBtn: true, ifIn: true));
        try {
          final response = await dio.post(
            "$apiProduction/check-in",
            options: Options(
              headers: {
                "Authorization": "Bearer $token",
              },
              contentType: Headers.formUrlEncodedContentType,
              responseType: ResponseType.json,
              followRedirects: false,
              validateStatus: (_) => true,
            ),
            data: {
              'deviceInfo': null,
              'lat': state.lat,
              'lon': state.lng,
            },
          );
          if (response.data["status"] == true) {
            add(LoadCheckIn());
          } else {
            eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
          }
        } on Exception catch (e) {
          eazyShowError(title: 'Something went wrong!\n${e}');
          print("Exception $e");
        }
      } else {
        // emit(state.copyWith(checkOut: dateNow, checkBtn: false, ifOut: true));
        try {
          final response = await dio.post(
            "$apiProduction/check-out",
            options: Options(
              headers: {
                "Authorization": "Bearer $token",
              },
              contentType: Headers.formUrlEncodedContentType,
              responseType: ResponseType.json,
              followRedirects: false,
              validateStatus: (_) => true,
            ),
            data: {
              'deviceInfo': {"test": 0},
              'lat': state.lat,
              'lon': state.lng,
            },
          );
          if (response.data["status"] == true) {
            add(LoadCheckIn());
          } else {
            eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
          }
        } on Exception catch (e) {
          eazyShowError(title: 'Something went wrong!\n${e}');
          print("Exception $e");
        }
      }
      Navigator.pop(event.context);
    });

    on<ScanQrCode>((event, emit) async {
      emit(state.copyWith(scanText: event.scanText));
    });
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
