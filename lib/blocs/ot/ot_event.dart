// ignore_for_file: must_be_immutable

part of 'ot_bloc.dart';

abstract class OtEvent extends Equatable {
  const OtEvent();

  @override
  List<Object> get props => [];
}

class ChangefocusedDay extends OtEvent {
  DateTime focusedDay;
  ChangefocusedDay({required this.focusedDay});
}

class ChangeStartTime extends OtEvent {
  // DateTime startTime;
  String startTime;
  ChangeStartTime({required this.startTime});
}

class ChangeEndTime extends OtEvent {
  // DateTime endTime;
  String endTime;

  ChangeEndTime({required this.endTime});
}

class SendOtTime extends OtEvent {
  var context;
  String note;
  SendOtTime({required this.context, required this.note});
}

class CancelOtTime extends OtEvent {
  String id;
  var context;
  CancelOtTime({required this.context, required this.id});
}

class ClearState extends OtEvent {}

class OtWait extends OtEvent {}

class OtOnly extends OtEvent {
  int month, year;
  String selectItem;
  OtOnly({required this.selectItem, required this.month, required this.year});
}

// class OtAll extends OtEvent {}
