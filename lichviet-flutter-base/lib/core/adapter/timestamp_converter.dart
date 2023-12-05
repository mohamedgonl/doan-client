import 'package:json_annotation/json_annotation.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class TimestampJsonConvert implements JsonConverter<DateTime, int> {
  const TimestampJsonConvert();

  @override
  DateTime fromJson(int json) {
    return json.toDateTime;
  }

  @override
  int toJson(DateTime object) {
    return object.toTimestamp;
  }
}
