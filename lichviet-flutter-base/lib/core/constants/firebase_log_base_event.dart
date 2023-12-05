import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:lichviet_flutter_base/core/constants/event_log_base_constants.dart';
class FireBaseLogBaseEvent {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // cập nhật thông tin cá nhân
  void birthDayChange() {
    analytics.logEvent(
        name: '${EventLogBaseConstants.lvName}_update_user_info',
        parameters: {'${EventLogBaseConstants.lvName}_info_field': 'NgaySinh'});
  }

  void birthTimeChange() {
    analytics.logEvent(
        name: '${EventLogBaseConstants.lvName}_update_user_info',
        parameters: {'${EventLogBaseConstants.lvName}_info_field': 'GioSinh'});
  }
}
