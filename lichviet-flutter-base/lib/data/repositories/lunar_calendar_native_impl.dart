

import 'package:lichviet_flutter_base/data/datasource/native/lunar_calendar_data_source.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/day_lunar_native_model.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/month_lunar_native_model.dart';
import 'package:lichviet_flutter_base/domain/repositories/lunar_calendar_native_repository.dart';

class LunarCalendarFromNativeImpl implements LunarCalendarNativeRepository {
  final LunarCalendarDatasource _lunarCalendarDatasource;
  LunarCalendarFromNativeImpl(this._lunarCalendarDatasource);
  @override
  Future<List<DayLunarNativeMode>> getDayLunarFromNative(
      int month, int leap, int year) {
    return _lunarCalendarDatasource.getDayLunarNative(month, leap, year);
  }

  @override
  Future<List<MonthLunarNativeModel>> getMonthLunarFromNative(int year) {
    return _lunarCalendarDatasource.getMonthLunarNative(year);
  }
}
