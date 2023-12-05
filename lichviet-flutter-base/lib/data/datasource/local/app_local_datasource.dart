import 'package:lichviet_flutter_base/data/datasource/local/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalDatasource {
  AppLocalDatasource(this._preferences);

  final SharedPreferences _preferences;

  bool? get getGuideXemNgayTot {
    final data = _preferences.getBool(guideXemNgayTot);
    return data;
  }

  Future<void> setGuideXemNgayTot() async {
    await _preferences.setBool(guideXemNgayTot, true);
  }

  int get getSdkVersion {
    return _preferences.getInt('sdkVersion') ?? 0;
  }

  Future<void> setSdkVersion(int sdkVersion) async {
    await _preferences.setInt('sdkVersion', sdkVersion);
  }

  bool? get firstUsingApp {
    final data = _preferences.getBool(firstUsingAppKey);
    return data;
  }

  Future<void> setFirstUsingApp() async {
    await _preferences.setBool(firstUsingAppKey, false);
  }

  bool? get showPopupDetailDay {
    final data = _preferences.getBool(showPopupDetailDayKey);
    return data;
  }

  Future<void> setShowPopupDetailDay() async {
    await _preferences.setBool(showPopupDetailDayKey, false);
  }

  bool? get showPopupDayNow {
    final data = _preferences.getBool(showPopupDayNowKey);
    return data;
  }

  Future<void> setShowPopupDayNow() async {
    await _preferences.setBool(showPopupDayNowKey, false);
  }

  Future<void> setCountSession(int count) async {
    await _preferences.setInt(countSession, count);
  }

  int? getCountSession() {
    return _preferences.getInt(countSession);
  }

  Future<void> setFirstTimeUsingApp(int timestamp) async {
    await _preferences.setInt(firstTimeUsingApp, timestamp);
  }

  int? getFirstTimeUsingApp() {
    return _preferences.getInt(firstTimeUsingApp);
  }

  Future<void> setTimeShowAdsmobFull(int timestamp) {
    return _preferences.setInt(timeShowAdsmobFull, timestamp);
  }

  int? getTimeShowAdsmobFull() {
    return _preferences.getInt(timeShowAdsmobFull);
  }

  Future<void> setFirstTimeUsingChiTietNgay() {
    return _preferences.setBool(firstTimeUsingChiTietNgay, true);
  }

  bool? getFirstTimeUsingChiTietNgay() {
    return _preferences.getBool(firstTimeUsingChiTietNgay);
  }

  Future<void> setInputBirthdayFlowTimestamp(int? timestamp) {
    if (timestamp == null) {
      return _preferences.remove(inputBirthdayFlowTimestamp);
    }
    return _preferences.setInt(inputBirthdayFlowTimestamp, timestamp);
  }

  int? getInputBirthdayFlowTimestamp() {
    return _preferences.getInt(inputBirthdayFlowTimestamp);
  }

  Future<void> setAnHienDuLieuMauGMNSTimestamp(int? timestamp) {
    if (timestamp == null) {
      return _preferences.remove(keyTimeAnHienDuLieuMau);
    }
    return _preferences.setInt(keyTimeAnHienDuLieuMau, timestamp);
  }

  int? getAnHienDuLieuMauGMNSTimestamp() {
    return _preferences.getInt(keyTimeAnHienDuLieuMau);
  }

  Future<void> setAnHienDuLieuMauGMNS(bool? showDuLieu) {
    if (showDuLieu == null) {
      return _preferences.remove(keyTimeAnHienGMNS);
    }
    return _preferences.setBool(keyTimeAnHienGMNS, showDuLieu);
  }

  bool? getAnHienDuLieuMauGMNS() {
    return _preferences.getBool(keyTimeAnHienGMNS);
  }

  Future<void> setAdMaxTimePerSession(int value) {
    return _preferences.setInt(adMaxTimePerSession, value);
  }

  int getAdMaxTimePerSession() {
    return _preferences.getInt(adMaxTimePerSession) ?? 0;
  }

  Future<void> setUserIdDidShowFlowBirthday(String userId) {
    final list = _preferences.getStringList(userIdDidShowFlowBirthday) ?? [];
    if (!list.any((element) => element == userId)) {
      list.add(userId);
    }
    return _preferences.setStringList(userIdDidShowFlowBirthday, list);
    ;
  }

  List<String>? getUserIdDidShowFlowBirthday() {
    return _preferences.getStringList(userIdDidShowFlowBirthday);
  }

  bool? get getDidShowNotificationPermission {
    final data = _preferences.getBool(didShowNotificationPermission);
    return data;
  }

  Future<void> setDidShowNotificationPermission() async {
    await _preferences.setBool(didShowNotificationPermission, true);
  }

  bool? get getDidShowLocationPermission {
    final data = _preferences.getBool(didShowLocationPermission);
    return data;
  }

  Future<void> setDidShowLocationPermission() async {
    await _preferences.setBool(didShowLocationPermission, true);
  }
}
