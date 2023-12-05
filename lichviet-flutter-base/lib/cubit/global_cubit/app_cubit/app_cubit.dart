import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/cubit/global_cubit/app_cubit/app_state.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/domain/entities/entities.dart';
import 'package:lichviet_flutter_base/domain/usecases/api_config_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/app_usecase.dart';

enum MenuTab { home, event, tuvi, noti, khamPha }

class AppCubit extends Cubit<AppState> {
  final AppUseCase _appUseCase;
  final ApiConfigUsecases _apiConfigUsecases;

  AppCubit(this._appUseCase, this._apiConfigUsecases)
      : super(AppState.initial());

  bool? getGuideXemNgayTot() {
    return _appUseCase.getGuideXemNgayTot();
  }

  Future<void> setGuideXemNgayTot() async {
    _appUseCase.setGuideXemNgayTot();
  }

  Future<void> setFirstUsingApp() {
    return _appUseCase.setFirstUsingApp();
  }

  bool? getFirstUsingApp() {
    return _appUseCase.getFirstUsingApp();
  }

  Future<void> setShowPopupDetailDay() {
    return _appUseCase.setShowPopupDetailDay();
  }

  bool? getShowPopupDetailDay() {
    return _appUseCase.getShowPopupDetailDay();
  }

  Future<void> setShowPopupDayNow() {
    return _appUseCase.setShowPopupDayNow();
  }

  bool? getShowPopupDayNow() {
    return _appUseCase.getShowPopupDayNow();
  }

  void rebuildAppState() {
    emit(state.copyWith(status: LoadingStatus.loading));
    emit(state.copyWith(status: LoadingStatus.success));
  }

  Future<void> setCountSession(int count) async {
    await _appUseCase.setCountSession(count);
  }

  int? getCountSession() {
    return _appUseCase.getCountSession();
  }

  Future<void> setFirstTimeUsingApp(int timestamp) async {
    await _appUseCase.setFirstTimeUsingApp(timestamp);
  }

  int? getFirstTimeUsingApp() {
    return _appUseCase.getFirstTimeUsingApp();
  }

  int? getTimeShowAdsmobFull() {
    return _appUseCase.getTimeShowAdsmobFull();
  }

  Future<void> setTimeShowAdsmobFull(int timestamp) {
    return _appUseCase.setTimeShowAdsmobFull(timestamp);
  }

  Future<void> getConfigListRemote() async {
    try {
      final config = await _apiConfigUsecases.getConfigList();
      _appUseCase.setConfigLocal(config);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<ConfigEntity?> getConfigListLocal() async {
    emit(state.copyWith(status: LoadingStatus.loading));
    final configList = _appUseCase.getConfigLocal();
    if (configList == null) {
      final config = await _apiConfigUsecases.getConfigList();
      _appUseCase.setConfigLocal(config);
      emit(state.copyWith(status: LoadingStatus.success, config: config));
    } else {
      emit(state.copyWith(status: LoadingStatus.success, config: configList));
    }
  }

  Future<void> changeTabMainScreen(MenuTab index) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(status: LoadingStatus.success, index: index));
  }

  Future<void> setFirstTimeUsingChiTietNgay() {
    return _appUseCase.setFirstTimeUsingChiTietNgay();
  }

  bool? getFirstTimeUsingChiTietNgay() {
    return _appUseCase.getFirstTimeUsingChiTietNgay();
  }

  Future<void> setInputBirthdayFlowTimestamp(int? timestamp) {
    return _appUseCase.setInputBirthdayFlowTimestamp(timestamp);
  }

  int? getInputBirthdayFlowTimestamp() {
    return _appUseCase.getInputBirthdayFlowTimestamp();
  }

  Future<void> setAnHienDuLieuMauGMNSTimestamp(int? timestamp) {
    return _appUseCase.setAnHienDuLieuMauGMNSTimestamp(timestamp);
  }

  int? getAnHienDuLieuMauGMNSTimestamp() {
    return _appUseCase.getAnHienDuLieuMauGMNSTimestamp();
  }

  Future<void> setAnHienDuLieuMauGMNS(bool? showDuLieu) {
    return _appUseCase.setAnHienDuLieuMauGMNS(showDuLieu);
  }

  bool? getAnHienDuLieuMauGMNS() {
    return _appUseCase.getAnHienDuLieuMauGMNS();
  }

  Future<void> setAdMaxTimePerSession(int value) {
    return _appUseCase.setAdMaxTimePerSession(value);
  }

  int getAdMaxTimePerSession() {
    return _appUseCase.getAdMaxTimePerSession();
  }

  Future<void> setUserIdDidShowFlowBirthday(String userId) {
    return _appUseCase.setUserIdDidShowFlowBirthday(userId);
  }

  List<String>? getUserIdDidShowFlowBirthday() {
    return _appUseCase.getUserIdDidShowFlowBirthday();
  }

  bool? getDidShowNotificationPermission() {
    return _appUseCase.getDidShowNotificationPermission();
  }

  Future<void> setDidShowNotificationPermission() async {
    return _appUseCase.setDidShowNotificationPermission();
  }

  bool? getDidShowLocationPermission() {
    return _appUseCase.getDidShowLocationPermission();
  }

  Future<void> setDidShowLocationPermission() async {
    return _appUseCase.setDidShowLocationPermission();
  }
}
