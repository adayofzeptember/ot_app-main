part of 'leaves_bloc.dart';

abstract class LeavesEvent extends Equatable {
  const LeavesEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CheckBoxType extends LeavesEvent {
  String value;
  CheckBoxType({required this.value});
}

class ClearState extends LeavesEvent {}

// ignore: must_be_immutable
class SubmitLeave extends LeavesEvent {
  String leaveCause;
  int leaveMode, leaveType;
  DateTime leaveStart, leaveEnd;
  List<XFile> imageFileList;
  var context;
  SubmitLeave({
    required this.context,
    required this.leaveCause,
    required this.leaveMode,
    required this.leaveType,
    required this.leaveStart,
    required this.leaveEnd,
    required this.imageFileList,
  });
}

// ignore: must_be_immutable
class HistoryOnly extends LeavesEvent {
  int month, year;
  String selectItem;
  HistoryOnly({required this.selectItem, required this.month, required this.year});
}

// ignore: must_be_immutable
class HisWait extends LeavesEvent {
  var context;
  HisWait({this.context});
}

// ignore: must_be_immutable
class HisAll extends LeavesEvent {
  var context;
  HisAll({required this.context});
}

// ignore: must_be_immutable
class CancelLeave extends LeavesEvent {
  String id;
  var context;
  CancelLeave({required this.context, required this.id});
}

class LeaveSummary extends LeavesEvent {}

// ignore: must_be_immutable
class WatchDocument extends LeavesEvent {
  List image;
  WatchDocument({
    required this.image,
  });
}
