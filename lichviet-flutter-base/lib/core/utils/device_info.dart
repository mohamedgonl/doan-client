import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  String nameDevide(
      {AndroidDeviceInfo? androidDeviceInfo, IosDeviceInfo? iosInfo}) {
    if (Platform.isAndroid) {
      return androidDeviceInfo!.model;
    } else {
      return iosInfo!.model ?? "unknow";
    }
  }

  String getTypeOs() {
    if (Platform.isIOS) {
      return "ios";
    } else {
      return "android";
    }
  }

  Future<String> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version} (${packageInfo.buildNumber})';
  }
}
