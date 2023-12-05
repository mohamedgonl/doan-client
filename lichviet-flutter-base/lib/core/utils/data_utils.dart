import 'package:html/parser.dart';

class DataUtils {
  static bool convertDataBoolean(dynamic value) {
    if (value is String) {
      if (value == '0') {
        return false;
      } else {
        return true;
      }
    }
    if (value is int) {
      if (value == 0) {
        return false;
      } else {
        return true;
      }
    }
    if (value is bool) {
      return value;
    }
    return false;
  }

  static String formatHtmlToText(String text) {
    try {
      return parse(text).documentElement!.text;
    } catch (_e) {
      return text;
    }
  }

  static String converDateToStringVietNam2(DateTime dateTime) {
    String date = '';
    switch (dateTime.weekday) {
      case DateTime.monday:
        date = "T.HAI";
        break;

      case DateTime.tuesday:
        date = "T.BA";
        break;
      case DateTime.wednesday:
        date = "T.TƯ";
        break;
      case DateTime.thursday:
        date = "T.NĂM";
        break;
      case DateTime.friday:
        date = "T.SÁU";
        break;
      case DateTime.saturday:
        date = "T.BẢY";
        break;
      case DateTime.sunday:
        date = "CN";
        break;
    }

    return date;
  }



  static String converDateToStringVietNam3(int wwekDay) {
    String date = '';
    switch (wwekDay) {
      case 1:
        date = "T.HAI";
        break;

      case 2:
        date = "T.BA";
        break;
      case 3:
        date = "T.TƯ";
        break;
      case 4:
        date = "T.NĂM";
        break;
      case 5:
        date = "T.SÁU";
        break;
      case 6:
        date = "T.BẢY";
        break;
      case 7:
        date = "CN";
        break;
    }

    return date;
  }
}
