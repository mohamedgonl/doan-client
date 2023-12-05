import 'dart:collection';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/api/network_logger/network_logger_interceptor.dart';
import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';
import 'package:lichviet_flutter_base/core/utils/utils.dart';
import 'package:lichviet_flutter_base/cubit/user_cubit/user_cubit.dart';
import 'package:lichviet_flutter_base/data/datasource/local/app_local_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/end_points.dart';
import 'package:lichviet_flutter_base/lichviet_flutter_base.dart';

import 'interceptors.dart';

/// An interceptor to handle session expired and try refresh token if available
/// When a request failed with error code 401 or 403 and token is not null
/// It will try call refresh token
/// At this time, all requests should be locked. You can handle lock request on callback [onLockRequests]
/// If successfully, it will save new token, refresh token. You must unlock request in callback [onUnlockRequests]
/// If failure, it will trigger full exipred, you can listen on [onSessionExpired]
class SessionInterceptor extends Interceptor {
  final KeyRsaTripletProvider keyRsaTripletProvider;
  final VoidCallback onLockRequests;
  final VoidCallback onUnlockRequests;
  final VoidCallback onSessionExpired;
  final String baseUrl;
  final Lock lock;

  SessionInterceptor(
      {required this.baseUrl,
      required this.onLockRequests,
      required this.onUnlockRequests,
      required this.onSessionExpired,
      required this.keyRsaTripletProvider,
      required this.lock});

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.data['status'].toString() != "1") {
      LichVietFlutterBase.getInstance().managerCache?.deleteByPrimaryKeyWithUri(
            response.realUri,
          );
    }
    if (response.data['status'] == -100) {
      LichVietFlutterBase.getInstance().managerCache?.clearAll();
      if (keyRsaTripletProvider.idiv.toString() !=
          response.requestOptions.headers['identifier']) {
        response.requestOptions.headers['identifier'] =
            keyRsaTripletProvider.idiv.toString();
        Dio()
          ..interceptors.addAll([
            logInterceptor,
            NetworkLoggerInterceptor(),
          ])
          ..fetch(response.requestOptions).then(
            (resp) => handler.resolve(resp),
            onError: (e) => handler.reject(e),
          );
        return;
      }
      keyRsaTripletProvider.setIdiv(ivid: -1);
      final Map<String, String> headers = {};
      headers['apikey'] = 'rklHRCArf7Jj8uR8t1sLLWFcwObH3f6rHlPY1Zvkz40GfaP0Pb';
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo? androidDeviceInfo;
      IosDeviceInfo? iosInfo;
      if (Platform.isAndroid) {
        androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      } else {
        iosInfo = await deviceInfoPlugin.iosInfo;
      }

      headers['deviceinfo'] = DeviceInfo()
          .nameDevide(androidDeviceInfo: androidDeviceInfo, iosInfo: iosInfo);
      headers['User-Agent'] = 'Dart';
      headers['osinfo'] = DeviceInfo().getTypeOs();
      headers['appversion'] = LichVietFlutterBase.getInstance().appInfo ?? '';
      headers['app_version'] = LichVietFlutterBase.getInstance().appInfo ?? '';
      if (GetIt.I<UserCubit>().state.userInfo != null) {
        if (GetIt.I<UserCubit>().state.userInfo!.id != null) {
          headers['user_id'] =
              GetIt.I<UserCubit>().state.userInfo!.id!.toString();
        }
      }

      final _originalOptions = response.requestOptions;
      // await keyRsaTripletProvider.genarateNewKey();
      Map<String, dynamic> param = HashMap();
      param.putIfAbsent("public_key", () => keyRsaTripletProvider.publicKey);
      debugPrint('get_iv_key');
      if (keyRsaTripletProvider.idiv == -1) {
        lock.lock();
        final dio = Dio()
          ..options = BaseOptions(
            baseUrl: baseUrl,
            contentType: 'application/x-www-form-urlencoded',
            headers: headers,
          )
          ..interceptors.addAll([
            logInterceptor,
            NetworkLoggerInterceptor(),
          ]);
        await dio
            .post(
          EndPoints.configV2,
          data: param,
        )
            .then((res) {
          keyRsaTripletProvider.setIdiv(ivid: res.data['data']['identifier']);

          keyRsaTripletProvider.setKey(
              type: TypeRsaKey.publicKeyRsa, key: res.data['data']['key']);

          _originalOptions.headers['identifier'] =
              res.data['data']['identifier'].toString();
          lock.unlock();
          Dio()
            ..interceptors.addAll([
              logInterceptor,
              NetworkLoggerInterceptor(),
            ])
            ..fetch(_originalOptions).then(
              (resp) {
                return handler.resolve(resp);
              },
              onError: (e) => handler.reject(e),
            );
        }, onError: (e) {
          lock.unlock();
          onSessionExpired();
          return handler.next(e);
        });
      } else {
        _originalOptions.headers['identifier'] =
            keyRsaTripletProvider.idiv.toString();
        Dio()
          ..interceptors.addAll([
            logInterceptor,
            NetworkLoggerInterceptor(),
          ])
          ..fetch(_originalOptions).then(
            (resp) {
              return handler.resolve(resp);
            },
            onError: (e) => handler.reject(e),
          );
      }
      return;
    }
    return handler.next(response);
  }

  /// If the token is not existing or the error not relate to token issue, continue with the error
  // bool _shouldRefreshToken(TokenResponse token, int? errorCode) =>
  //     token.accessToken.isNotNullOrEmpty &&
  //     token.refreshToken.isNotNullOrEmpty &&
  //     (errorCode == 401 || errorCode == 403);
}
