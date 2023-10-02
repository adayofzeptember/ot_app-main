part of 'leaves_bloc.dart';

// ignore: must_be_immutable
class LeavesState extends Equatable {
  LeavesState({
    required this.selectYear,
    required this.selectMonth,
    required this.checkSuccess,
    required this.loading,
    required this.rangeSelectionMode,
    required this.dataOnly,
    required this.page,
    required this.pageLoading,
    // required this.dataAll,
    required this.showImage,
    // required this.dataWait,
    required this.selectDate,
    required this.leaveSummary,
  });
  LeaveSummaryModel leaveSummary;
  String selectDate;

  int selectYear, selectMonth, page;
  bool checkSuccess, loading, pageLoading;
  RangeSelectionMode rangeSelectionMode;
  List dataOnly;
  //List dataWait, dataAll;
  List showImage;

  LeavesState copyWith({
    String? selectDate,
    String? leaveMode,
    String? leaveType,
    int? selectYear,
    int? selectMonth,
    bool? checkSuccess,
    bool? loading,
    bool? pageLoading,
    int? page,
    List? dataOnly,
    // List? dataAll,
    // List? dataWait,
    RangeSelectionMode? rangeSelectionMode,
    List? showImage,
    LeaveSummaryModel? leaveSummary,
  }) {
    return LeavesState(
      selectDate: selectDate ?? this.selectDate,
      selectYear: selectYear ?? this.selectYear,
      selectMonth: selectMonth ?? this.selectMonth,
      checkSuccess: checkSuccess ?? this.checkSuccess,
      loading: loading ?? this.loading,
      rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
      dataOnly: dataOnly ?? this.dataOnly,
      page: page ?? this.page,
      pageLoading: pageLoading ?? this.pageLoading,
      // dataAll: dataAll ?? this.dataAll,
      showImage: showImage ?? this.showImage,
      // dataWait: dataWait ?? this.dataWait,
      leaveSummary: leaveSummary ?? this.leaveSummary,
    );
  }

  @override
  List<Object> get props => [
        selectDate,

        checkSuccess,
        loading,
        rangeSelectionMode,
        selectYear,
        selectMonth,
        dataOnly,
        pageLoading,
        page,
        // dataAll,
        showImage,
        // dataWait,
        leaveSummary,
      ];
}
