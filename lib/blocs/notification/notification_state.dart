part of 'notification_bloc.dart';

// ignore: must_be_immutable
class NotificationState extends Equatable {
  String title, body, id;

  NotificationState({
    required this.title,
    required this.body,
    required this.id,
  });

  NotificationState copyWith({
    String? title,
    body,
    id,
  }) {
    return NotificationState(
      title: title ?? this.title,
      body: body ?? this.body,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [title, body, id];
}
