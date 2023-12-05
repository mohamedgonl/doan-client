part of 'lunar_calendar_native_cubit.dart';

class LunarCalendarNativeState extends Equatable {
  final LoadingStatus? status;

  final dynamic error;

  final List<MonthLunarNativeModel>? monthDatas;
  final List<DayLunarNativeMode>? dayDatas;
  final int? leapMonth;

  const LunarCalendarNativeState(
      {this.status,
      this.error,
      this.dayDatas,
      this.monthDatas,
      this.leapMonth});

  factory LunarCalendarNativeState.initial() {
    return const LunarCalendarNativeState(
      status: LoadingStatus.initial,
    );
  }

  LunarCalendarNativeState copyWith(
      {LoadingStatus? status,
      dynamic error,
      List<MonthLunarNativeModel>? monthDatas,
      List<DayLunarNativeMode>? dayDatas,
      int? leapMonth}) {
    return LunarCalendarNativeState(
        status: status ?? LoadingStatus.success,
        error: error ?? this.error,
        dayDatas: dayDatas ?? this.dayDatas,
        monthDatas: monthDatas ?? this.monthDatas,
        leapMonth: leapMonth ?? this.leapMonth);
  }

  @override
  List<Object?> get props => [error, status, dayDatas, monthDatas, leapMonth];
}
