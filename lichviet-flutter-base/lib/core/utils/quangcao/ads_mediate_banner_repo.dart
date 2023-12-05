import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/cubit/singleton_anchored_banner_cubit.dart';

/// Trả về banner widget để show
enum AdNetwork { admob, appLovin }

class BannerAnchored extends StatefulWidget {
  const BannerAnchored({super.key});
  @override
  State<BannerAnchored> createState() => _BannerAnchoredState();
}

class _BannerAnchoredState extends State<BannerAnchored> {
  BannerAd? _anchoredAdaptiveAd;

  bool adLoadSuccess = false;
  bool isLoadingAd = false;
  DateTime? lastRequestAd;
  late String bannerAdUnitId;
  AdNetwork? usingAdNetwork;
  late List<AdNetwork> listAdNetwork;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _loadAdIfNeed() {
    if (adLoadSuccess) {
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

    final adSourceBanner = AppConfigManager.share
        .stringValueForKey(AppConfigKey.ad_source_banner)
        .split('#');
    listAdNetwork = [];
    for (var adNetworkName in adSourceBanner) {
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
    AdNetwork? selectUsingAdNetwork = usingAdNetwork;
    if (selectUsingAdNetwork == null) {
      selectUsingAdNetwork = listAdNetwork.first;
    } else {
      for (var i = 0; i < listAdNetwork.length; i++) {
        if (listAdNetwork[i] == selectUsingAdNetwork) {
          if (i < listAdNetwork.length - 1) {
            selectUsingAdNetwork = listAdNetwork[i + 1];
          } else {
            if (canRollback) {
              selectUsingAdNetwork = listAdNetwork.first;
            } else {
              return;
            }
          }
        }
      }
    }

    if (selectUsingAdNetwork! == AdNetwork.appLovin) {
      _loadAppLovin();
    } else {
      _loadAdmob();
    }
  }

  void _loadAppLovin() {
    bannerAdUnitId =
        AdsManager.getAppLovinKey(appLovinType: AppLovinType.banner);
    if (bannerAdUnitId == '') {
      _selectAdNetwork(canRollback: false);
      return;
    }
    // bannerAdUnitId = "thu sai cai"; Applovin banner adUnit sai khong tra ve loi
    adLoadSuccess = false;
    isLoadingAd = true;
    lastRequestAd = DateTime.now();
    if (AdsManager.instance.isMaxInit) {
      AppLovinMAX.setBannerExtraParameter(
          bannerAdUnitId, "adaptive_banner", "false");
      setState(() {
        usingAdNetwork = AdNetwork.appLovin;
      });
    } else {
      usingAdNetwork = null;
      debugPrint('Max chua init nen chua load');
      AdsManager.instance.initMaxStream.listen((event) {
        debugPrint('did received max init');
        if (mounted) {
          AppLovinMAX.setBannerExtraParameter(
              bannerAdUnitId, "adaptive_banner", "false");
          setState(() {
            usingAdNetwork = AdNetwork.appLovin;
          });
        }
      });
      // AdsManager.instance.ensuredMaxInit().then((value) {
      //   if (mounted) {
      //     setState(() {
      //       usingAdNetwork = AdNetwork.appLovin;
      //     });
      //   }
      // });
    }
  }

  Future<void> _loadAdmob() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }
    final adUnitId =
        AdsManager.getAdmobKey(admobType: AdmobType.anchoredAdaptiveBanner);
    if (adUnitId.isEmpty) {
      _selectAdNetwork(canRollback: false);
      return;
    }
    isLoadingAd = true;
    lastRequestAd = DateTime.now();
    setState(() {
      usingAdNetwork = AdNetwork.admob;
    });
    _anchoredAdaptiveAd = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('$ad loaded: ${ad.responseInfo}');
          if (mounted) {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            isLoadingAd = false;
            adLoadSuccess = true;
            GetIt.I<SingletonAnchoredBannerCubit>().bannerLoad(
                true,
                _anchoredAdaptiveAd!.size.width.toDouble(),
                _anchoredAdaptiveAd!.size.height.toDouble());
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Anchored adaptive banner failedToLoad: $error');
          if (mounted) {
            ad.dispose();
            _anchoredAdaptiveAd = null;
            isLoadingAd = false;
            adLoadSuccess = false;
            _selectAdNetwork(canRollback: false);
            GetIt.I<SingletonAnchoredBannerCubit>().bannerLoad(false);
          }
        },
        onAdClicked: (ad) {
          AdsManager.recordAdClick(
            adType: AdmobType.anchoredAdaptiveBanner.name,
            adUnitId: ad.adUnitId,
            screenName: LogEventAndScreen.share.lastBannerShowingInScreen,
            adSource: ad.responseInfo?.mediationAdapterClassName ?? 'unknow',
            adNetwork: AdNetwork.admob.name,
          );
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingletonAnchoredBannerCubit,
        SingletonAnchoredBannerState>(
      builder: (context, state) {
        if (usingAdNetwork == null) {
          return const SizedBox();
        }
        switch (usingAdNetwork!) {
          case AdNetwork.admob:
            if (_anchoredAdaptiveAd != null) {
              return Visibility(
                visible: state.adIsShowing(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xfffcdd23),
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside),
                      ),
                      width: double.infinity,
                      height: state.height,
                      child: AdWidget(ad: _anchoredAdaptiveAd!),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          case AdNetwork.appLovin:
            if (AdsManager.instance.isMaxInit) {
              AppLovinMAX.setBannerExtraParameter(
                  bannerAdUnitId, "adaptive_banner", "false");
            }
            return Column(
              children: [
                Container(
                  height: state.adIsShowing() ? 50 : 0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: state.adIsShowing()
                        ? Border.all(
                            color: const Color(0xfffcdd23),
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignOutside)
                        : null,
                  ),
                  child: Visibility(
                    visible: state.showIfAvaiable,
                    child: MaxAdView(
                      adUnitId: bannerAdUnitId,
                      adFormat: AdFormat.banner,
                      customData: 'customData',
                      placement: 'bottom',
                      isAutoRefreshEnabled: state.showIfAvaiable,
                      listener: AdViewAdListener(onAdLoadedCallback: (ad) {
                        logStatus('Banner ad loaded from ${ad.networkName}');
                        adLoadSuccess = true;
                        isLoadingAd = false;
                        GetIt.I<SingletonAnchoredBannerCubit>()
                            .bannerLoad(true);
                        GetIt.I<SingletonAnchoredBannerCubit>()
                            .bannerLoad(true, 320, 50);
                      }, onAdLoadFailedCallback: (adUnitId, error) {
                        adLoadSuccess = false;
                        isLoadingAd = false;
                        _selectAdNetwork(canRollback: false);
                        GetIt.I<SingletonAnchoredBannerCubit>()
                            .bannerLoad(false);
                        logStatus(
                            'Banner ad failed to load with error code ${error.code} and message: ${error.message}');
                      }, onAdClickedCallback: (ad) {
                        AdsManager.recordAdClick(
                          adType: AppLovinType.banner.name,
                          adUnitId: ad.adUnitId,
                          screenName:
                              LogEventAndScreen.share.lastBannerShowingInScreen,
                          adSource: ad.networkName,
                          adNetwork: AdNetwork.appLovin.name,
                        );
                        logStatus('Banner ad clicked');
                      }, onAdExpandedCallback: (ad) {
                        logStatus('Banner ad expanded');
                      }, onAdCollapsedCallback: (ad) {
                        logStatus('Banner ad collapsed');
                      }, onAdRevenuePaidCallback: (ad) {
                        logStatus('Banner ad revenue paid: ${ad.revenue}');
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: state.adIsShowing()
                      ? MediaQuery.of(context).padding.bottom
                      : 0,
                ),
              ],
            );
        }
      },
      listener: (context, state) {
        if (!AdsManager.instance.isMaxInit) {
          return;
        }
        if (state.showIfAvaiable) {
          AppLovinMAX.startBannerAutoRefresh(AppConfigManager.share
              .stringValueForKey(AppConfigKey.adid_applovin_banner));
          _loadAdIfNeed();
        } else {
          AppLovinMAX.stopBannerAutoRefresh(AppConfigManager.share
              .stringValueForKey(AppConfigKey.adid_applovin_banner));
        }
      },
      listenWhen: (previous, current) {
        // Chi quan tam den an/ hien qc
        if (previous.showIfAvaiable != current.showIfAvaiable) {
          return true;
        } else {
          return false;
        }
      },
      buildWhen: (previous, current) {
        // Chi quan tam an/ hien qc
        if (previous.adIsShowing() != current.adIsShowing() ||
            previous.showIfAvaiable != current.showIfAvaiable) {
          return true;
        } else {
          return false;
        }
      },
    );
  }

  void logStatus(String status) {
    /// ignore: avoid_print
    debugPrint(status);
  }

  @override
  void dispose() {
    debugPrint('adbanner bi dispose ne');
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }
}
