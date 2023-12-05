import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/core/routing/app_router.dart';
import 'package:lichviet_flutter_base/core/routing/routing.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_mediate_banner_repo.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/custom_ads_insteed_interstitial.dart';
import 'package:lichviet_flutter_base/cubit/global_cubit/app_cubit/app_cubit.dart';

import '../core/utils/app_config_manager/app_config_manager.dart';
import '../core/utils/quangcao/quangcao.dart';

class AdmobFull {
  static AdmobFull? _admob;
  static AdmobFull getInstance() {
    if (_admob != null) return _admob!;
    _admob = AdmobFull();
    return _admob!;
  }

  AdmobFull();
  Function(String? strReturn)? callBackAdShown;
  InterstitialAd? admobInter;
  AdNetwork? usingAdNetwork;
  late List<AdNetwork> listAdNetwork;
  bool isLoadingAd = false;
  DateTime? lastRequestAd;
  bool loadAdResult = false;

  Future<bool> hasAdAvaiableToShow() async {
    if (admobInter != null) {
      return true;
    }
    final appLovinAdUnitId = AppConfigManager.share
        .stringValueForKey(AppConfigKey.adid_applovin_inter);
    if (!AdsManager.instance.isMaxInit || appLovinAdUnitId.isEmpty) {
      return false;
    }
    final appLovinAvai =
        await AppLovinMAX.isInterstitialReady(appLovinAdUnitId) ?? false;
    if (appLovinAvai) {
      usingAdNetwork = AdNetwork.appLovin;
    }
    return appLovinAvai;
  }

