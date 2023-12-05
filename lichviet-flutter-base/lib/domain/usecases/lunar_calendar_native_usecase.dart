import 'package:lichviet_flutter_base/data/model/lunar_native_model/day_lunar_native_model.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/month_lunar_native_model.dart';
import 'package:lichviet_flutter_base/domain/repositories/lunar_calendar_native_repository.dart';

class LunarCalendarNativeUseCase {
  final LunarCalendarNativeRepository _lunarCalendarNativeRepository;

  LunarCalendarNativeUseCase(this._lunarCalendarNativeRepository);

  Future<List<MonthLunarNativeModel>> getMonthLunarFromNative(int year) {
    return _lunarCalendarNativeRepository.getMonthLunarFromNative(year);
  }

  Future<List<DayLunarNativeMode>> getDayLunarFromNative(
      int month, int leap, int year) {
    return _lunarCalendarNativeRepository.getDayLunarFromNative(
        month, leap, year);
  }
}
