import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ot_app/models/announcement_model.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/screens/login/page_login.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_easy.dart';
import '../../config/app_config.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc()
      : super(AccountState(
          email: "",
          urlProfile: "",
          firstname: "",
          lastname: "",
          phone: "",
          birthDate: "",
          joinDate: "",
          department: "",
          segment: "",
          versionApp: '',
          announcement: AnnouncementModel(text: "", dateTime: ""),
          birthDateEdit: "",
          gender: "",
        )) {
    on<LoadAccount>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();
      try {
        final response = await dio.get(
          "$apiProduction/user",
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
        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        if (response.statusCode == 200) {
          emit(state.copyWith(
            email: response.data['email'],
            urlProfile: response.data['avatar']['url'],
            firstname: response.data['firstname'],
            lastname: response.data['lastname'],
            phone: response.data['phone'],
            birthDate: response.data['birthdate']['th'],
            joinDate: response.data['join_date']['th'],
            department: response.data['department']['name'],
            segment: response.data['segment']['name'],
            birthDateEdit: response.data["birthdate"]["en"],
            gender: response.data["gender"]["name"],
            versionApp: packageInfo.version,
          ));
          // await prefs.setString('segment', response.data['segment']['name']);
        } else {
          EasyLoading.showToast('Session Expired');
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          await Navigator.pushReplacement(event.context, RouteFade.noSlide(PageLogin()));
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        print("Exception $e");
      }
    });

    on<Announcement>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();
      try {
        final response = await dio.get(
          "$apiProduction/announcement",
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
          emit(state.copyWith(
            announcement: AnnouncementModel(
              text: response.data["text"],
              dateTime: response.data["created_at"],
            ),
          ));
        } else {
          emit(state.copyWith(
            announcement: AnnouncementModel(
              text: "ไม่มีประกาศ",
              dateTime: "",
            ),
          ));
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        print("Exception $e");
      }
    });
  }
}
