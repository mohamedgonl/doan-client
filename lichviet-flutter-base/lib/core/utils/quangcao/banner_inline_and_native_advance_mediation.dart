import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/admob_inline_banner.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_mediate_banner_repo.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_native_advance_repo.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/applovin_mrec_widget.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/quangcao.dart';
import 'package:lichviet_flutter_base/data/datasource/local/app_local_datasource.dart';

class BannerInlineAndNativeAdvanceMediation extends StatefulWidget {
  const BannerInlineAndNativeAdvanceMediation({
    super.key,
    required this.maxWidthAds,
    required this.showPlaceholderWhenLoading,
    this.callbackWhenloadErr,
  });
  final int maxWidthAds;
  final bool showPlaceholderWhenLoading;
  final Function(String errMsg)? callbackWhenloadErr;
  @override
  State<BannerInlineAndNativeAdvanceMediation> createState() =>
      _BannerInlineAndNativeAdvanceMediationState();
}

class _BannerInlineAndNativeAdvanceMediationState
    extends State<BannerInlineAndNativeAdvanceMediation> {
  AdsNativeObjectInfo? _nativeAd;
  AdNetwork? usingAdNetwork;
  bool showInlineBannerInsteedOfNative = false;
  int heightWidget = 0;
  List<AdNetwork> listAdNetwork = [];
  String? currentScreenName;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadAds();
  }

  void loadAds() {
    final adSourceBanner = AppConfigManager.share
        .stringValueForKey(AppConfigKey.ad_source_native)
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

  void adLoadError() {
    // Load loi roi, co the chuyen sang mang khac hoac feedback lai
    if (widget.showPlaceholderWhenLoading) {
      if (usingAdNetwork == AdNetwork.admob) {
        if (showInlineBannerInsteedOfNative == true) {
          showInlineBannerInsteedOfNative = false;
          _loadAdmob();
        }
      }
      _selectAdNetwork(canRollback: false);
    } else {
      if (usingAdNetwork == AdNetwork.admob) {
        if (showInlineBannerInsteedOfNative == true) {
          showInlineBannerInsteedOfNative = false;
          _loadAdmob();
        }
      } else if (widget.callbackWhenloadErr != null) {
        widget.callbackWhenloadErr!('no ads to show');
      }
    }
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
              // Khong mang nao load duoc quang cao
              if (widget.callbackWhenloadErr != null) {
                widget.callbackWhenloadErr!('no ads to show');
              }
              return;
            }
          }
        }
      }
    }
    heightWidget = (widget.maxWidthAds / 300 * 250).toInt() + 1;
    if (usingAdNetwork! == AdNetwork.appLovin) {
      _loadAppLovin();
    } else {
      showInlineBannerInsteedOfNative = showBannerInsteedOfNative();
      _loadAdmob();
    }
  }

  void _loadAppLovin() {
    if (AdsManager.instance.isMaxInit) {
      setState(() {
        usingAdNetwork = AdNetwork.appLovin;
      });
    } else {
      usingAdNetwork = null;
      debugPrint('Max chua init nen chua load');
      AdsManager.instance.initMaxStream.listen((event) {
        debugPrint('did received max init');
        if (mounted) {
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

  void _loadAdmob() {
    setState(() {});
    if (showInlineBannerInsteedOfNative) {
    } else {
      AdsNativeAdvanceRepo.share.getNativeAdvanceAd(
        callbackWhenSuccess: (nativeAd) {
          if (mounted) {
            if (nativeAd == null) {
              adLoadError();
              return;
            }
            setState(() {
              _nativeAd = nativeAd;
              _nativeAd?.showingInScreen =
                  LogEventAndScreen.share.lastLogScreen;
            });
          } else {
            if (nativeAd != null) {
              AdsNativeAdvanceRepo.share.listNative.add(nativeAd);
            }
          }
        },
      );
    }
    return;
  }

  bool showBannerInsteedOfNative() {
    if (Platform.isAndroid) {
      try {
        int sdkVersion = GetIt.I<AppLocalDatasource>().getSdkVersion;
        if (sdkVersion <= 28) {
          return false;
        }
      } catch (_) {}
    }
    if (AppConfigManager.share
            .stringValueForKey(AppConfigKey.replace_native_by_banner) ==
        '1') {
      return true;
    }
    final percentShowBanner = AppConfigManager.share.doubleValueForKey(
        AppConfigKey.show_rate_inline_banner_with_native_percent);
    final randomPercentBanner = Random().nextInt(101);
    if (randomPercentBanner <= percentShowBanner) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (usingAdNetwork == AdNetwork.admob) {
      // Truong hop show admob
      if (showInlineBannerInsteedOfNative == true) {
        // Truong hop show inlineBanner admob
        return AdmobInlineBannerWidget(
          widthWidget: widget.maxWidthAds,
          onLoadFinishErrIfHas: (errMsg) {
            if (errMsg == null) {
            } else {
              adLoadError();
            }
          },
          currentScreenName:
              currentScreenName ?? LogEventAndScreen.share.lastLogScreen,
          showPlaceholderWhenLoading: widget.showPlaceholderWhenLoading,
        );
      } else {
        // Truong hop show native admob
        if (_nativeAd?.nativeAd != null) {
          return Container(
            height: heightWidget.toDouble(),
            width: widget.maxWidthAds.toDouble(),
            decoration: BoxDecoration(
              borderRadius:
                  null, // isBanner ? null : BorderRadius.circular(8.r),
              border: Border.all(
                  color: const Color(0xfffcdd23),
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside),
            ),
            child: Align(child: AdWidget(ad: _nativeAd!.nativeAd!)),
          );
        } else {
          if (widget.showPlaceholderWhenLoading) {
            return Container(
              height: heightWidget.toDouble(),
              width: widget.maxWidthAds.toDouble(),
              decoration: BoxDecoration(
                borderRadius:
                    null, // isBanner ? null : BorderRadius.circular(8.r),
                border: Border.all(
                    color: const Color(0xfffcdd23),
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside),
              ),
              child: const Center(child: Text('Đang tải quảng cáo')),
            );
          } else {
            return const SizedBox();
          }
        }
      }
    } else if (usingAdNetwork == AdNetwork.appLovin) {
      return AppLovinMrecWidget(
        widthWidget: widget.maxWidthAds.toDouble(),
        onLoadFinishErrIfHas: (errMsg) {
          if (errMsg == null) {
          } else {
            adLoadError();
          }
        },
        currentScreenName:
            currentScreenName ?? LogEventAndScreen.share.lastLogScreen,
        showPlaceholderWhenLoading: widget.showPlaceholderWhenLoading,
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  void dispose() {
    if (_nativeAd != null) {
      AdsNativeAdvanceRepo.share
          .removeNativeAdCache(adsNativeObjectInfo: _nativeAd!);
    }
    _nativeAd = null;
    super.dispose();
  }
}
