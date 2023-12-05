import 'dart:async';
import 'dart:io';

import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/app_open_ad_manager.dart';
import 'package:lichviet_flutter_base/core/utils/user_utils.dart';
import 'package:lichviet_flutter_base/cubit/global_cubit/app_cubit/app_cubit.dart';
import 'package:lichviet_flutter_base/cubit/user_cubit/user_cubit.dart';
import 'package:lichviet_flutter_base/widgets/admob_full.dart';
import 'enums.dart';

class AdsManager {
  AdsManager._();
  bool isMaxInit = false;
  void maxDidInit() {
    isMaxInit = true;
    initMaxController.sink.add(isMaxInit);
  }

  /// Nếu mà chưa init Max mà đã gọi qc,
  ///  hoặc đang init admob (admob init max) mà gọi init max,
  ///  hoặc đang intit Max mà gọi init max tiếp => ứng dụng ẳng => cần có cái này.
  /// Cần stream để màn home đảm bảo có qc sau khi max đc init
  StreamController initMaxController = StreamController<bool>.broadcast();
  Stream get initMaxStream => initMaxController.stream;

  static final instance = AdsManager._();
  static const appLovinMaxSdkKey =
      'q2nDGRagWCCFcst329rTW4m8zimc4mEgFwPm_k1cq9kOCEcmw3P_C3cV7dIa1LBeUhVF4Tt1d4o0pku_T6Lfvl';
  static Future<void> initAdNetworks() async {
    MobileAds.instance.initialize().then((initializationStatus) {
      // initializationStatus.adapterStatuses.forEach((key, value) {
      //   debugPrint('Adapter status for $key: ${value.description}');
      // });
      debugPrint('Bat dau khoi tao appLovin ${DateTime.now()}');
      AppLovinMAX.initialize(appLovinMaxSdkKey).then((value) {
        debugPrint('finish khoi tao appLovin ${DateTime.now()}');
        debugPrint(value.toString());
        AdsManager.instance.maxDidInit();
        // AdmobFull.getInstance().loadInterstitialAd(
        //     delay: const Duration(milliseconds: 500), fromInitApp: true);
        AppLovinMAX.setTestDeviceAdvertisingIds([
          'EFA51E4E-D342-4AD4-8630-EC5E1A492A58',
          'CEEA5327-A599-429F-A996-4FE7B4F5DF6E'
        ]);
      });
    });
  }

  static bool useTestAd() {
    const debugTestAd = true;
    return kDebugMode && debugTestAd;
  }

