import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import 'package:encrypt/encrypt.dart' as encry;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/cubit/user_cubit/user_cubit.dart';
import 'package:mz_rsa_plugin/mz_rsa_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

typedef ApiResponseToModelParser<T> = T Function(Map<String, dynamic> json);

abstract class ApiHandler {
  factory ApiHandler(Dio dio) => ApiHandlerImpl(
        dio,
      );

  // parser JSON data {} => Object
  Future<T> post<T>(String path,
      {required ApiResponseToModelParser<T> parser,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options,
      bool? showToastNotConnect});

  // parser JSON data {} => Object
  Future<T> get<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  // parser JSON data [] => List Object
  Future<List<T>> getList<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  // parser JSON data {} => Object
  Future<T> put<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  // parser JSON data {} => Object
  Future<T> delete<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}

class ApiHandlerImpl implements ApiHandler {
  ApiHandlerImpl(
    this._dio,
  );

  final Dio _dio;

  @override
  Future<T> post<T>(String path,
      {required ApiResponseToModelParser<T> parser,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options,
      bool? showToastNotConnect}) {
    body ??= {};
    body.putIfAbsent('appKey', () => 'Ydfa76f765SA46HAA56sHFDMF8K4S5IK');

    // if (GetIt.I<UserCubit>().state.userInfo?.id != null) {
    body.putIfAbsent('secretKey', () => "JWnhpAbxHj5zWHVsHDlQ");
    // }

    return _remapError(() async {
      late HttpMetric metric;
      if (!AppDebugConfigKey.logResponseApi) {
        metric = FirebasePerformance.instance.newHttpMetric(
            path.startsWith('http') ? path : (_dio.options.baseUrl + path),
            HttpMethod.Post);
        await metric.start();
      }
      dio.Response response;
      try {
        response = await _dio.post(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        if (!AppDebugConfigKey.logResponseApi) {
          metric.responseContentType = response.headers.value('content-type');
          metric.httpResponseCode = response.statusCode;
        }
      } finally {
        if (!AppDebugConfigKey.logResponseApi) {
          await metric.stop();
        }
      }
      if (response.data['data'] != null) {
        if (response.headers.value(DIO_CACHE_HEADER_KEY_DATA_SOURCE) == null) {
          LogEventAndScreen.share.logEvent(
            name: 'lv9_api_call',
            parameters: {'lv9_api_path': path, 'lv9_api_result': '1'},
          );
        }

        if (response.data['encrypt'] == 1) {
          try {
            String keyAes = await MzRsaPlugin.decryptStringByPublicKey(
                response.data['key'],
                GetIt.I<KeyRsaTripletProvider>().publicKey!);
            Map<String, dynamic> mapData = {
              'keyAes': keyAes,
              'data': response.data['data'],
            };
            var result = await computeIsolate(mapData);

            response.data['data'] = jsonDecode(result['data']);
            if (AppDebugConfigKey.logResponseApi) {
              debugPrint(result.toString());
            }
          } catch (e) {
            debugPrint(e.toString());
          }

          return parser(response.data);
        } else {
          return parser(response.data);
        }
      }
      return parser(response.data);
    }, path: path);
  }

  @override
  Future<T> get<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      late HttpMetric metric;
      if (!AppDebugConfigKey.logResponseApi) {
        metric = FirebasePerformance.instance.newHttpMetric(
            path.startsWith('http') ? path : (_dio.options.baseUrl + path),
            HttpMethod.Get);
        await metric.start();
      }
      dio.Response response;
      try {
        response = await _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        );
        if (!AppDebugConfigKey.logResponseApi) {
          metric.responseContentType = response.headers.value('content-type');
          metric.httpResponseCode = response.statusCode;
        }
      } finally {
        if (!AppDebugConfigKey.logResponseApi) {
          await metric.stop();
        }
      }

