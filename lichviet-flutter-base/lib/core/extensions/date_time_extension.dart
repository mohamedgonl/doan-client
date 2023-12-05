import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormat({String? format}) {
    final dateFormat = DateFormat(format ?? 'dd/MM/yyyy');
    return dateFormat.format(this);
  }

  int get toTimestamp => millisecondsSinceEpoch;
}
