import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';

import 'package:lichviet_flutter_base/core/exceptions/auth_email_exception.dart';
import 'package:lichviet_flutter_base/core/exceptions/xem_ngay_tot_exception.dart';
import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';
import 'package:lichviet_flutter_base/core/utils/toast_utils.dart';
import 'package:lichviet_flutter_base/cubit/user_cubit/user_cubit.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/app_remote_datasouce.dart';

import 'package:lichviet_flutter_base/lichviet_flutter_base.dart';

/// Add access_token, more needed params into request's header
class AuthInterceptor extends Interceptor {
  final KeyRsaTripletProvider _keyRsaTripletProvider;
  final MethodChannel _platform;

  AuthInterceptor(
    this._keyRsaTripletProvider,
    this._platform,
  );

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final idiv = _keyRsaTripletProvider.idiv;
    final Map<String, String> headers = {};
    if (idiv != null && idiv != 0) {
      headers['identifier'] = idiv.toString();
    }
    headers['apikey'] = 'rklHRCArf7Jj8uR8t1sLLWFcwObH3f6rHlPY1Zvkz40GfaP0Pb';
    // headers['encrypt'] = RemoteConstants.encrypt;
    headers['app_info'] = LichVietFlutterBase.getInstance().appInfo ?? '';
    headers['device_id'] = LichVietFlutterBase.getInstance().deviceId ?? '';
    headers['device_info'] = LichVietFlutterBase.getInstance().deviceInfo ?? '';
    headers['fcmToken'] = LichVietFlutterBase.getInstance().fcmToken ?? '';
    headers['os_info'] = LichVietFlutterBase.getInstance().osInfo ?? '';
    headers['appversion'] = LichVietFlutterBase.getInstance().appInfo ?? '';
    headers['app_version'] = LichVietFlutterBase.getInstance().appInfo ?? '';
    headers['apns_token'] = LichVietFlutterBase.getInstance().apnsToken ?? '';
    headers['Content-Type'] = 'application\/x-www-form-urlencoded';
    headers['User-Agent'] = 'Dart';
    if (GetIt.I<UserCubit>().state.userInfo != null) {
      if (GetIt.I<UserCubit>().state.userInfo!.id != null) {
        headers['user_id'] =
            GetIt.I<UserCubit>().state.userInfo!.id!.toString();
      }
    }
    headers['secret_key'] = 'yjbncWm3kgMESMIN6uR9';

    options.headers = headers;
    return super.onRequest(options, handler);
  }

  String _handleMessage(
      String? message, String? buttonTitle, String? buttonLink) {
    String messageValue = message?.toString() ?? '';
    if (buttonTitle != null &&
        buttonLink != null &&
        buttonTitle.toString().isNotEmpty &&
        buttonLink.toString().isNotEmpty) {
      messageValue =
          '${messageValue}cta_button_title=${buttonTitle.toString()}button_link=${buttonLink.toString()}';
    }
    return messageValue;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      if (response.data['status'] == 0) {
        if (response.data['message'] != null &&
            response.data['message'].isNotEmpty) {
          String message = _handleMessage(response.data['message'],
              response.data['cta_button_title'], response.data['button_link']);
          return handler.reject(DioError(
              requestOptions: response.requestOptions,
              error: Exception(message)));
        } else {
          if (response.data['error'] != null &&
              response.data['error'] is List) {
            var messageContent = await _platform.invokeMethod(
                ChannelEndpoint.getErrorCode,
                {'code': response.data['error'].first});
            // var messageContent = '';
            if (messageContent == 'Có lỗi xảy ra!' ||
                (messageContent as String).isEmpty) {
              messageContent = await getErrorCode(response.data['error'].first);
            }
            String message = _handleMessage(
                messageContent,
                response.data['cta_button_title'],
                response.data['button_link']);
            return handler.reject(DioError(
                requestOptions: response.requestOptions,
                error: Exception(message)));
          } else {
            return handler.reject(DioError(
                requestOptions: response.requestOptions,
                error: Exception(
                    'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.')));
          }
        }
      }
    } catch (_e) {}
    final resposeStatus = int.tryParse(response.data['status'].toString());
    if (resposeStatus == null) {
      return handler.next(response);
    }
    if (resposeStatus == -2 || resposeStatus == -1) {
      _platform.invokeMethod(ChannelEndpoint.handleServerError, response.data);
      if (response.data['status'] == -2) {
        LogEventAndScreen.share.logEvent(
          name: 'lv9_logout',
          parameters: {'lv9_logout_case': '1'},
        );
        GetIt.I<UserCubit>().clearCacheLogout();
      }
    }
    if (resposeStatus == 3) {
      return handler.reject(DioError(
          requestOptions: response.requestOptions,
          error: XemNgayTotException(response.data['error'])));
    }
    if (resposeStatus == 2) {
      return handler.reject(DioError(
          requestOptions: response.requestOptions,
          error: AuthEmailException()));
    }
    return handler.next(response);
  }

  Future<String> getErrorCode(String code) async {
    try {
      final errorList = await GetIt.I<AppRemoteDataSource>().getErrorList();
      return errorList.firstWhere((element) => element.code == code).content ??
          'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.';
    } catch (e) {
      return 'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.';
    }
  }
}
