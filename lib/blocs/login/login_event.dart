part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CheckLogin extends LoginEvent {
  var context;
  String email, password;
  CheckLogin(this.context, this.email, this.password);
}
