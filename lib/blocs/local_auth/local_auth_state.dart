part of 'local_auth_bloc.dart';

// ignore: must_be_immutable
class LocalAuthState extends Equatable {
  LocalAuthState({
    required this.pin,
    required this.switchPin,
    required this.switchLocal,
  });

  String pin;
  bool switchPin, switchLocal;

  LocalAuthState copyWith({
    String? pin,
    bool? switchPin,
    switchLocal,
  }) {
    return LocalAuthState(
      pin: pin ?? this.pin,
      switchPin: switchPin ?? this.switchPin,
      switchLocal: switchLocal ?? this.switchLocal,
    );
  }

  @override
  List<Object> get props => [pin, switchPin, switchLocal];
}
