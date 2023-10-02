// กำหนดชื่อตารางไว้ในตัวแปร
final String tableNotification = 'notifications';

// กำหนดฟิลด์ข้อมูลของตาราง
class NotificationFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [id, title, body];

  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static final String id = '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static final String title = 'title';
  static final String body = 'body';
  static final String publication_date = 'publication_date';
}

// ส่วนของ Data Model ของหนังสือ
class NotificationModel {
  final int? id; // จะใช้ค่าจากที่ gen ในฐานข้อมูล
  final String title;
  final String body;
  final DateTime publication_date;

  // constructor
  const NotificationModel({
    this.id,
    required this.title,
    required this.body,
    required this.publication_date,
  });

  // ฟังก์ชั่นสำหรับ สร้างข้อมูลใหม่ โดยรองรับแก้ไขเฉพาะฟิลด์ที่ต้องการ
  NotificationModel copy({
    int? id,
    String? title,
    String? body,
    DateTime? publication_date,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        publication_date: publication_date ?? this.publication_date,
      );

  // สำหรับแปลงข้อมูลจาก Json เป็น Book object
  static NotificationModel fromJson(Map<String, Object?> json) => NotificationModel(
        id: json[NotificationFields.id] as int?,
        title: json[NotificationFields.title] as String,
        body: json[NotificationFields.body] as String,
        publication_date: DateTime.parse(json[NotificationFields.publication_date] as String),
      );

  // สำหรับแปลง Book object เป็น Json บันทึกลงฐานข้อมูล
  Map<String, Object?> toJson() => {
        NotificationFields.id: id,
        NotificationFields.title: title,
        NotificationFields.body: body,
        NotificationFields.publication_date: publication_date.toIso8601String(),
      };
}
