part of 'check_in_out_bloc.dart';

// ignore: must_be_immutable
class CheckInOutState extends Equatable {
  CheckInOutState({
    required this.distance,
    required this.checkIn,
    required this.checkOut,
    required this.checkBtn,
    required this.ifIn,
    required this.ifOut,
    required this.lat,
    required this.lng,
    required this.scanText,
  });

  String distance;
  DateTime checkIn, checkOut;
  bool checkBtn, ifIn, ifOut;
  double lat, lng;
  String scanText;

  CheckInOutState copyWith({
    String? distance,
    DateTime? checkIn,
    DateTime? checkOut,
    bool? checkBtn,
    bool? ifIn,
    bool? ifOut,
    double? lat,
    double? lng,
    String? scanText,
  }) {
    return CheckInOutState(
      distance: distance ?? this.distance,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      checkBtn: checkBtn ?? this.checkBtn,
      ifIn: ifIn ?? this.ifIn,
      ifOut: ifOut ?? this.ifOut,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      scanText: scanText ?? this.scanText,
    );
  }

  @override
  List<Object> get props => [
        distance,
        checkIn,
        checkOut,
        checkBtn,
        ifIn,
        ifOut,
        lat,
        lng,
        scanText,
      ];
}
