import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';

/// An interceptor to show logs in debug console.
/// It should be enabled in debug mode only

final logInterceptor = LogInterceptor(
  request: AppDebugConfigKey.logResponseApi,
  requestBody: AppDebugConfigKey.logResponseApi,
  responseBody: AppDebugConfigKey.logResponseApi,
  responseHeader: AppDebugConfigKey.logResponseApi,
  requestHeader: AppDebugConfigKey.logResponseApi,
);
