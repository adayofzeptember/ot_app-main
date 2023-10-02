// ignore_for_file: unused_local_variable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ot_app/models/notification_model.dart';

import '../components/custom_easy.dart';
import 'notification_sqlite/notification_db.dart';

// import '../utils/notification_service.dart';

class FirebaseApi {
  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    print("notification");
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  final _firebaseMessage = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    NotificationSettings settings = await _firebaseMessage.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    // FirebaseMessaging.instance.requestPermission();
    final fcmToken = await _firebaseMessage.getToken();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("-------------------------------------------------------------------------------------");
      print('User granted permission');
      print('fcmToken: $fcmToken');

      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('Got a message whilst in the foreground!');
        if (message.notification != null) {
          late NotificationDatabase _db = NotificationDatabase.instance; // อ้างอิงฐานข้อมูล
          late Future<List<NotificationModel>> notificationModel; // ลิสรายการ
          eazyShowInfo(info: "${message.notification?.title}\n${message.notification?.body}");

          NotificationModel data = NotificationModel(
            title: "${message.notification?.title}",
            body: "${message.notification?.body}",
            publication_date: DateTime.now(),
          );
          NotificationModel newData = await _db.create(data); // ทำคำสั่งเพิ่มข้อมูลใหม่
        }
      });
      print("-------------------------------------------------------------------------------------");
    } else {
      print('User declined or has not accepted permission');
    }
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  late NotificationDatabase _db = NotificationDatabase.instance; // อ้างอิงฐานข้อมูล
  late Future<List<NotificationModel>> notificationModel; // ลิสรายการ
  NotificationModel data = NotificationModel(
    title: "${message.notification?.title}",
    body: "${message.notification?.body}",
    publication_date: DateTime.now(),
  );
  NotificationModel newData = await _db.create(data); // ทำคำสั่งเพิ่มข้อมูลใหม่
}
