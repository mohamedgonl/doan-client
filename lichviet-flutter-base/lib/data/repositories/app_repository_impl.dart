import 'package:lichviet_flutter_base/data/datasource/local/app_local_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/local/config_local_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/app_remote_datasouce.dart';
import 'package:lichviet_flutter_base/data/model/config_model.dart';
import 'package:lichviet_flutter_base/data/model/error_model.dart';
import 'package:lichviet_flutter_base/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource _appRemoteDataSource;
  final AppLocalDatasource _appLocalDatasource;
  final ConfigLocalDatasource _configLocalDatasource;

  AppRepositoryImpl(
    this._appRemoteDataSource,
    this._appLocalDatasource,
    this._configLocalDatasource,
  );
  @override
  Future<List<ErrorModel>> getErrorList() {
    return _appRemoteDataSource.getErrorList();
  }

  @override
  bool? getGuideXemNgayTot() {
    return _appLocalDatasource.getGuideXemNgayTot;
  }

  @override
  Future<void> setGuideXemNgayTot() {
    return _appLocalDatasource.setGuideXemNgayTot();
  }

  @override
  bool? getFirstUsingApp() {
    return _appLocalDatasource.firstUsingApp;
  }

  @override
  Future<void> setFirstUsingApp() {
    return _appLocalDatasource.setFirstUsingApp();
  }

  @override
  bool? getShowPopupDayNow() {
    return _appLocalDatasource.showPopupDayNow;
  }

  @override
  bool? getShowPopupDetailDay() {
    return _appLocalDatasource.showPopupDetailDay;
  }

  @override
  Future<void> setShowPopupDayNow() {
    return _appLocalDatasource.setShowPopupDayNow();
  }

  @override
  Future<void> setShowPopupDetailDay() {
    return _appLocalDatasource.setShowPopupDetailDay();
  }

  @override
  int? getCountSession() {
    return _appLocalDatasource.getCountSession();
  }

  @override
  int? getFirstTimeUsingApp() {
    return _appLocalDatasource.getFirstTimeUsingApp();
  }

  @override
  Future<void> setCountSession(int count) {
    return _appLocalDatasource.setCountSession(count);
  }

  @override
  Future<void> setFirstTimeUsingApp(int timestamp) {
    return _appLocalDatasource.setFirstTimeUsingApp(timestamp);
  }

  @override
  int? getTimeShowAdsmobFull() {
    return _appLocalDatasource.getTimeShowAdsmobFull();
  }

  @override
  Future<void> setTimeShowAdsmobFull(int timestamp) {
    return _appLocalDatasource.setTimeShowAdsmobFull(timestamp);
  }

  @override
  ConfigModel? getConfigLocal() {
    return _configLocalDatasource.getConfigLocal;
  }

  @override
  Future<void> setConfigLocal(ConfigModel configModel) {
    return _configLocalDatasource.setConfigLocal(configModel);
  }

  @override
  Future<void> setFirstTimeUsingChiTietNgay() {
    return _appLocalDatasource.setFirstTimeUsingChiTietNgay();
  }

  @override
  bool? getFirstTimeUsingChiTietNgay() {
    return _appLocalDatasource.getFirstTimeUsingChiTietNgay();
  }

  @override
  int? getInputBirthdayFlowTimestamp() {
    return _appLocalDatasource.getInputBirthdayFlowTimestamp();
  }

  @override
  Future<void> setInputBirthdayFlowTimestamp(int? timestamp) {
    return _appLocalDatasource.setInputBirthdayFlowTimestamp(timestamp);
  }

  @override
  int? getAnHienDuLieuMauGMNSTimestamp() {
    return _appLocalDatasource.getAnHienDuLieuMauGMNSTimestamp();
  }

  @override
  Future<void> setAnHienDuLieuMauGMNSTimestamp(int? timestamp) {
    return _appLocalDatasource.setAnHienDuLieuMauGMNSTimestamp(timestamp);
  }

  @override
  bool? getAnHienDuLieuMauGMNS() {
    return _appLocalDatasource.getAnHienDuLieuMauGMNS();
  }

  @override
  Future<void> setAnHienDuLieuMauGMNS(bool? showDuLieu) {
    return _appLocalDatasource.setAnHienDuLieuMauGMNS(showDuLieu);
  }

  @override
  int getAdMaxTimePerSession() {
    return _appLocalDatasource.getAdMaxTimePerSession();
  }

  @override
  Future<void> setAdMaxTimePerSession(int value) {
    return _appLocalDatasource.setAdMaxTimePerSession(value);
  }

  @override
  List<String>? getUserIdDidShowFlowBirthday() {
    return _appLocalDatasource.getUserIdDidShowFlowBirthday();
  }

  @override
  Future<void> setUserIdDidShowFlowBirthday(String userId) {
    return _appLocalDatasource.setUserIdDidShowFlowBirthday(userId);
  }

  @override
  bool? getDidShowLocationPermission() {
    return _appLocalDatasource.getDidShowLocationPermission;
  }

  @override
  bool? getDidShowNotificationPermission() {
    return _appLocalDatasource.getDidShowNotificationPermission;
  }

  @override
  Future<void> setDidShowLocationPermission() {
    return _appLocalDatasource.setDidShowLocationPermission();
  }

  @override
  Future<void> setDidShowNotificationPermission() {
    return _appLocalDatasource.setDidShowNotificationPermission();
  }
}
