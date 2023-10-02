import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../mockup/calendar_data.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc()
      : super(CalendarState(
          format: CalendarFormat.month,
          selectedDay: DateTime.now(),
          focusedDay: DateTime.now(),
          dayNow: DateTime.now(),
          dayEvents: [],
        )) {
    on<SelectDayEvent>((event, emit) {
      print(event.select);
      emit(state.copyWith(selectedDay: event.select));
    });
    on<LoadDayEvent>((event, emit) {
      List dayEvents = [];
      DateTime dateNow = DateTime.utc(state.dayNow.year, state.dayNow.month, state.dayNow.day);
      if (dateNow.weekday == DateTime.saturday || dateNow.weekday == DateTime.sunday) {
        dayEvents.add("วันหยุดประจำสัปดาห์");
      }
      for (var el in calendarMockup) {
        if ((DateTime.utc(DateTime.parse("${el['start']}").year, DateTime.parse("${el['start']}").month,
                DateTime.parse("${el['start']}").day)) ==
            dateNow) {
          print("------------------------");
          print(el['title']);
          dayEvents.add("${el["title"]}");
        }
      }
      emit(state.copyWith(dayEvents: dayEvents));
    });
  }
}
