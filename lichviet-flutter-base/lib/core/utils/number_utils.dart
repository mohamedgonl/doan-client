import 'package:intl/intl.dart';

enum TypeDataConver {
  int,
  double,
  bool,
  string,
}

class NumberUtils {
  static String formatDecimal(int? count) {
    if (count == null) return "";
    final formatter = NumberFormat("#,###", "en_US");
    return formatter.format(count);
  }

  static dynamic dynamicConverData({
    required TypeDataConver typeDataConver,
    required dynamic data,
  }) {
    try {
      dynamic dataConver = 0;
      if (data is int) {
        if (typeDataConver == TypeDataConver.int) {
          dataConver = data;
        } else if (typeDataConver == TypeDataConver.string) {
          dataConver = data.toString();
        } else if (typeDataConver == TypeDataConver.bool) {
          dataConver = null;
        } else if (typeDataConver == TypeDataConver.double) {
          dataConver = data + 0.0;
        }
      } else if (data is int) {
        if (typeDataConver == TypeDataConver.int) {
          dataConver = data;
        } else if (typeDataConver == TypeDataConver.string) {
          dataConver = data.toString();
        } else if (typeDataConver == TypeDataConver.bool) {
          dataConver = null;
        } else if (typeDataConver == TypeDataConver.double) {
          dataConver = data + 0.0;
        }
      }
      return dataConver;
    } catch (_e) {
      return null;
    }
  }
}
