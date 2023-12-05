import 'package:lichviet_flutter_base/data/model/config_model.dart';
import 'package:lichviet_flutter_base/domain/entities/config_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/error_entity.dart';
import 'package:lichviet_flutter_base/domain/repositories/app_repository.dart';

class AppUseCase {
  final AppRepository _appRepository;

  AppUseCase(this._appRepository);

  Future<List<ErrorEntity>> getErrorList() {
    return _appRepository.getErrorList();
  }

  Future<void> setGuideXemNgayTot() {
    return _appRepository.setGuideXemNgayTot();
  }

  bool? getGuideXemNgayTot() {
    return _appRepository.getGuideXemNgayTot();
  }

  Future<void> setFirstUsingApp() {
    return _appRepository.setFirstUsingApp();
  }

  bool? getFirstUsingApp() {
    return _appRepository.getFirstUsingApp();
  }

  Future<void> setShowPopupDetailDay() {
    return _appRepository.setShowPopupDetailDay();
  }

  bool? getShowPopupDetailDay() {
    return _appRepository.getShowPopupDetailDay();
  }

  Future<void> setShowPopupDayNow() {
    return _appRepository.setShowPopupDayNow();
  }

  bool? getShowPopupDayNow() {
    return _appRepository.getShowPopupDayNow();
  }

  Future<void> setCountSession(int count) async {
    await _appRepository.setCountSession(count);
  }

  int? getCountSession() {
    return _appRepository.getCountSession();
  }

  Future<void> setFirstTimeUsingApp(int timestamp) async {
    await _appRepository.setFirstTimeUsingApp(timestamp);
  }

  int? getFirstTimeUsingApp() {
    return _appRepository.getFirstTimeUsingApp();
  }

  int? getTimeShowAdsmobFull() {
    return _appRepository.getTimeShowAdsmobFull();
  }

  Future<void> setTimeShowAdsmobFull(int timestamp) {
    return _appRepository.setTimeShowAdsmobFull(timestamp);
  }

  ConfigEntity? getConfigLocal() {
    return _appRepository.getConfigLocal();
  }

  Future<void> setConfigLocal(ConfigModel configModel) {
    return _appRepository.setConfigLocal(configModel);
  }

  Future<void> setFirstTimeUsingChiTietNgay() {
    return _appRepository.setFirstTimeUsingChiTietNgay();
  }

  bool? getFirstTimeUsingChiTietNgay() {
    return _appRepository.getFirstTimeUsingChiTietNgay();
  }

  Future<void> setInputBirthdayFlowTimestamp(int? timestamp) {
    return _appRepository.setInputBirthdayFlowTimestamp(timestamp);
  }

  int? getInputBirthdayFlowTimestamp() {
    return _appRepository.getInputBirthdayFlowTimestamp();
  }

  Future<void> setAnHienDuLieuMauGMNSTimestamp(int? timestamp) {
    return _appRepository.setAnHienDuLieuMauGMNSTimestamp(timestamp);
  }

  int? getAnHienDuLieuMauGMNSTimestamp() {
    return _appRepository.getAnHienDuLieuMauGMNSTimestamp();
  }

  Future<void> setAnHienDuLieuMauGMNS(bool? showDuLieu) {
    return _appRepository.setAnHienDuLieuMauGMNS(showDuLieu);
  }

  bool? getAnHienDuLieuMauGMNS() {
    return _appRepository.getAnHienDuLieuMauGMNS();
  }

  Future<void> setAdMaxTimePerSession(int value) {
    return _appRepository.setAdMaxTimePerSession(value);
  }

  int getAdMaxTimePerSession() {
    return _appRepository.getAdMaxTimePerSession();
  }

  Future<void> setUserIdDidShowFlowBirthday(String userId) {
    return _appRepository.setUserIdDidShowFlowBirthday(userId);
  }

  List<String>? getUserIdDidShowFlowBirthday() {
    return _appRepository.getUserIdDidShowFlowBirthday();
  }

  bool? getDidShowNotificationPermission() {
    return _appRepository.getDidShowNotificationPermission();
  }

  Future<void> setDidShowNotificationPermission() async {
    return _appRepository.setDidShowNotificationPermission();
  }

  bool? getDidShowLocationPermission() {
    return _appRepository.getDidShowLocationPermission();
  }

  Future<void> setDidShowLocationPermission() async {
    return _appRepository.setDidShowLocationPermission();
  }
}
