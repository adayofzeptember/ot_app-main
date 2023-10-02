part of 'calendar_bloc.dart';

// ignore: must_be_immutable
class CalendarState extends Equatable {
  CalendarState({
    required this.dayEvents,
    required this.format,
    required this.selectedDay,
    required this.focusedDay,
    required this.dayNow,
  });

  List dayEvents;
  CalendarFormat format; //= CalendarFormat.month;
  DateTime selectedDay, //= DateTime.now();
      focusedDay, //= DateTime.now();
      dayNow; //= DateTime.now();
  CalendarState copyWith({
    List? dayEvents,
    CalendarFormat? format,
    DateTime? selectedDay,
    DateTime? focusedDay,
    DateTime? dayNow,
  }) {
    return CalendarState(
      dayEvents: dayEvents ?? this.dayEvents,
      format: format ?? this.format,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      dayNow: dayNow ?? this.dayNow,
    );
  }

  @override
  List<Object> get props => [
        dayEvents,
        format,
        selectedDay,
        focusedDay,
        dayNow,
      ];
}
