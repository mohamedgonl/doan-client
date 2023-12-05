import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';
import 'package:lichviet_flutter_base/lichviet_flutter_base.dart';

import '../core/core.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' as IO;

Future<Dio> _buildDio(
    ApiConfig config,
    EventBusHandler sessionEvent,
    KeyRsaTripletProvider keyRsaTripletProvider,
    MethodChannel platform,
    Lock lock) async {
  // final PEM = await rootBundle.loadString('assets/lichviet.pem');
  final _dio = Dio()
    ..options.baseUrl = config.baseUrl
    ..options.contentType = "application/x-www-form-urlencoded; charset=utf-8"
    ..options.receiveDataWhenStatusError
    ..options.followRedirects = false;
  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (IO.HttpClient client) {
    // if (LichVietFlutterBase.configProduct.baseUrl ==
    //     'https://api.lichviet.org') {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     if (cert.pem == PEM) {
    //       // Verify the certificate
    //       return true;
    //     }
    //     return false;
    //   };
    // }

    return client;
  };

  // Add interceptors

  _dio.interceptors.addAll([
    logInterceptor,
    AuthInterceptor(keyRsaTripletProvider, platform),

    // LogInterceptor(responseBody: true),
    // NetworkLoggerInterceptor(),
    LichVietFlutterBase.getInstance().managerCache!.interceptor,
    SessionInterceptor(
      baseUrl: config.baseUrl,
      keyRsaTripletProvider: keyRsaTripletProvider,
      lock: lock,
      onLockRequests: () {
        _dio
          ..lock()
          ..interceptors.requestLock.lock()
          ..interceptors.errorLock.lock();
      },
      onUnlockRequests: () {
        _dio
          ..unlock()
          ..interceptors.responseLock.unlock()
          ..interceptors.errorLock.unlock();
      },
      onSessionExpired: () {
        sessionEvent.fire(sessionExpiredEvent);
      },
    ),
  ]);
  return _dio;
}

Future<void> apisModule(GetIt getIt, ApiConfig config) async {
  getIt.registerLazySingleton<EventBusHandler>(() => EventBusHandler());
  getIt.registerLazySingleton<Lock>(() => Lock());
  Dio dio = await _buildDio(
    config,
    getIt(),
    getIt(),
    getIt(),
    getIt(),
  );
  getIt
    ..registerLazySingleton<Dio>(
      () => dio,
    )
    ..registerLazySingleton<ApiHandler>(() => ApiHandlerImpl(
          getIt(),
        ));
}