  static String getAppLovinKey({required AppLovinType appLovinType}) {
    if (!AdsManager._availableToLoadAppLovin(appLovinType: appLovinType)) {
      return '';
    }
    switch (appLovinType) {
      case AppLovinType.appOpen:
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_applovin_open_app);
      case AppLovinType.banner:
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_applovin_banner);
      case AppLovinType.mRec:
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_applovin_mrec);
      case AppLovinType.interstitial:
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_applovin_inter);
      default:
        return '';
    }
  }

  static String getAdmobKey({required AdmobType admobType}) {
    if (!AdsManager._availabeToLoadAdmob(admobType: admobType)) {
      return '';
    }
    final useTestAd = AdsManager.useTestAd();
    switch (admobType) {
      case AdmobType.appOpen:
        if (useTestAd) {
          return Platform.isAndroid
              ? 'ca-app-pub-3940256099942544/3419835294'
              : 'ca-app-pub-3940256099942544/5662855259';
        }
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_admob_open_app);
      case AdmobType.anchoredAdaptiveBanner:
        if (useTestAd) {
          return Platform.isAndroid
              ? 'ca-app-pub-3940256099942544/6300978111'
              : 'ca-app-pub-3940256099942544/2934735716';
        }
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_admob_banner);
      case AdmobType.inlineBanner:
        if (useTestAd) {
          return Platform.isAndroid
              ? 'ca-app-pub-3940256099942544/6300978111'
              : 'ca-app-pub-3940256099942544/2934735716';
        }
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_admob_banner_inline);
      case AdmobType.interstitial:
        if (useTestAd) {
          return Platform.isAndroid
              ? 'ca-app-pub-3940256099942544/1033173712'
              : 'ca-app-pub-3940256099942544/4411468910';
        }
        if (AppConfigManager.share.stringValueForKey(
                AppConfigKey.interstitial_ad_load_when_app_open) ==
            '1') {
          final admobInterKey = AppConfigManager.share.stringValueForKey(
              AppConfigKey.adid_admob_interstitial_load_when_openning);
          debugPrint('Key interstitial type load when open app $admobInterKey');
          return admobInterKey;
        } else {
          final admobInterKey = AppConfigManager.share
              .stringValueForKey(AppConfigKey.adid_admob_interstitial);
          debugPrint('Key interstitial type load when push $admobInterKey');
          return admobInterKey;
        }
      case AdmobType.nativeAds:
        if (useTestAd) {
          return Platform.isAndroid
              ? 'ca-app-pub-3940256099942544/2247696110'
              : 'ca-app-pub-3940256099942544/3986624511';
        }
        return AppConfigManager.share
            .stringValueForKey(AppConfigKey.adid_admob_native);
      default:
    }
    return '';
  }

  static bool avaialbeToShowAdmob({required AdmobType admobType}) {
    if (UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo)) {
      return false;
    } else {
      if (admobType == AdmobType.interstitial ||
          admobType == AdmobType.appOpen) {
        return checkDieuKienKhoangCachInter(checkForLoading: false);
      }
      return true;
    }
  }

  static bool avaiableToShowAppLovin({required AppLovinType appLovinType}) {
    if (UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo)) {
      return false;
    } else {
      if (appLovinType == AppLovinType.interstitial ||
          appLovinType == AppLovinType.appOpen) {
        return checkDieuKienKhoangCachInter(checkForLoading: false);
      }
      return true;
    }
  }

  static bool _availableToLoadAppLovin({required AppLovinType appLovinType}) {
    if (UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo)) {
      return false;
    }
    switch (appLovinType) {
      case AppLovinType.appOpen:
        return false;
      case AppLovinType.interstitial:
        return checkDieuKienKhoangCachInter(checkForLoading: true);
      default:
        return true;
    }
  }

  static bool _availabeToLoadAdmob({required AdmobType admobType}) {
    //1. Neu la pro thi k load
    if (UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo)) {
      return false;
    }
    switch (admobType) {
      case AdmobType.appOpen:
        if (AppOpenAdManager.share.isAdAvailable) {
          return false;
        }
        return true;
      case AdmobType.interstitial:
        return checkDieuKienKhoangCachInter(checkForLoading: true);
      default:
        return true;
    }
  }

  static bool checkDieuKienKhoangCachInter({required bool checkForLoading}) {
    final appCubit = GetIt.I<AppCubit>();
    // await appCubit.getConfigListLocal();
    final currentConfig = appCubit.state.config;
    final currentNumbSession = appCubit.getCountSession() ?? 0;
    final timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final timeLastShow = appCubit.getTimeShowAdsmobFull() ?? 0;
    final rangeTime = AppConfigManager.share
        .doubleValueForKey(AppConfigKey.lv_ad_interstitial_gap_time);
    if (checkForLoading) {
      // Load truoc khi co the show 30 giay
      if ((timeLastShow + rangeTime - 30) >
          DateTime.now().millisecondsSinceEpoch / 1000) {
        return false;
      }
    } else {
      // Neu vua show xong chua duoc range time thi thoi
      if ((timeLastShow + rangeTime) >
          DateTime.now().millisecondsSinceEpoch / 1000) {
        return false;
      }
    }

    final firstTimeOpenApp = appCubit.getFirstTimeUsingApp() ?? timeNow;
    if ((currentNumbSession < 3) &&
        ((firstTimeOpenApp + 3 * 24 * 3600) > timeNow)) {
      return false;
    }
    // Neu hien du so toi da trong 1 phien thi k load (chi ap dung voi interstitial)
    final countNumberAdDidShowInCurrentSession =
        GetIt.I<AppCubit>().getAdMaxTimePerSession();
    final lvAdInterstitialMaxTimePerSession = int.tryParse(AppConfigManager
            .share
            .stringValueForKey('lv_ad_interstitial_max_time_per_session')) ??
        2;
    if (countNumberAdDidShowInCurrentSession >=
        lvAdInterstitialMaxTimePerSession) {
      // So qc trong 1 phien da max, lau qua chua hien quang cao thi lai reset lai thoi
      if (timeLastShow + 10 * rangeTime < timeNow) {
        GetIt.I<AppCubit>().setAdMaxTimePerSession(0);
      } else {
        return false;
      }
    }
    return true;
  }

  static void recordAdClick(
      {required String adType,
      required String adUnitId,
      required String screenName,
      required String adSource,
      required String adNetwork}) {
    FirebaseAnalytics.instance.logEvent(
      name: 'lv_ad_click',
      parameters: {
        'lv_ad_format': adType,
        'lv_screen_name': screenName,
        'lv_ad_network': adNetwork,
        'lv_ad_source': adSource,
        'lv_ad_unit_id': adUnitId,
        'lv_ad_platform': Platform.isIOS ? 'iOS' : 'android',
      },
    );
  }
}
