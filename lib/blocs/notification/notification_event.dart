// ignore_for_file: must_be_immutable

part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetMessage extends NotificationEvent {
  // String title, body;
  // GetMessage({required this.title, required this.body});
}
