import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_mediate_banner_repo.dart';
import 'package:lichviet_flutter_base/cubit/global_cubit/app_cubit/app_cubit.dart';
import 'package:lichviet_flutter_base/widgets/admob_full.dart';

class AppOpenAdManager {
  AppOpenAdManager._();
  static AppOpenAdManager share = AppOpenAdManager._();
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  bool _isLoadingAd = false;

  /// Maximum duration allowed between loading and showing the ad.
  Duration maxCacheDuration = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;
  DateTime? _lastClickAds;

  /// Load an AppOpenAd.
  Future<void> loadAd() async {
    if (_isLoadingAd) {
      return;
    }
    final adUnitId = AdsManager.getAdmobKey(admobType: AdmobType.appOpen);
    if (adUnitId == '') {
      return;
    }
    _isLoadingAd = true;
    AppOpenAd.load(
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoadingAd = false;
          _appOpenAd = ad;
          _appOpenLoadTime = DateTime.now();
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          _isLoadingAd = false;
          // Handle the error.
        },
      ),
    );
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    if (_appOpenAd == null) {
      return false;
    }
    maxCacheDuration = Duration(
        hours: AppConfigManager.share
            .doubleValueForKey(AppConfigKey.ad_open_max_cache_hours)
            .toInt());
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      debugPrint('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      return false;
    }
    return true;
  }

  void showAdIfAvailable() {
    // Check tan suat show

    if (!isAdAvailable) {
      debugPrint('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (!AdsManager.avaialbeToShowAdmob(admobType: AdmobType.appOpen)) {
      return;
    }
    if (_isShowingAd) {
      debugPrint('Tried to show ad while already showing an ad.');
      return;
    }
    if (_lastClickAds != null) {
      final minTimeShowAfterLastClick = Duration(
          seconds: AppConfigManager.share
              .doubleValueForKey(AppConfigKey.lv_ad_interstitial_gap_time)
              .toInt());
      if (DateTime.now()
          .subtract(minTimeShowAfterLastClick)
          .isBefore(_lastClickAds!)) {
        return;
      }
    }

    maxCacheDuration = Duration(
        hours: AppConfigManager.share
            .doubleValueForKey(AppConfigKey.ad_open_max_cache_hours)
            .toInt());
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      debugPrint('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    final showOpenAppPercent = AppConfigManager.share
        .doubleValueForKey(AppConfigKey.show_open_ad_percent);
    final randomShowrate = Random().nextInt(101);
    if (!(showOpenAppPercent > randomShowrate)) {
      debugPrint('khong show ad open do ti le show la $showOpenAppPercent');
      return;
    }
    debugPrint('show ad open do ti le show la $showOpenAppPercent');
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        debugPrint('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdClicked: (ad) {
        AdsManager.recordAdClick(
            adType: AdmobType.appOpen.name,
            adUnitId: ad.adUnitId,
            adNetwork: AdNetwork.admob.name,
            screenName: LogEventAndScreen.share.lastLogScreen,
            adSource: ad.responseInfo?.mediationAdapterClassName ?? 'un_know');
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    try {
      GetIt.I<AppCubit>()
          .setTimeShowAdsmobFull(DateTime.now().millisecondsSinceEpoch ~/ 1000);
      _appOpenAd!.show().then((value) {
        final countNumberAdDidShowInCurrentSession =
            GetIt.I<AppCubit>().getAdMaxTimePerSession();
        GetIt.I<AppCubit>()
            .setAdMaxTimePerSession(countNumberAdDidShowInCurrentSession + 1);
      }).catchError((error) {});
    } catch (e) {}
  }
}
