import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ot_app/routes/route_fade.dart';
import 'package:ot_app/screens/main_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_easy.dart';
import '../../config/app_config.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(loading: false, check: false, username: '', password: '')) {
    on<CheckLogin>((event, emit) async {
      if (event.email != '' && event.password != '') {
        emit(state.copyWith(loading: true));
        final prefs = await SharedPreferences.getInstance();
        final dio = Dio();
        try {
          final response = await dio.post(
            "$apiProduction/token-request",
            options: Options(
              contentType: Headers.formUrlEncodedContentType,
              responseType: ResponseType.json,
              validateStatus: (_) => true,
            ),
            data: {
              'email': event.email,
              'password': event.password,
            },
          );
          if (response.statusCode == 200) {
            emit(state.copyWith(check: false, loading: false));
            await prefs.setString('token', response.data['token']);
            await Navigator.push(event.context, RouteFade.noSlide(MainNavigationBar()));
          } else {
            print('fail');
            eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
            emit(state.copyWith(check: true, loading: false));
          }
        } on Exception catch (e) {
          eazyShowError(title: 'Something went wrong!\n${e}');
          print("Exception $e");
          emit(state.copyWith(check: true, loading: false));
        }
      } else {
        EasyLoading.showToast('Plase enter email and password!');
        emit(state.copyWith(check: true, loading: false));
      }
    });
  }
}
