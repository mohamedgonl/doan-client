import 'package:lichviet_flutter_base/domain/entities/error_entity.dart';

import '../../data/model/config_model.dart';

abstract class AppRepository {
  Future<List<ErrorEntity>> getErrorList();
  Future<void> setGuideXemNgayTot();
  bool? getGuideXemNgayTot();
  Future<void> setFirstUsingApp();
  bool? getFirstUsingApp();
  Future<void> setShowPopupDetailDay();
  bool? getShowPopupDetailDay();
  Future<void> setShowPopupDayNow();
  bool? getShowPopupDayNow();
  Future<void> setCountSession(int count);
  int? getCountSession();
  Future<void> setFirstTimeUsingApp(int timestamp);
  int? getFirstTimeUsingApp();
  Future<void> setTimeShowAdsmobFull(int timestamp);
  int? getTimeShowAdsmobFull();
  ConfigModel? getConfigLocal();
  Future<void> setConfigLocal(ConfigModel configModel);
  Future<void> setFirstTimeUsingChiTietNgay();
  bool? getFirstTimeUsingChiTietNgay();
  Future<void> setInputBirthdayFlowTimestamp(int? timestamp);
  int? getInputBirthdayFlowTimestamp();
  Future<void> setAnHienDuLieuMauGMNSTimestamp(int? timestamp);
  int? getAnHienDuLieuMauGMNSTimestamp();
  Future<void> setAnHienDuLieuMauGMNS(bool? showDuLieu);
  bool? getAnHienDuLieuMauGMNS();
  Future<void> setAdMaxTimePerSession(int value);
  int getAdMaxTimePerSession();
  Future<void> setUserIdDidShowFlowBirthday(String userId);
  List<String>? getUserIdDidShowFlowBirthday();
  bool? getDidShowNotificationPermission();
  Future<void> setDidShowNotificationPermission();
  bool? getDidShowLocationPermission();
  Future<void> setDidShowLocationPermission();
}
