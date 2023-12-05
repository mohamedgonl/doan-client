import 'dart:io';

import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:lichviet_flutter_base/core/utils/device_info.dart';

class DeleteAccountInterceptor extends Interceptor {
  DeleteAccountInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Map<String, String> headers = {};
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo? androidDeviceInfo;
    IosDeviceInfo? iosInfo;
    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      headers['device_id'] = androidDeviceInfo.id;
    } else {
      iosInfo = await deviceInfoPlugin.iosInfo;
      headers['device_id'] = iosInfo.identifierForVendor ?? '';
    }
    headers['device_info'] = DeviceInfo()
        .nameDevide(androidDeviceInfo: androidDeviceInfo, iosInfo: iosInfo);
    headers['os_info'] = DeviceInfo().getTypeOs();
    headers['app_info'] = await DeviceInfo().getVersionCode();
    options.headers = headers;
    return super.onRequest(options, handler);
  }
}
