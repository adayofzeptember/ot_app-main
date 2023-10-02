part of 'local_auth_bloc.dart';

class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();

  @override
  List<Object> get props => [];
}

class PinAuth extends LocalAuthEvent {}

class AuthLocal extends LocalAuthEvent {}
