// ignore_for_file: constant_identifier_names

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/domain/usecases/usercases.dart';

const Map<String, dynamic> defaultConfig = {
  AppConfigKey.log_response_api: 0,
  AppConfigKey.replace_native_by_banner: 0,
  AppConfigKey.ad_open_max_cache_hours: 4,
  AppConfigKey.banner_ad_auto_refresh_in_seconds: 60,
  AppConfigKey.lv_ad_interstitial_gap_time: 90,
  AppConfigKey.use_remote_config_first: '1',
  AppConfigKey.lv9_hide_giaima_ngaysinh: 1,
  AppConfigKey.native_slide_banner_percent: 50,
  AppConfigKey.lv9_place_api_key: 'AIzaSyC2yDpOS84Un6E7pBDcBnoOh9Qs6GTi6UM',
  AppConfigKey.lv9_login_method: 'zalo#google#apple',
  AppConfigKey.login_facebook_disable: '1',
  AppConfigKey.percent_show_native_insteed_of_inter: 50,
};

class AppConfigManager {
  /// private constructor
  AppConfigManager._();
  late FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  late Map<String, dynamic> serverConfig =
      GetIt.I<AppUseCase>().getConfigLocal()?.jsonConfig ?? <String, dynamic>{};
  late bool useRemoteConfigFirst = _useRemoteConfigFirst();

  /// the one and only instance of this singleton
  static final share = AppConfigManager._();
  bool _useRemoteConfigFirst() {
    final serverValue =
        serverConfig[AppConfigKey.use_remote_config_first].toString();
    if (serverValue.isNotEmpty && serverValue != 'null') {
      return serverValue == '1';
    }
    final defaultValue =
        defaultConfig[AppConfigKey.use_remote_config_first].toString();
    return defaultValue == '1';
  }

  String stringValueForKey(String configKey) {
    if (useRemoteConfigFirst) {
      final remoteValue = remoteConfig.getString(configKey);
      if (remoteValue.isNotEmpty && remoteValue != 'null') {
        return remoteValue;
      }
    }
    final serverValue = serverConfig[configKey].toString();
    if (serverValue.isNotEmpty && serverValue != 'null') {
      return serverValue;
    }
    final defaultValue = defaultConfig[configKey].toString();
    return defaultValue != 'null' ? defaultValue : '';
  }

  double doubleValueForKey(String configKey) {
    return double.tryParse(
            AppConfigManager.share.stringValueForKey(configKey)) ??
        -1;
  }

  String debugModeValueForkey(String configKey) {
    return defaultConfig[configKey].toString();
  }
}

class AppConfigKey {
  static const String log_response_api = 'log_response_api';
  static const String replace_native_by_banner = 'replace_native_by_banner';
  static const String show_rate_inline_banner_with_native_percent =
      'show_rate_inline_banner_with_native_percent';
  static const String interstitial_ad_load_when_app_open =
      'interstitial_ad_load_when_app_open';

// Appsource
  static const String ad_source_banner = 'ad_source_banner';
  static const String ad_source_interstitial = 'ad_source_interstitial';
  static const String ad_source_native = 'ad_source_native';

  // App Lovin
  static const String adid_applovin_open_app = 'adid_applovin_open_app';
  static const String adid_applovin_banner = 'adid_applovin_banner';
  static const String adid_applovin_inter = 'adid_applovin_inter';
  static const String adid_applovin_mrec = 'adid_applovin_mrec';
  // Admob
  static const String adid_admob_open_app = 'adid_admob_open_app';
  static const String show_open_ad_percent = 'show_open_ad_percent';
  static const String adid_admob_banner = 'adid_admob_banner';
  static const String adid_admob_banner_inline = 'adid_admob_banner_inline';
  static const String adid_admob_interstitial_load_when_openning =
      'adid_admob_interstitial_load_when_openning';
  static const String adid_admob_interstitial = 'adid_admob_interstitial';
  static const String adid_admob_native = 'adid_admob_native';
  static const String ad_open_max_cache_hours = 'ad_open_max_cache_hours';
  static const String banner_ad_auto_refresh_in_seconds =
      'banner_ad_auto_refresh_in_seconds';
  static const String lv_ad_interstitial_gap_time =
      'lv_ad_interstitial_gap_time';
  static const String use_remote_config_first = 'use_remote_config_first';
  // giai ma ngay sinh
  static const String lv9_hide_giaima_ngaysinh = 'lv9_hide_giaima_ngaysinh';
  // Old config
  static const String native_slide_banner_percent =
      'native_slide_banner_percent';
  static const String lv9_place_api_key = 'lv9_place_api_key';
  static const String lv9_login_method = 'lv9_login_method';
  static const String home_toplist_slide_icons = 'home_toplist_slide_icons';
  static const String appVersionUpdate = 'appVersionUpdate';
  static const String login_facebook_disable = 'login_facebook_disable';
  static const String percent_show_native_insteed_of_inter =
      'percent_show_native_insteed_of_inter';
}

class AppDebugConfigKey {
  static const bool logResponseApi = true;
}
