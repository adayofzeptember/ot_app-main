part of 'login_bloc.dart';

// ignore: must_be_immutable
class LoginState extends Equatable {
  String username, password;
  bool loading, check;
  LoginState({
    required this.loading,
    required this.check,
    required this.username,
    required this.password,
  });

  LoginState copyWith({
    bool? loading,
    bool? check,
    String? username,
    String? password,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      check: check ?? this.check,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [loading, check, username, password];
}
