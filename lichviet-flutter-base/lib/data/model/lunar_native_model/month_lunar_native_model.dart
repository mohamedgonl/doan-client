import 'package:lichviet_flutter_base/domain/entities/lunar_native_entity/month_lunar_native_entity.dart';

class MonthLunarNativeModel implements MonthLunarNativeEntity {
  @override
  int? leap;

  @override
  int? month;

  MonthLunarNativeModel({this.month, this.leap});

  MonthLunarNativeModel.fromJson(Map<String, dynamic> json) {
    if (json['month'] is String) {
      month = int.tryParse(json['month']);
    } else {
      month = json['month'];
    }

    leap = json['leap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['month'] = month;
    data['leap'] = leap;
    return data;
  }
}
