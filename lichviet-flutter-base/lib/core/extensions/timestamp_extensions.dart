extension TimestampExtension on int {
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this);
}
