import 'package:lichviet_flutter_base/core/utils/format_datetime.dart';

class IntConstanst {
  static int timeCache = 768;
  static int maxAge = 365;

  static int monthLunarNow = DateTimeCommon.solarToLunar(DateTime.now().year,
      DateTime.now().month, DateTime.now().day, Timezone.Vietnamese)[1];
}
