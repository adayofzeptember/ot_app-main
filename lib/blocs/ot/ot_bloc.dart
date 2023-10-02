import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/routes/route_side.dart';
import 'package:ot_app/screens/ot/page_ot_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_easy.dart';
import '../../models/ot_history_model.dart';
import '../../config/app_config.dart';

part 'ot_event.dart';
part 'ot_state.dart';

class OtBloc extends Bloc<OtEvent, OtState> {
  OtBloc()
      : super(OtState(
          focusedDay: DateTime.now(),
          startTime: '',
          endTime: '',
          checkSuccess: false,
          loading: false,
          pageLoading: false,
          dataOnly: [],
          dataWait: [],
          selectYear: int.parse(DateTime.now().year.toString()),
          selectMonth: int.parse(DateTime.now().month.toString()),
          page: 1,
          // dataAll: [],
          selectDate: "",
          sumWages: 0.0,
          checkHr: false,
        )) {
    on<ChangefocusedDay>((event, emit) {
      emit(state.copyWith(focusedDay: event.focusedDay));
    });

    on<ChangeStartTime>((event, emit) {
      print(event.startTime);
      emit(state.copyWith(startTime: event.startTime));
    });

    on<ChangeEndTime>((event, emit) {
      print(event.endTime);
      emit(state.copyWith(endTime: event.endTime));
    });

    on<SendOtTime>((event, emit) async {
      emit(state.copyWith(loading: true));
      // var formatterDate = DateFormat.yMd();
      // var formatterTime = DateFormat.Hm('en');
      var date = state.focusedDay.toString().split(' ');
      String dateOt = date[0];

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();

      try {
        final response = await dio.post(
          "$apiProduction/ot-add",
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
            'otTakeDate': dateOt,
            'otStart': state.startTime,
            'otEnd': state.endTime,
            'otNote': event.note,
          },
        );

        print(response.statusCode);
        if (response.statusCode == 200) {
          eazyShowSuccess(title: "บันทึกสำเร็จ");
          emit(state.copyWith(
            checkSuccess: true,
            loading: false,
          ));
          Navigator.pushReplacement(event.context, RouteSide.slideLeft(const PageOtInfo()));
        } else {
          eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
          emit(state.copyWith(loading: false));
          print('fail');
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        emit(state.copyWith(loading: false));
        print("Exception $e");
      }
    });

    on<CancelOtTime>((event, emit) async {
      emit(state.copyWith(pageLoading: true));
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();
      Navigator.pop(event.context);
      try {
        final response = await dio.post(
          "$apiProduction/ot-delete",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (_) => true,
          ),
          data: {'otId': event.id},
        );
        if (response.statusCode == 200 && response.data['status'] == true) {
          add(OtWait());
          eazyShowSuccess(title: 'Successfully deleted!');
        } else {
          eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
          emit(state.copyWith(pageLoading: true));
          print('fail');
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        emit(state.copyWith(pageLoading: true));
        print("Exception $e");
      }
    });

    on<ClearState>((event, emit) async {
      print("ClearState");
      emit(state.copyWith(
        focusedDay: DateTime.now(),
        startTime: '',
        endTime: '',
        checkSuccess: false,
        loading: false,
        pageLoading: false,
        dataOnly: [],
        dataWait: [],
        selectYear: int.parse(DateTime.now().year.toString()),
        selectMonth: int.parse(DateTime.now().month.toString()),
        page: 1,
        // dataAll: [],
      ));
    });

    on<OtWait>((event, emit) async {
      emit(state.copyWith(pageLoading: true));
      var formatterDate = DateFormat.yMd();
      var formatterTime = DateFormat.Hm('en');
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      emit(state.copyWith(checkHr: (prefs.getString("segment") == "Mobile App Developer") ? true : false));
      final dio = Dio();
      List dataOt = [];
      try {
        final response = await dio.get(
          "$apiProduction/ot-wait",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            validateStatus: (_) => true,
          ),
        );
        if (response.statusCode == 200) {
          double sumWages = 0;
          for (var el in response.data) {
            final DateTime startTime = DateTime.fromMillisecondsSinceEpoch(el['start_time'] * 1000);
            final DateTime endTime = DateTime.fromMillisecondsSinceEpoch(el['end_time'] * 1000);
            sumWages += el['wages'];
            dataOt.add(OtHistory(
              id: el['id'],
              takeDate: formatterDate.format(DateTime.parse(el['take_date'])),
              takeTime: "${formatterTime.format(startTime)}-${formatterTime.format(endTime)}",
              rate: el['rate'].toString(),
              mode: (el['mode'] == 0)
                  ? "Normal"
                  : (el['mode'] == 1)
                      ? "Weekend"
                      : (el['mode'] == 2)
                          ? "Holiday"
                          : "-",
              wages: el['wages'].toString(),
              status: (el['status'] == 0)
                  ? "รออนุมัติ"
                  : (el['status'] == 1)
                      ? "อนุมัติ"
                      : (el['status'] == 2)
                          ? "ปฏิเสธ"
                          : "Unknow",
              note: el['note'] ?? '-',
            ));
          }
          emit(state.copyWith(dataWait: dataOt, pageLoading: false, sumWages: sumWages));
        } else {
          eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
          emit(state.copyWith(pageLoading: false));
          print('fail');
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        emit(state.copyWith(pageLoading: false));
        print("Exception $e");
      }
    });

    on<OtOnly>((event, emit) async {
      var formatterDate = DateFormat.yMd();
      var formatterTime = DateFormat.Hm('en');
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();
      List dataOt = [];
      emit(state.copyWith(
        pageLoading: true,
        selectYear: event.year != 0 ? event.year : state.selectYear,
        selectMonth: event.month != 0 ? event.month : state.selectMonth,
        selectDate: event.selectItem,
      ));

      try {
        final response = await dio.get(
          "$apiProduction/ot-month/${state.selectYear + 543}/${state.selectMonth}",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            validateStatus: (_) => true,
          ),
        );
        if (response.statusCode == 200) {
          double sumWages = 0;
          for (var el in response.data['data']) {
            final DateTime startTime = DateTime.fromMillisecondsSinceEpoch(el['start_time'] * 1000);
            final DateTime endTime = DateTime.fromMillisecondsSinceEpoch(el['end_time'] * 1000);
            sumWages += el['wages'];
            dataOt.add(OtHistory(
              id: el['id'],
              takeDate: formatterDate.format(DateTime.parse(el['take_date'])),
              takeTime: "${formatterTime.format(startTime)}-${formatterTime.format(endTime)}",
              rate: el['rate'].toString(),
              mode: (el['mode'] == 0)
                  ? "Normal"
                  : (el['mode'] == 1)
                      ? "Weekend"
                      : (el['mode'] == 2)
                          ? "Holiday"
                          : "-",
              wages: el['wages'].toString(),
              status: (el['status'] == 0)
                  ? "รออนุมัติ"
                  : (el['status'] == 1)
                      ? "อนุมัติ"
                      : (el['status'] == 2)
                          ? "ปฏิเสธ"
                          : "Unknow",
              note: el['note'] ?? '-',
            ));
          }
          emit(state.copyWith(
            dataOnly: dataOt,
            pageLoading: false,
            sumWages: sumWages,
          ));
        } else {
          eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
          print('fail');
          emit(state.copyWith(pageLoading: false));
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        emit(state.copyWith(pageLoading: false));
        print("Exception $e");
      }
    });

    // on<OtAll>((event, emit) async {
    //   emit(state.copyWith(pageLoading: (state.page == 1) ? true : false));
    //   var formatterDate = DateFormat.yMd();
    //   var formatterTime = DateFormat.Hm('en');
    //   final prefs = await SharedPreferences.getInstance();
    //   String? token = prefs.getString('token');
    //   final dio = Dio();
    //   List dataOt = (state.dataAll != []) ? state.dataAll : [];
    //   try {
    //     if (state.loading == false) {
    //       final response = await dio.get(
    //         "$apiProduction/ot-all?page=${state.page}",
    //         options: Options(
    //           headers: {
    //             "Authorization": "Bearer $token",
    //           },
    //           contentType: Headers.formUrlEncodedContentType,
    //           responseType: ResponseType.json,
    //           validateStatus: (_) => true,
    //         ),
    //       );
    //       if (response.statusCode == 200) {
    //         double sumWages = 0;
    //         for (var el in response.data['data']) {
    //           final DateTime startTime = DateTime.fromMillisecondsSinceEpoch(el['start_time'] * 1000);
    //           final DateTime endTime = DateTime.fromMillisecondsSinceEpoch(el['end_time'] * 1000);

    //           sumWages += el['wages'];
    //           dataOt.add(OtHistory(
    //             id: el['id'],
    //             takeDate: formatterDate.format(DateTime.parse(el['take_date'])),
    //             takeTime: "${formatterTime.format(startTime)}-${formatterTime.format(endTime)}",
    //             rate: el['rate'].toString(),
    //             mode: (el['mode'] == 0)
    //                 ? "Normal"
    //                 : (el['mode'] == 1)
    //                     ? "Weekend"
    //                     : (el['mode'] == 2)
    //                         ? "Holiday"
    //                         : "-",
    //             wages: el['wages'].toString(),
    //             status: (el['status'] == 0)
    //                 ? "รออนุมัติ"
    //                 : (el['status'] == 1)
    //                     ? "อนุมัติ"
    //                     : (el['status'] == 2)
    //                         ? "ปฏิเสธ"
    //                         : "Unknow",
    //             note: el['note'] ?? '-',
    //           ));
    //         }
    //         emit(state.copyWith(
    //           dataAll: dataOt,
    //           page: (state.page != response.data['last_page']) ? state.page + 1 : state.page,
    //           loading: (dataOt.length == response.data['total']) ? true : false,
    //           pageLoading: false,
    //           sumWages: sumWages,
    //         ));
    //         // print("1:${dataOt.length}");
    //         // print("2:${response.data['total']}");
    //         // print(state.loading);
    //       } else {
    //         emit(state.copyWith(pageLoading: false));
    //         print('fail');
    //       }
    //     }
    //   } on Exception catch (e) {
    //     emit(state.copyWith(pageLoading: false));
    //     eazyShowError(title: 'Something went wrong!\n${e}');
    //     print("Exception $e");
    //   }
    // });
  }
}
