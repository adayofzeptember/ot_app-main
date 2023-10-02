part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class SelectDayEvent extends CalendarEvent {
  DateTime select;
  SelectDayEvent({required this.select});
}

class LoadDayEvent extends CalendarEvent {
  // LoadDayEvent({required this.select});
}
