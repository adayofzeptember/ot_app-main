part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoadAccount extends AccountEvent {
  var context;
  LoadAccount({required this.context});
}

class Announcement extends AccountEvent {}