      return parser(response.data);
    });
  }

  static Future<dynamic> _decryptionDataIsolate(
      Map<String, dynamic> dataIsolate) async {
    {
      String data = dataIsolate['data'];

      var keyAes = dataIsolate['keyAes'];

      var keyGiaiMa = encry.Key.fromUtf8(keyAes);

      var iv = encry.IV.fromUtf8(data.substring(0, 16));

      encry.Encrypter encrypter = encry.Encrypter(
          encry.AES(keyGiaiMa, mode: encry.AESMode.cbc, padding: null));

      String decrypted = encrypter.decrypt(
          encry.Encrypted.fromBase64(data.substring(16, data.length)),
          iv: iv);

      String newData = decrypted;
      int space = 0;
      Map<String, dynamic> dataMap = HashMap();
      final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
      for (int i = newData.length; i > 0; i--) {
        if (newData.substring(i - 1, i) == "]" ||
            newData.substring(i - 1, i) == "}" ||
            alphanumeric.hasMatch(newData.substring(i - 1, i))) {
          break;
        } else {
          space++;
        }
      }

      if (newData.length == space) {
        dataMap.putIfAbsent('data', () => newData);
      } else {
        newData = newData.substring(0, newData.length - space);
        dataMap.putIfAbsent('data', () => newData);
      }

      return dataMap;
    }
  }

  static dynamic computeIsolate(Map<String, dynamic> mapData) async {
    return await compute(_decryptionDataIsolate, mapData);
  }

  @override
  Future<T> delete<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      final metric = FirebasePerformance.instance.newHttpMetric(
          path.startsWith('http') ? path : (_dio.options.baseUrl + path),
          HttpMethod.Delete);
      await metric.start();
      dio.Response response;
      try {
        response = await _dio.delete(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        metric.responseContentType = response.headers.value('content-type');
        metric.httpResponseCode = response.statusCode;
      } finally {
        await metric.stop();
      }

      return parser(response.data);
    });
  }

  @override
  Future<T> put<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      final metric = FirebasePerformance.instance.newHttpMetric(
          path.startsWith('http') ? path : (_dio.options.baseUrl + path),
          HttpMethod.Put);
      await metric.start();
      dio.Response response;
      try {
        response = await _dio.put(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        metric.responseContentType = response.headers.value('content-type');
        metric.httpResponseCode = response.statusCode;
      } finally {}
      return parser(response.data);
    });
  }

  @override
  Future<List<T>> getList<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      late HttpMetric metric;
      if (!AppDebugConfigKey.logResponseApi) {
        metric = FirebasePerformance.instance.newHttpMetric(
            path.startsWith('http') ? path : (_dio.options.baseUrl + path),
            HttpMethod.Get);
        await metric.start();
      }
      dio.Response response;
      try {
        response = await _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        );
        if (!AppDebugConfigKey.logResponseApi) {
          metric.responseContentType = response.headers.value('content-type');
          metric.httpResponseCode = response.statusCode;
        }
      } finally {
        if (!AppDebugConfigKey.logResponseApi) {
          await metric.stop();
        }
      }
      return (response.data as List)
          .map<T>((e) => parser(e as Map<String, dynamic>))
          .toList();
    });
  }

  Future<T> _remapError<T>(ValueGetter<Future<T>> func,
      {bool? showToastNotConnect, String? path}) async {
    try {
      return await func();
    } catch (e) {
      LogEventAndScreen.share.logEvent(
        name: 'lv9_api_call',
        parameters: {'lv9_api_path': path, 'lv9_api_result': '0'},
      );
      return await _apiErrorToInternalError(e,
          showToastNotConnect: showToastNotConnect);
    }
  }

  Future<dynamic> _apiErrorToInternalError(e,
      {bool? showToastNotConnect}) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (e is DioError) {
      DioError? error;
      if (e.message.contains('HandshakeException')) {
        error = DioError(
            requestOptions: e.requestOptions,
            response: e.response,
            type: e.type,
            error: 'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.');
      } else {
        error = e;
      }

      // if (result == true) {
      //   FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
      // }
      if (error.type == DioErrorType.connectTimeout ||
          error.type == DioErrorType.receiveTimeout ||
          (error.type == DioErrorType.other &&
              error.error is SocketException) ||
          !(result)) {
        if (showToastNotConnect == false) {
          AppToast.share.showToast(
              'Chưa cập nhật được dữ liệu. Vui lòng kiểm tra kết nối mạng & thử lại');
        }
        throw NetworkIssueException();
      }
      // ToastUtils.showValidateToast(e.requestOptions.path);
      throw ServerException(error);
    }
    // ToastUtils.showValidateToast(e.requestOptions.path);
    if (result == true) {
      FirebaseCrashlytics.instance.recordError(e, e.stackTrace);
    }
    throw e;
  }
}
