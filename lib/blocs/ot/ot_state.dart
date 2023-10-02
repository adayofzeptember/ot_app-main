part of 'ot_bloc.dart';

// ignore: must_be_immutable
class OtState extends Equatable {
  OtState({
    required this.focusedDay,
    required this.startTime,
    required this.endTime,
    required this.checkSuccess,
    required this.loading,
    required this.pageLoading,
    required this.dataOnly,
    required this.selectYear,
    required this.selectMonth,
    required this.dataWait,
    required this.page,
    // required this.dataAll,
    required this.selectDate,
    required this.sumWages,
    required this.checkHr,
  });
  DateTime focusedDay;
  String startTime, endTime;
  bool checkSuccess, loading, pageLoading;
  List dataOnly, dataWait;
  // List dataAll;
  int selectYear, selectMonth, page;
  String selectDate;
  double sumWages;
  bool checkHr;

  OtState copyWith({
    DateTime? focusedDay,
    String? startTime,
    String? endTime,
    bool? checkSuccess,
    bool? loading,
    bool? pageLoading,
    List? dataOnly,
    int? selectYear,
    int? selectMonth,
    List? dataWait,
    // List? dataAll,
    int? page,
    String? selectDate,
    double? sumWages,
    bool? checkHr,
  }) {
    return OtState(
      focusedDay: focusedDay ?? this.focusedDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      checkSuccess: checkSuccess ?? this.checkSuccess,
      loading: loading ?? this.loading,
      pageLoading: pageLoading ?? this.pageLoading,
      dataOnly: dataOnly ?? this.dataOnly,
      selectYear: selectYear ?? this.selectYear,
      selectMonth: selectMonth ?? this.selectMonth,
      dataWait: dataWait ?? this.dataWait,
      page: page ?? this.page,
      // dataAll: dataAll ?? this.dataAll,
      selectDate: selectDate ?? this.selectDate,
      sumWages: sumWages ?? this.sumWages,
      checkHr: checkHr ?? this.checkHr,
    );
  }

  @override
  List<Object> get props => [
        focusedDay,
        startTime,
        endTime,
        checkSuccess,
        loading,
        pageLoading,
        dataOnly,
        selectYear,
        selectMonth,
        dataWait,
        page,
        // dataAll,
        selectDate,
        sumWages, checkHr,
      ];
}
