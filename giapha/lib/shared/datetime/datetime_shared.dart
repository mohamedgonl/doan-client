import 'package:intl/intl.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class DateTimeShared {
  static DateTime formatStringToDate5(String dateString) {
    return DateFormat('d-M-yyyy').parse(dateString);
  }

  static DateTime formatStringToDate8(String dateString) {
    return DateFormat('dd/MM/yyyy').parse(dateString);
  }

  static DateTime formatStringReverseToDate8(String dateString) {
    return DateFormat('yyyy-MM-dd').parse(dateString);
  }

  static String dateTimeToStringDefault1(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String dateTimeToStringDefault2(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime.toLocal());
  }

  static String dateTimeToStringReverse(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
  }

  static String formatDateNoContext(DateTime dateTime) {
    try {
      const datePattern = "d-M-yyyy";
      final dateFormat = DateFormat(datePattern);
      String day = dateFormat.format(dateTime.toLocal());

      return day;
    } catch (error) {
      // Logger.e("Error with date format: $error", e: error, s: StackTrace.current);
      return "";
    }
  }

  static String convertSolarToLunar(DateTime dateBirthDay) {
    final List<int> listLunar = DateTimeCommon.solarToLunar(dateBirthDay.year,
        dateBirthDay.month, dateBirthDay.day, Timezone.Vietnamese);
    final String lunarString =
        '${listLunar[0] < 10 ? "0${listLunar[0]}" : listLunar[0]}/${listLunar[1] < 10 ? "0${listLunar[1]}" : listLunar[1]}/${listLunar[2]}';
    return lunarString;
  }
}
