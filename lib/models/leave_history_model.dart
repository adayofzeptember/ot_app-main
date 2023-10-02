class LeaveHistory {
  LeaveHistory({
    required this.id,
    required this.reason,
    required this.mode,
    required this.type,
    required this.date,
    required this.status,
    required this.images,
  });
  int? id;
  String? reason;
  String? mode;
  String? type;
  String? date;
  String? status;
  List? images;
}

class LeaveSummaryModel {
  LeaveSummaryModel({required this.sick, required this.personal, required this.annual});

  LeaveSummaryModelData? sick, personal, annual;
}

class LeaveSummaryModelData {
  LeaveSummaryModelData({required this.usage, required this.remain, required this.total});
  double? usage, remain;
  int? total;
}
