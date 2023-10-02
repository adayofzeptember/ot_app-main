import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ot_app/models/leave_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/custom_easy.dart';
import '../../config/app_config.dart';
import '../../routes/route_side.dart';
import '../../screens/leave/page_leave_info.dart';

part 'leaves_event.dart';
part 'leaves_state.dart';

class LeavesBloc extends Bloc<LeavesEvent, LeavesState> {
  LeavesBloc()
      : super(LeavesState(
          selectMonth: 0,
          selectYear: 0,
          checkSuccess: false,
          loading: false,
          dataOnly: [],
          rangeSelectionMode: RangeSelectionMode.toggledOn,
          page: 1,
          pageLoading: false,
          // dataAll: [],
          // dataWait: [],
          showImage: [],
          selectDate: "",
          leaveSummary: LeaveSummaryModel(
            sick: LeaveSummaryModelData(usage: 0, remain: 0, total: 0),
            personal: LeaveSummaryModelData(usage: 0, remain: 0, total: 0),
            annual: LeaveSummaryModelData(usage: 0, remain: 0, total: 0),
          ),
        )) {
    on<ClearState>((event, emit) async {
      print('clear');
      emit(state.copyWith(
        leaveMode: '0',
        leaveType: '1',
        checkSuccess: false,
        loading: false,
        page: 1,
        // dataAll: [],
        // dataWait: [],
      ));
    });

    on<SubmitLeave>((event, emit) async {
      emit(state.copyWith(loading: true));
      var leaveStart = event.leaveStart.toString().split(' ');
      var leaveEnd = event.leaveEnd.toString().split(' ');

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();

      var allImages = [];
      for (var element in event.imageFileList) {
        var file = MultipartFile.fromFileSync(element.path, filename: element.name);
        allImages.add(file);
      }
      final formData = FormData.fromMap({
        "leaveCause": event.leaveCause,
        "leaveMode": event.leaveMode,
        "leaveType": event.leaveType,
        "leaveStart": leaveStart[0],
        "leaveEnd": (event.leaveType == 2) ? leaveEnd[0] : "",
        'image[]': allImages,
      });
      try {
        final response = await dio.post(
          "$apiProduction/leave-add",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (_) => true,
          ),
          data: formData,
        );

        print(response.data);
        if (response.statusCode == 200) {
          eazyShowSuccess(title: "บันทึกสำเร็จ");
          Navigator.pushReplacement(event.context, RouteSide.slideLeft(const PageLeaveInfo()));
          emit(state.copyWith(
            checkSuccess: true,
            loading: false,
          ));
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

    on<HistoryOnly>((event, emit) async {
      var formatterDate = DateFormat.yMd();
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final dio = Dio();
      List dataOnly = [];
      emit(state.copyWith(
        pageLoading: true,
        selectYear: event.year != 0 ? event.year : state.selectYear,
        selectMonth: event.month != 0 ? event.month : state.selectMonth,
        selectDate: event.selectItem != "" ? event.selectItem : state.selectDate,
      ));
      try {
        final response = await dio.get(
          "$apiProduction/leave-month/${state.selectYear + 543}/${state.selectMonth}",
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
          for (var el in response.data['data']) {
            String date =
                "${formatterDate.format(DateTime.parse(el['start']))}${(el['type'] == 2) ? " - ${formatterDate.format(DateTime.parse(el['end']))}" : ''}";
            dataOnly.add(LeaveHistory(
              id: el['id'],
              reason: el['cause'],
              mode: (el['mode'] == 1)
                  ? "ลากิจ"
                  : (el['mode'] == 2)
                      ? "ลาป่วย"
                      : (el['mode'] == 3)
                          ? "พักร้อน"
                          : (el['mode'] == 4)
                              ? "วันเกิด"
                              : "-",
              type: (el['type'] == 1)
                  ? "วันเดียว"
                  : (el['type'] == 2)
                      ? "หลายวัน"
                      : (el['type'] == 3)
                          ? "ครึ่งวัน(เช้า)"
                          : (el['type'] == 4)
                              ? "ครั้งวัน(เย็น)"
                              : "-",
              date: date,
              status: (el['status'] == 0)
                  ? "Pending"
                  : (el['status'] == 1)
                      ? "Approve"
                      : (el['status'] == 2)
                          ? "Reject"
                          : "Unknow",
              images: el['images'] ?? [],
            ));
          }
          emit(state.copyWith(
            dataOnly: dataOnly,
            pageLoading: false,
          ));
        } else {
          print('fail');
          emit(state.copyWith(pageLoading: false));
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        print("Exception $e");
        emit(state.copyWith(pageLoading: false));
      }
    });

    // on<HisWait>((event, emit) async {
    //   emit(state.copyWith(pageLoading: true));
    //   var formatterDate = DateFormat.yMMMMEEEEd();
    //   final prefs = await SharedPreferences.getInstance();
    //   String? token = prefs.getString('token');
    //   final dio = Dio();
    //   List dataWait = [];
    //   try {
    //     final response = await dio.get(
    //       "$apiProduction/leave-wait",
    //       options: Options(
    //         headers: {
    //           "Authorization": "Bearer $token",
    //         },
    //         contentType: Headers.formUrlEncodedContentType,
    //         responseType: ResponseType.json,
    //         validateStatus: (_) => true,
    //       ),
    //     );
    //     if (response.statusCode == 200) {
    //       for (var el in response.data) {
    //         String date =
    //             "${formatterDate.format(DateTime.parse(el['start']))}${(el['type'] == 2) ? " - ${formatterDate.format(DateTime.parse(el['end']))}" : ''}";
    //         dataWait.add(LeaveHistory(
    //           id: el['id'],
    //           reason: el['cause'],
    //           mode: (el['mode'] == 1)
    //               ? "ลากิจ"
    //               : (el['mode'] == 2)
    //                   ? "ลาป่วย"
    //                   : (el['mode'] == 3)
    //                       ? "พักร้อน"
    //                       : (el['mode'] == 4)
    //                           ? "วันเกิด"
    //                           : "-",
    //           type: (el['type'] == 1)
    //               ? "วันเดียว"
    //               : (el['type'] == 2)
    //                   ? "หลายวัน"
    //                   : (el['type'] == 3)
    //                       ? "ครึ่งวัน(เช้า)"
    //                       : (el['type'] == 4)
    //                           ? "ครั้งวัน(เย็น)"
    //                           : "-",
    //           date: date,
    //           status: (el['status'] == 0)
    //               ? "Pending"
    //               : (el['status'] == 1)
    //                   ? "Approve"
    //                   : (el['status'] == 2)
    //                       ? "Reject"
    //                       : "Unknow",
    //           images: el['images'] ?? [],
    //         ));
    //       }
    //       emit(state.copyWith(
    //         dataWait: dataWait,
    //         pageLoading: false,
    //       ));
    //     } else {
    //       eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
    //       emit(state.copyWith(pageLoading: false));
    //       print('fail');
    //     }
    //   } on Exception catch (e) {
    //     eazyShowError(title: 'Something went wrong!\n${e}');
    //     emit(state.copyWith(pageLoading: false));
    //     print("Exception $e");
    //   }
    // });

    // on<HisAll>((event, emit) async {
    //   emit(state.copyWith(pageLoading: (state.page == 1) ? true : false));
    //   var formatterDate = DateFormat.yMMMd();
    //   final prefs = await SharedPreferences.getInstance();
    //   String? token = prefs.getString('token');
    //   final dio = Dio();
    //   var dataAll = (state.dataAll != []) ? state.dataAll : [];
    //   try {
    //     if (state.loading == false) {
    //       final response = await dio.get(
    //         "$apiProduction/leave-all?page=${state.page}",
    //         options: Options(
    //           headers: {
    //             "Authorization": "Bearer $token",
    //           },
    //           contentType: Headers.formUrlEncodedContentType,
    //           responseType: ResponseType.json,
    //           validateStatus: (_) => true,
    //         ),
    //       );
    //       // print(response.data["data"]);
    //       if (response.statusCode == 200) {
    //         for (var el in response.data["data"]) {
    //           String date =
    //               "${formatterDate.format(DateTime.parse(el['start']))}${(el['type'] == 2) ? " - ${formatterDate.format(DateTime.parse(el['end']))}" : ''}";
    //           dataAll.add(LeaveHistory(
    //             id: el['id'],
    //             reason: el['cause'],
    //             mode: (el['mode'] == 1)
    //                 ? "ลากิจ"
    //                 : (el['mode'] == 2)
    //                     ? "ลาป่วย"
    //                     : (el['mode'] == 3)
    //                         ? "ลาพักร้อน"
    //                         : (el['mode'] == 4)
    //                             ? "วันเกิด"
    //                             : "-",
    //             type: (el['type'] == 1)
    //                 ? "วันเดียว"
    //                 : (el['type'] == 2)
    //                     ? "หลายวัน"
    //                     : (el['type'] == 3)
    //                         ? "ครึ่งวัน(เช้า)"
    //                         : (el['type'] == 4)
    //                             ? "ครั้งวัน(เย็น)"
    //                             : "-",
    //             date: date,
    //             status: (el['status'] == 0)
    //                 ? "Pending"
    //                 : (el['status'] == 1)
    //                     ? "Approve"
    //                     : (el['status'] == 2)
    //                         ? "Reject"
    //                         : "Unknow",
    //             images: el['images'] ?? [],
    //           ));
    //         }
    //         emit(state.copyWith(
    //           dataAll: dataAll,
    //           page: (state.page != response.data['last_page']) ? state.page + 1 : state.page,
    //           loading: (dataAll.length == response.data['total']) ? true : false,
    //           pageLoading: false,
    //         ));
    //       } else {
    //         print('fail');
    //         emit(state.copyWith(pageLoading: false));
    //       }
    //     }
    //   } on Exception catch (e) {
    //     emit(state.copyWith(pageLoading: false));
    //     print("Exception $e");
    //   }
    // });

    on<CancelLeave>((event, emit) async {
      emit(state.copyWith(loading: true));
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();
      try {
        final response = await dio.post(
          "$apiProduction/leave-delete",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (_) => true,
          ),
          data: {'leaveId': event.id},
        );

        if (response.statusCode == 200 && response.data['status'] == true) {
          Navigator.pop(event.context);
          // add(HisWait());
          add(HistoryOnly(
            selectItem: state.selectDate,
            month: state.selectMonth,
            year: state.selectYear,
          ));
          eazyShowSuccess(title: "Successfully deleted!");
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

    on<WatchDocument>((event, emit) {
      // print(event.index);
      emit(state.copyWith(showImage: event.image));
    });

    on<LeaveSummary>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final dio = Dio();
      try {
        final response = await dio.get(
          "$apiProduction/leave-sum",
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
              leaveSummary: LeaveSummaryModel(
            sick: LeaveSummaryModelData(
                usage: response.data["sick"]["usage"],
                remain: response.data["sick"]["remain"],
                total: response.data["sick"]["total"]),
            personal: LeaveSummaryModelData(
                usage: response.data["personal"]["usage"],
                remain: response.data["personal"]["remain"],
                total: response.data["personal"]["total"]),
            annual: LeaveSummaryModelData(
                usage: response.data["annual"]["usage"],
                remain: response.data["annual"]["remain"],
                total: response.data["annual"]["total"]),
          )));
        } else {
          eazyShowError(title: 'Something went wrong!\n${response.statusMessage}');
          print('fail');
        }
      } on Exception catch (e) {
        eazyShowError(title: 'Something went wrong!\n${e}');
        print("Exception $e");
      }
    });
  }
}
