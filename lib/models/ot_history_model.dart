class OtHistory {
  OtHistory({
    required this.id,
    required this.takeDate,
    required this.takeTime,
    required this.note,
    required this.rate,
    required this.mode,
    required this.wages,
    required this.status,
  });
  int? id;
  String? takeDate;
  String? takeTime;
  String? note;
  String? rate;
  String? mode;
  String? wages; //ค้าจ้าง
  String? status;
}
