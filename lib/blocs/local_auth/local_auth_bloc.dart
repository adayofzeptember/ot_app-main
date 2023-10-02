import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc() : super(LocalAuthState(pin: "", switchPin: false, switchLocal: false)) {
    on<PinAuth>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? pinAuth = prefs.getString("pin_auth");
      if (pinAuth != null) {
        emit(state.copyWith(switchPin: true));
      } else {
        emit(state.copyWith(switchPin: false));
      }
    });
    on<AuthLocal>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      bool? localAuth = await prefs.getBool("local_auth");
      emit(state.copyWith(switchLocal: (localAuth != null) ? localAuth : false));
    });
  }
}
