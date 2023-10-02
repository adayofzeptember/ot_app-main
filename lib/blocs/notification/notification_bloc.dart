import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/notification_model.dart';
import '../../services/notification_sqlite/notification_db.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState(id: '', title: '', body: '')) {
    on<GetMessage>((event, emit) async {
      print("**************************************************");
      late NotificationDatabase _db; // อ้างอิงฐานข้อมูล
      late Future<NotificationModel> notificationModel; // ลิสรายการ
      _db = NotificationDatabase.instance;
      notificationModel = _db.readLastData(); // แสดงรายการหนังสือ
      await notificationModel.then((value) {
        emit(state.copyWith(
          id: "${value.id}",
          title: value.title,
          body: value.body,
        ));
      }, onError: (e) {
        print("Error Notification $e");
      });
      print("**************************************************");
    });
  }
}
