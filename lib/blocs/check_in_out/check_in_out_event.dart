// ignore_for_file: must_be_immutable

part of 'check_in_out_bloc.dart';

abstract class CheckInOutEvent extends Equatable {
  const CheckInOutEvent();

  @override
  List<Object> get props => [];
}

class StreamLocation extends CheckInOutEvent {
  var context;
  StreamLocation({required this.context});
}

class DistanceEvent extends CheckInOutEvent {
  double distance, lat, lng;
  DistanceEvent({required this.distance, required this.lat, required this.lng});
}

class LoadCheckIn extends CheckInOutEvent {}

class CheckInTime extends CheckInOutEvent {
  var context;
  CheckInTime({required this.context});
}

class ScanQrCode extends CheckInOutEvent {
  String scanText;
  ScanQrCode({required this.scanText});
}
