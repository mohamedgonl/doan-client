import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/data/datasource/local/app_local_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/core/utils/alice/alice.dart';
import 'package:lichviet_flutter_base/lichviet_flutter_base.dart';
// import 'package:le_hoi_module/le_hoi_module/le_hoi/services/network/di_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> channelModule(GetIt getIt) async {
  const channelName = LichVietFlutterBase.channelNative;
  const standardMethod = StandardMethodCodec();
  getIt.registerLazySingleton<MethodChannel>(
      () => const MethodChannel(channelName, standardMethod));
  MethodChannel _platform = GetIt.I<MethodChannel>();
  final sharedPreferences = await SharedPreferences.getInstance();
  configEnvironment(_platform);
  await getHeaderFromNative(_platform, sharedPreferences);
}

void configEnvironment(MethodChannel platform) async {
  try {
    String data = await platform.invokeMethod(ChannelEndpoint.getEnvironment);
    if (data == 'prod') {
      LichVietFlutterBase.configProduct.baseUrl = 'https://api.lichviet.org';
    } else {
      LichVietFlutterBase.configProduct.baseUrl =
          'http://test.api.lichviet.org';
    }
  } catch (_e) {
    LichVietFlutterBase.configProduct.baseUrl = 'https://api.lichviet.org';
  }
}

Future<void> getHeaderFromNative(
    MethodChannel platform, SharedPreferences sharedPreferences) async {
  try {
    var data = await platform.invokeMethod(ChannelEndpoint.getApiCommonHeader);
    if (data != null) {
      if (data is String) {
        data = jsonDecode(data);
      }
      String? appVersionFlutter =
          sharedPreferences.getString('app_version') ?? '9.3 - 553';

      try {
        if (Platform.isAndroid) {
          sharedPreferences.setInt(
              'sdkVersion', int.parse(data['sdkInt'].toString()));
        }
      } catch (ex) {
        print(ex.toString());
      }

      if (appVersionFlutter != data['app_info'].toString()) {
        sharedPreferences.setInt('count_state_banner', 1);
        sharedPreferences.setInt('count_state_natived', 1);
        sharedPreferences.setInt('count_rate_fromSever', 50);
        sharedPreferences.setString('app_version', data['app_info'].toString());
        appVersionFlutter = data['app_info'].toString();

        try {
          sharedPreferences.remove('identifier');
          sharedPreferences.remove('public_rsa_key');
          sharedPreferences.remove('private_rsa_key');
        } catch (_e) {}
        await DefaultCacheManager().emptyCache();
        await LichVietFlutterBase.getInstance().managerCache?.clearAll();
      }

      data = Map<String, dynamic>.from(data);
      LichVietFlutterBase.getInstance().setAppInfo =
          data['app_info'].toString();
      LichVietFlutterBase.getInstance().setDeviceId =
          data['device_id'].toString();
      LichVietFlutterBase.getInstance().setDeviceInfo =
          data['device_info'].toString();
      LichVietFlutterBase.getInstance().setFcmToken =
          data['fcmToken'].toString();
      LichVietFlutterBase.getInstance().seOsInfo = data['os_info'].toString();
      LichVietFlutterBase.getInstance().setApnsToken =
          data['apns_token'].toString();
    }
  } catch (_e) {
    LichVietFlutterBase.getInstance().setAppInfo = '9.3 (557)';
    LichVietFlutterBase.getInstance().setDeviceId = 'device_id';
    LichVietFlutterBase.getInstance().setDeviceInfo = 'device_info';
    LichVietFlutterBase.getInstance().setFcmToken = 'fcmToken';
    LichVietFlutterBase.getInstance().seOsInfo = 'os_info';
  }
}
