import 'package:lichviet_flutter_base/domain/entities/lunar_native_entity/day_lunar_native_entity.dart';

class DayLunarNativeMode implements DayLunarNativeEntity {
  @override
  int? day;

  @override
  int? dayOfWeek;

  DayLunarNativeMode({this.day, this.dayOfWeek});

  DayLunarNativeMode.fromJson(Map<String, dynamic> json) {
    if (json['day'] is String) {
      day = int.tryParse(json['day']);
    } else {
      day = json['day'];
    }
    if (json['dayOfWeek'] is String) {
      dayOfWeek = int.tryParse(json['dayOfWeek']);
    } else {
      dayOfWeek = json['dayOfWeek'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['day'] = day;
    data['dayOfWeek'] = dayOfWeek;
    return data;
  }
}
