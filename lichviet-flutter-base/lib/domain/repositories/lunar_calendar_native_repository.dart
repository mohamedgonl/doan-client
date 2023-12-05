import 'package:lichviet_flutter_base/data/model/lunar_native_model/day_lunar_native_model.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/month_lunar_native_model.dart';

abstract class LunarCalendarNativeRepository {
  Future<List<MonthLunarNativeModel>> getMonthLunarFromNative(int year);
  Future<List<DayLunarNativeMode>> getDayLunarFromNative(
      int month, int leap, int year);
}
