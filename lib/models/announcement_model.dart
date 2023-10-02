class AnnouncementModel {
  String text, dateTime;
  AnnouncementModel({required this.text, required this.dateTime});

  AnnouncementModel copyWith({String? text, String? dateTime}) {
    return AnnouncementModel(text: text ?? this.text, dateTime: dateTime ?? this.dateTime);
  }
}
