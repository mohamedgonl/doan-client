import 'dart:collection';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/api/api_config.dart';
import 'package:lichviet_flutter_base/core/api/api_handler.dart';
import 'package:lichviet_flutter_base/core/constants/int_constants.dart';
import 'package:lichviet_flutter_base/core/utils/alice/alice.dart';
import 'package:lichviet_flutter_base/cubit/cache_version_cubit/cache_version_cubit.dart';
import 'package:lichviet_flutter_base/cubit/init_cubit/init_cubit.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/di/di.dart';
import 'package:lichviet_flutter_base/theme/theme_color.dart';
import 'package:lichviet_flutter_base/theme/theme_layouts.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';

import 'core/utils/dio_cache_manager/dio_http_cache.dart';

/// A Calculator.
class LichVietFlutterBase {
  LichVietFlutterBase();

  static LichVietFlutterBase? _instance;

  static var configDev =
      ApiConfig(env: 'test', baseUrl: 'https://192.168.1.50:8000');
  static var configProduct =
      ApiConfig(env: 'env', baseUrl: 'https://api.lichviet.org');
  static const configV2 = '/api/app/config-v2';
  static const channelNative = 'com.somestudio.lichvietnam/dataNative';
  static DioCacheManager manager = DioCacheManager(
    CacheConfig(baseUrl: configProduct.baseUrl, maxMemoryCacheCount: 9999),
  );
  static LichVietFlutterBase getInstance() {
    if (_instance == null) {
      manager = DioCacheManager(CacheConfig(baseUrl: configProduct.baseUrl));
      _instance = LichVietFlutterBase();
    }
    return _instance!;
  }

  static void setInstance(LichVietFlutterBase instance) {
    if (_instance == null) {
      _instance = instance;
    }
  }

  Future<void> setUpBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    await setupDi(configProduct);
    GetIt.I<CacheVersionCubit>().getVersionApi();
    GetIt.I<InitCubit>().getPublicKey();
  }

  void checkInitLoadData(Function onload) async {
    InitCubit initCubit = GetIt.I<InitCubit>();

    CacheVersionCubit cacheVersionCubit = GetIt.I<CacheVersionCubit>();
    if (cacheVersionCubit.state.status != LoadingStatus.success &&
        cacheVersionCubit.state.versionData == null &&
        cacheVersionCubit.state.status != LoadingStatus.failure) {
      cacheVersionCubit.stream.listen((event) {
        if (event.status == LoadingStatus.success) {
          onload();
        }
      });
    }
    final checkConnection = await Connectivity().checkConnectivity();
    if (checkConnection == ConnectivityResult.none) {
      Connectivity().onConnectivityChanged.listen((event) async {
        if (event != ConnectivityResult.none) {
          if (initCubit.state.status == LoadingStatus.success) {
            onload();
          } else if (initCubit.state.status != LoadingStatus.loading) {
            initCubit.getPublicKey();
          }
        }
      });
    }

    if (initCubit.state.status != LoadingStatus.success) {
      onload();
      initCubit.stream.listen((event) {
        if (event.status == LoadingStatus.success) {
          onload();
        }
      });
    } else if (initCubit.state.status == LoadingStatus.success) {
      onload();
    }
  }

  // ApiHandler _apiHandel;

  // ApiHandler get apiHandel => _apiHandel;

  DioCacheManager? get managerCache => manager;

  Alice? _alice;
  void setUpAlice(GlobalKey<NavigatorState> natigatorKey) {
    if (LichVietFlutterBase.configProduct.baseUrl.contains('test.api')) {
      _alice = Alice(
          showNotification: true,
          showInspectorOnShake: true,
          darkTheme: false,
          maxCallsCount: 1000,
          showShareButton: false);
      _alice!.setNavigatorKey(natigatorKey);
      GetIt.I<Dio>().interceptors.add(_alice!.getDioInterceptor());
    }
  }

  String? _appInfo;
  String? get appInfo => _appInfo;
  String? _apnsToken;

  set setAppInfo(String appInfo) {
    _appInfo = appInfo;
  }

  String? get apnsToken => _apnsToken;

  set setApnsToken(String apnsToken) {
    _apnsToken = apnsToken;
  }

  String? _deviceId;

  String? get deviceId => _deviceId;

  set setDeviceId(String deviceId) {
    _deviceId = deviceId;
  }

  String? _deviceInfo;

  String? get deviceInfo => _deviceInfo;

  set setDeviceInfo(String deviceInfo) {
    _deviceInfo = deviceInfo;
  }

  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  set setFcmToken(String fcmToken) {
    _fcmToken = fcmToken;
  }

  String? _osInfo;

  String? get osInfo => _osInfo;
  set seOsInfo(String osInfo) {
    _osInfo = osInfo;
  }

  ApiHandler get apiHandle => GetIt.I<ApiHandler>();

  ThemeColor get themeColor => ThemeColor();

  ThemeStyles get themeStyle => ThemeStyles();

  ThemeLayouts get themeLayOuts => ThemeLayouts();
}
