import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichviet_flutter_base/core/utils/format_datetime.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/day_lunar_native_model.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/month_lunar_native_model.dart';
import 'package:lichviet_flutter_base/domain/usecases/lunar_calendar_native_usecase.dart';

part 'lunar_calendar_native_state.dart';

class LunarCalendarNativeCubit extends Cubit<LunarCalendarNativeState> {
  final LunarCalendarNativeUseCase _lunarCalendarNativeUseCase;

  LunarCalendarNativeCubit(this._lunarCalendarNativeUseCase)
      : super(LunarCalendarNativeState.initial());

  Future<void> getMonthLunarCalendarNative({
    required int year,
  }) async {
    emit(state.copyWith(
      status: LoadingStatus.loading,
    ));
    _lunarCalendarNativeUseCase.getMonthLunarFromNative(year).then((value) {
      int? leapMonth;
      for (var element in value) {
        if (element.leap == 1) {
          leapMonth = element.month!;
        }
      }
      emit(state.copyWith(
          status: LoadingStatus.success,
          monthDatas: value,
          leapMonth: leapMonth ?? -1));
    });
  }

  Future<void> getDayLunarCalendarNative(
      {required int month, required int leap, required int year}) async {
    emit(state.copyWith(
      status: LoadingStatus.loading,
    ));
    _lunarCalendarNativeUseCase
        .getDayLunarFromNative(month, leap, year)
        .then((value) {
      emit(state.copyWith(status: LoadingStatus.success, dayDatas: value));
    });
  }

  Future<List<DayLunarNativeMode>> getDayOfMonthLunarCalendarNative(
      {required int month, required int leap, required int year}) async {
    final result = await _lunarCalendarNativeUseCase.getDayLunarFromNative(
        month, leap, year);
    return result;
  }

  Future<List<int>> getEndLunarOfDate(DateTime datetime) async {
    List<int> lunarDateNow = DateTimeCommon.solarToLunar(
        datetime.year, datetime.month, datetime.day, Timezone.Vietnamese);
    List<DayLunarNativeMode> dayLunarOfMonth =
        await getDayOfMonthLunarCalendarNative(
      month: lunarDateNow[1],
      year: lunarDateNow[2],
      leap: lunarDateNow[3],
    );
    List<int> result = [
      dayLunarOfMonth.last.day!.toInt(), //day
      lunarDateNow[1], //month
      lunarDateNow[2], //year
      lunarDateNow[3] //leap
    ];
    print('getEndLunarOfNextMonth: $result');
    return result;
  }

  Future<List<int>> getEndLunarOfNextMonth(DateTime date) async {
    DateTime dateCurrent = date;
    List<int> lunarDateNow = DateTimeCommon.solarToLunar(dateCurrent.year,
        dateCurrent.month, dateCurrent.day, Timezone.Vietnamese);
    List<int> lunarDateNextMonth = [];
    DateTime converDate = date.add(const Duration(days: 29));
    List<int> lunarDateConver = DateTimeCommon.solarToLunar(
        converDate.year, converDate.month, converDate.day, Timezone.Vietnamese);
    if (lunarDateConver[1] != lunarDateNow[1] ||
        lunarDateConver[3] != lunarDateNow[3]) {
      lunarDateNextMonth = lunarDateConver;
    } else {
      converDate.add(const Duration(days: 31));
      lunarDateConver = DateTimeCommon.solarToLunar(converDate.year,
          converDate.month, converDate.day, Timezone.Vietnamese);
      lunarDateNextMonth = lunarDateConver;
    }
    List<DayLunarNativeMode> dayLunarOfMonth =
        await getDayOfMonthLunarCalendarNative(
      month: lunarDateNextMonth[1],
      year: lunarDateNextMonth[2],
      leap: lunarDateNextMonth[3],
    );
    List<int> result = [
      dayLunarOfMonth.last.day!.toInt(), //day
      lunarDateNextMonth[1], //month
      lunarDateNextMonth[2], //year
      lunarDateNextMonth[3] //leap
    ];
    print('getEndLunarOfNextMonth: $result');
    return result;
  }

  Future<List<int>> getEndLunarOfYear(int year) async {
    List<DayLunarNativeMode> dayLunarOfMonth =
        await getDayOfMonthLunarCalendarNative(
      month: 12,
      year: year,
      leap: 0,
    );

    List<int> result = [
      dayLunarOfMonth.last.day!.toInt(), //day
      12, //month
      year, //year
      0 //leap
    ];
    print('getEndLunarOfNextMonth: $result');
    return result;
  }
}