  void showInterstitial(
      {required Function(String? msgReturn) onClose,
      required BuildContext context}) async {
    // _checkShowNativeAdvanceInsteedOfInter(context: context, onClose: onClose);
    // return;
    if (usingAdNetwork == AdNetwork.appLovin) {
      final adUnitId = AppConfigManager.share
          .stringValueForKey(AppConfigKey.adid_applovin_inter);
      // du khoang cach show va khong la pro
      final isAvaiableToShowAppLovin = AdsManager.avaiableToShowAppLovin(
          appLovinType: AppLovinType.interstitial);
      if (!isAvaiableToShowAppLovin) {
        onClose(null);
        return;
      } else {
        final didShowNative = _checkShowNativeAdvanceInsteedOfInter(
            context: context, onClose: onClose);
        if (didShowNative) {
          return;
        }
      }
      if (!AdsManager.instance.isMaxInit) {
        onClose(null);
        return;
      }
      // da co app san
      if (adUnitId.isNotEmpty) {
        final isAppLovinReady =
            await AppLovinMAX.isInterstitialReady(adUnitId) ?? false;
        if (isAppLovinReady) {
          GetIt.I<AppCubit>().setTimeShowAdsmobFull(
              DateTime.now().millisecondsSinceEpoch ~/ 1000);
          final countNumberAdDidShowInCurrentSession =
              GetIt.I<AppCubit>().getAdMaxTimePerSession();
          GetIt.I<AppCubit>()
              .setAdMaxTimePerSession(countNumberAdDidShowInCurrentSession + 1);
          callBackAdShown = onClose;
          _setTimeShowInter();
          _setCountShowInterInSession();
          AppLovinMAX.showInterstitial(adUnitId);
          return;
        }
      }
    }

    if (admobInter == null) {
      isLoadingAd = false;
      onClose(null);
      return;
    }
    // du khoang cach show va khong la pro
    final isAvaiableToShowAdmob =
        AdsManager.avaialbeToShowAdmob(admobType: AdmobType.interstitial);
    if (!isAvaiableToShowAdmob) {
      onClose(null);
      return;
    } else {
      // ignore: use_build_context_synchronously
      final didShowNative = _checkShowNativeAdvanceInsteedOfInter(
        context: context,
        onClose: onClose,
      );
      if (didShowNative) {
        return;
      }
    }

    final ad = admobInter!;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        admobInter = null;
        onClose(null);
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        admobInter = null;
        onClose(null);
        ad.dispose();
      },
      onAdClicked: (ad) {
        AdsManager.recordAdClick(
          adType: AdmobType.interstitial.name,
          adUnitId: ad.adUnitId,
          adNetwork: AdNetwork.admob.name,
          screenName: LogEventAndScreen.share.lastLogScreen,
          adSource: ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
        );
      },
    );
    try {
      _setTimeShowInter();
      AdmobFull.getInstance().admobInter?.show().then((value) {
        _setCountShowInterInSession();
      }).catchError((error) {
        onClose(null);
      });
    } catch (e) {
      onClose(null);
    }
  }

  void _setTimeShowInter() {
    GetIt.I<AppCubit>()
        .setTimeShowAdsmobFull(DateTime.now().millisecondsSinceEpoch ~/ 1000);
  }

  void _setCountShowInterInSession() {
    final countNumberAdDidShowInCurrentSession =
        GetIt.I<AppCubit>().getAdMaxTimePerSession();
    GetIt.I<AppCubit>()
        .setAdMaxTimePerSession(countNumberAdDidShowInCurrentSession + 1);
  }

  bool _checkShowNativeAdvanceInsteedOfInter(
      {required Function(String? msgReturn) onClose,
      required BuildContext context}) {
    final percentShowNative1 = AppConfigManager.share
        .doubleValueForKey(AppConfigKey.percent_show_native_insteed_of_inter);

    if (Random().nextInt(101) <= percentShowNative1) {
      // TODO: nhieu luc khong push duoc
      try {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          _setTimeShowInter();
          _setCountShowInterInSession();

          return CustomAdsInsteedInterstitial(
            callbackToClose: (muaPro) {
              Navigator.pop(context);
              if (muaPro) {
                onClose('need vao mua dich vu');
              } else {
                onClose(null);
              }
            },
          );
        }));
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  bool didSetListenerAppLovin = false;
  Future<void> loadInterstitialAd({
    required Duration delay,
    bool fromInitApp = false,
    bool canRollBackNetwork = true,
  }) async {
    if (!didSetListenerAppLovin) {
      _setAppLovinInterListener();
    }

    // Neu dang load hoac kq load lan trc oke => khong load nua
    final kqLoadLanTruoc = await hasAdAvaiableToShow();
    if (kqLoadLanTruoc) {
      return;
    }
    if (isLoadingAd) {
      if (lastRequestAd == null ||
          lastRequestAd!
              .add(const Duration(seconds: 30))
              .isBefore(DateTime.now())) {
        return;
      }
    }

    if (fromInitApp == true) {
      if (AppConfigManager.share.stringValueForKey(
              AppConfigKey.interstitial_ad_load_when_app_open) !=
          '1') {
        return;
      }
    }

    final adSourceInter = AppConfigManager.share
        .stringValueForKey(AppConfigKey.ad_source_interstitial)
        .split('#');
    listAdNetwork = [];
    for (var adNetworkName in adSourceInter) {
      if (adNetworkName == 'admob') {
        listAdNetwork.add(AdNetwork.admob);
      } else if (adNetworkName == 'applovin') {
        listAdNetwork.add(AdNetwork.appLovin);
      }
    }
    if (listAdNetwork.isEmpty) {
      listAdNetwork
          .add(Random().nextBool() ? AdNetwork.admob : AdNetwork.appLovin);
    }
    _selectAdNetwork(canRollback: true);
  }

  void _selectAdNetwork({required bool canRollback}) {
    if (usingAdNetwork == null) {
      usingAdNetwork = listAdNetwork.first;
    } else {
      for (var i = 0; i < listAdNetwork.length; i++) {
        if (listAdNetwork[i] == usingAdNetwork) {
          if (i < listAdNetwork.length - 1) {
            usingAdNetwork = listAdNetwork[i + 1];
          } else {
            if (canRollback) {
              usingAdNetwork = listAdNetwork.first;
            } else {
              return;
            }
          }
        }
      }
    }
    if (usingAdNetwork == AdNetwork.appLovin) {
      _loadAppLovin();
    } else {
      _loadAdmob();
    }
  }

  void _setAppLovinInterListener() {
    if (!AdsManager.instance.isMaxInit) {
      return;
    }
    didSetListenerAppLovin = true;
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialReady(_interstitial_ad_unit_id) will now return 'true'
        debugPrint('Interstitial ad loaded from ' + ad.networkName);
        isLoadingAd = false;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        isLoadingAd = false;
      },
      onAdDisplayedCallback: (ad) {
        debugPrint('AppLovin displayed');
      },
      onAdDisplayFailedCallback: (ad, error) {
        if (callBackAdShown != null) {
          callBackAdShown!(null);
        }
      },
      onAdClickedCallback: (ad) {
        debugPrint('AppLovin clicked');
      },
      onAdHiddenCallback: (ad) {
        debugPrint('AppLovin hidden');
        if (callBackAdShown != null) {
          callBackAdShown!(null);
        }
      },
    ));
  }

  void _loadAppLovin() {
    final adUnitId =
        AdsManager.getAppLovinKey(appLovinType: AppLovinType.interstitial);
    if (adUnitId == '') {
      // chon mang khac de load
      _selectAdNetwork(canRollback: false);
      return;
    }
    if (AdsManager.instance.isMaxInit) {
      isLoadingAd = true;
      lastRequestAd = DateTime.now();
      AppLovinMAX.loadInterstitial(adUnitId);
    } else {
      debugPrint('Max chua init nen chua load');
      AdsManager.instance.initMaxStream.listen((event) {
        debugPrint('did received max init');
        isLoadingAd = true;
        lastRequestAd = DateTime.now();
        AppLovinMAX.loadInterstitial(adUnitId);
      });
    }

    // AdsManager.instance.ensuredMaxInit().then((value) {
    //   isLoadingAd = true;
    //   lastRequestAd = DateTime.now();
    //   AppLovinMAX.loadInterstitial(adUnitId);
    // });
  }

  void _loadAdmob() {
    final adUnitId = AdsManager.getAdmobKey(admobType: AdmobType.interstitial);
    if (adUnitId == '') {
      // chon mang khac de load
      _selectAdNetwork(canRollback: false);
      return;
    }
    lastRequestAd = DateTime.now();
    isLoadingAd = true;
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            isLoadingAd = false;
            admobInter = ad;
            // adsFull?.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            isLoadingAd = false;
            admobInter = null;
            debugPrint('failed load admob full');
            _selectAdNetwork(canRollback: false);
          },
        ));
  }

  bool avaiableToShowAdmobInterstitial() {
    if (AdsManager.avaialbeToShowAdmob(admobType: AdmobType.interstitial) ==
        false) {
      return false;
    }
    final appCubit = GetIt.I<AppCubit>();
    final rangeTime = AppConfigManager.share
        .doubleValueForKey(AppConfigKey.lv_ad_interstitial_gap_time);
    if ((appCubit.getTimeShowAdsmobFull() ?? 0) <
        (DateTime.now().millisecondsSinceEpoch / 1000) - rangeTime) {
      return true;
    }
    return false;
  }
}
