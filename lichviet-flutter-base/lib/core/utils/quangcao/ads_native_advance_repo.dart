import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_mediate_banner_repo.dart';
import '../../../cubit/user_cubit/user_cubit.dart';

class AdsNativeAdvanceRepo {
  AdsNativeAdvanceRepo._();
  static final share = AdsNativeAdvanceRepo._();
  AdsBannerObjectInfo? loadingBannerAd;
  Function(AdsBannerObjectInfo?)? didLoadBannerAdsSuccess;
  List<AdsBannerObjectInfo> listAnchoredbanner = [];

  AdsBannerObjectInfo? loadingInlineBannerAd;
  Function(AdsBannerObjectInfo?)? didLoadInlineAdsSuccess;
  List<AdsBannerObjectInfo> listInlineBanner = [];

  AdsNativeObjectInfo? loadingNativeAd;
  Function(AdsNativeObjectInfo?)? didLoadNativeAdsSuccess;
  List<AdsNativeObjectInfo> listNative = [];

  final userCubit = GetIt.I<UserCubit>();

  // void getAnchoredBanner({
  //   required AdSize adSize,
  //   Function(AdsBannerObjectInfo?)? callbackWhenSuccess,
  // }) {
  //   //1. Neu la pro thi k load
  //   if (UserUtils.checkAllPro(userCubit.state.userInfo)) {
  //     return;
  //   }
  //   didLoadBannerAdsSuccess = callbackWhenSuccess;
  //   List<AdsBannerObjectInfo> listToRemove = [];
  //   bool needLoadNew = true;
  //   for (var adBanner in listAnchoredbanner) {
  //     if (adBanner.showingInScreen == null) {
  //       final maxTimeToRefresh = Duration(
  //           seconds: max(
  //               60,
  //               AppConfigManager.share
  //                   .doubleValueForKey(
  //                       AppConfigKey.banner_ad_auto_refresh_in_seconds)
  //                   .toInt()));

  //       if (DateTime.now()
  //           .subtract(maxTimeToRefresh)
  //           .isAfter(adBanner.initTime ?? DateTime.now())) {
  //         listToRemove.add(adBanner);
  //       } else {
  //         if (didLoadBannerAdsSuccess != null) {
  //           didLoadBannerAdsSuccess!(adBanner);
  //         }
  //         needLoadNew = false;
  //         return;
  //       }
  //     }
  //   }
  //   for (var adToRemove in listToRemove) {
  //     listAnchoredbanner.remove(adToRemove);
  //   }
  //   // Neu khong co thang nao
  //   if (needLoadNew) {
  //     _loadAnchoredBanner(adSize: adSize);
  //   }
  // }

  // void getInlineBannerAd({
  //   required AdSize adSize,
  //   Function(AdsBannerObjectInfo?)? callbackWhenSuccess,
  // }) {
  //   //1. Neu la pro thi k load
  //   if (UserUtils.checkAllPro(userCubit.state.userInfo)) {
  //     return;
  //   }
  //   didLoadInlineAdsSuccess = callbackWhenSuccess;
  //   List<AdsBannerObjectInfo> listToRemove = [];
  //   bool needLoadNewInline = true;
  //   for (var inlineBanner in listInlineBanner) {
  //     if (inlineBanner.showingInScreen == null) {
  //       final maxTimeToRefresh = Duration(
  //           seconds: max(
  //               60,
  //               AppConfigManager.share
  //                   .doubleValueForKey(
  //                       AppConfigKey.banner_ad_auto_refresh_in_seconds)
  //                   .toInt()));

  //       if (DateTime.now()
  //           .subtract(maxTimeToRefresh)
  //           .isAfter(inlineBanner.initTime ?? DateTime.now())) {
  //         listToRemove.add(inlineBanner);
  //       } else {
  //         if (inlineBanner.initLoadAdSize?.width == adSize.width &&
  //             inlineBanner.initLoadAdSize?.height == adSize.height) {
  //           if (didLoadInlineAdsSuccess != null) {
  //             didLoadInlineAdsSuccess!(inlineBanner);
  //           }
  //           needLoadNewInline = false;
  //           return;
  //         }
  //       }
  //     }
  //   }
  //   for (var adToRemove in listToRemove) {
  //     listInlineBanner.remove(adToRemove);
  //   }
  //   if (needLoadNewInline) {
  //     _loadInlineBanner(adSize: adSize);
  //   }
  // }

  void getNativeAdvanceAd(
      {Function(AdsNativeObjectInfo?)? callbackWhenSuccess}) {
    //1. Neu la pro thi k load
    if (UserUtils.checkAllPro(userCubit.state.userInfo)) {
      return;
    }
    var didLoadNativeAdsSuccess = callbackWhenSuccess;
    for (var nativeAdObj in listNative) {
      if (nativeAdObj.showingInScreen == null) {
        if (didLoadNativeAdsSuccess != null) {
          nativeAdObj.showingInScreen = 'not_set';
          didLoadNativeAdsSuccess(nativeAdObj);
          didLoadNativeAdsSuccess = null;
        }
      }
    }
    // Check xem neu khong con thang native nao dang free thi load de cache
    for (var nativeAdObj in listNative) {
      if (nativeAdObj.showingInScreen.isNullOrEmpty) {
        return;
      }
    }
    AdsNativeAdvanceRepo._loadNativeAd(
        callbackWhenSuccess: didLoadNativeAdsSuccess);
  }

  static void _loadNativeAd(
      {Function(AdsNativeObjectInfo?)? callbackWhenSuccess}) {
    final adUnitId = AdsManager.getAdmobKey(admobType: AdmobType.nativeAds);
    debugPrint('chay vao load qc native ne: $adUnitId');
    if (adUnitId == '') {
      return;
    }
    final loadingNativeAd = AdsNativeObjectInfo();
    loadingNativeAd.nativeAd = NativeAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('$NativeAd loaded.');
          if (callbackWhenSuccess != null) {
            callbackWhenSuccess(loadingNativeAd);
          } else {
            AdsNativeAdvanceRepo.share.listNative.add(loadingNativeAd);
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('$NativeAd failedToLoad: $error');
          ad.dispose();
          if (callbackWhenSuccess != null) {
            callbackWhenSuccess(null);
          }
        },
        onAdOpened: (Ad ad) => debugPrint('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => debugPrint('$NativeAd onAdClosed.'),
        onAdClicked: (ad) {
          for (var adNative in AdsNativeAdvanceRepo.share.listNative) {
            if (adNative.nativeAd.hashCode == ad.hashCode) {
              AdsManager.recordAdClick(
                adType: AdmobType.nativeAds.name,
                adUnitId: ad.adUnitId,
                adNetwork: AdNetwork.admob.name,
                screenName: adNative.showingInScreen ?? 'un_know',
                adSource:
                    ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
              );
              AdsNativeAdvanceRepo.share
                  .removeNativeAdCache(adsNativeObjectInfo: adNative);
              return;
            }
          }
          AdsManager.recordAdClick(
            adType: AdmobType.nativeAds.name,
            adUnitId: ad.adUnitId,
            adNetwork: AdNetwork.admob.name,
            screenName: 'un_know',
            adSource: ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
          );
        },
      ),
    )..load();
    return;
  }

  // Future<void> _loadNativeAdvance() async {
  //   final adUnitId = AdsManager.getAdmobKey(admobType: AdmobType.nativeAds);
  //   debugPrint('chay vao load qc native ne: $adUnitId');
  //   if (adUnitId == '') {
  //     return;
  //   }
  //   loadingNativeAd = AdsNativeObjectInfo();
  //   loadingNativeAd?.nativeAd = NativeAd(
  //     adUnitId: adUnitId,
  //     request: const AdRequest(),
  //     factoryId: 'adFactoryExample',
  //     listener: NativeAdListener(
  //       onAdLoaded: (Ad ad) {
  //         debugPrint('$NativeAd loaded.');
  //         if (loadingNativeAd != null) {
  //           listNative.add(loadingNativeAd!);
  //         }
  //         loadingNativeAd = null;
  //         if (didLoadNativeAdsSuccess != null) {
  //           getNativeAdvanceAd(callbackWhenSuccess: didLoadNativeAdsSuccess);
  //         }
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         debugPrint('$NativeAd failedToLoad: $error');
  //         ad.dispose();
  //         loadingNativeAd = null;
  //         if (didLoadNativeAdsSuccess != null) {
  //           didLoadNativeAdsSuccess!(null);
  //         }
  //       },
  //       onAdOpened: (Ad ad) => debugPrint('$NativeAd onAdOpened.'),
  //       onAdClosed: (Ad ad) => debugPrint('$NativeAd onAdClosed.'),
  //       onAdClicked: (ad) {
  //         for (var adNative in listNative) {
  //           if (adNative.nativeAd.hashCode == ad.hashCode) {
  //             AdsManager.recordAdClick(
  //               admobType: AdmobType.nativeAds,
  //               adUnitId: ad.adUnitId,
  //               screenName: adNative.showingInScreen ?? 'un_know',
  //               adSource:
  //                   ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
  //             );
  //             listNative.remove(adNative);
  //             return;
  //           }
  //         }
  //         AdsManager.recordAdClick(
  //           admobType: AdmobType.nativeAds,
  //           adUnitId: ad.adUnitId,
  //           screenName: 'un_know',
  //           adSource: ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
  //         );
  //       },
  //     ),
  //   )..load();
  //   return;
  // }

  Future<void> removeNativeAdCache(
      {required AdsNativeObjectInfo adsNativeObjectInfo}) async {
    for (var nativeAdvance in listNative) {
      if (nativeAdvance.nativeAd.hashCode ==
          adsNativeObjectInfo.nativeAd.hashCode) {
        nativeAdvance.nativeAd?.dispose();
        listNative.remove(nativeAdvance);
      }
    }
    return;
  }

  // Future<void> _loadInlineBanner({required AdSize adSize}) async {
  //   final adUnitId = AdsManager.getAdmobKey(admobType: AdmobType.inlineBanner);
  //   debugPrint('chay vao load qc banner ne: $adUnitId');
  //   if (adUnitId == '') {
  //     return;
  //   }
  //   loadingInlineBannerAd = AdsBannerObjectInfo();
  //   loadingInlineBannerAd!.bannerAd = BannerAd(
  //     adUnitId: adUnitId,
  //     size: adSize,
  //     request: const AdRequest(),
  //     listener: BannerAdListener(
  //       onAdLoaded: (ad) async {
  //         loadingInlineBannerAd = AdsBannerObjectInfo();
  //         debugPrint('Banner inline loaded: ${ad.responseInfo}');
  //         loadingInlineBannerAd!.bannerAd = ad as BannerAd;
  //         loadingInlineBannerAd!.initLoadAdSize = adSize;
  //         loadingInlineBannerAd!.initTime = DateTime.now();
  //         final currentAdSize = await (ad as BannerAd).getPlatformAdSize();
  //         if (currentAdSize?.height == 0) {
  //           loadingInlineBannerAd = null;
  //           ad.dispose();
  //         } else {
  //           loadingInlineBannerAd?.loadedAdSize = currentAdSize;
  //           listInlineBanner.add(loadingInlineBannerAd!);
  //         }
  //         if (didLoadInlineAdsSuccess != null) {
  //           didLoadInlineAdsSuccess!(loadingInlineBannerAd);
  //           didLoadInlineAdsSuccess = null;
  //         }
  //         loadingInlineBannerAd = null;
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         debugPrint('Banner inline failedToLoad: $error');
  //         // for (var adBannerObj in listInlineBanner) {
  //         //   if (adBannerObj.bannerAd.hashCode == ad.hashCode) {
  //         //     listInlineBanner.remove(adBannerObj);
  //         //   }
  //         // }
  //         // ad.dispose();
  //         loadingInlineBannerAd = null;
  //         if (didLoadInlineAdsSuccess != null) {
  //           didLoadInlineAdsSuccess!(null);
  //         }
  //       },
  //       onAdClicked: (ad) {
  //         for (var adBannerObj in listInlineBanner) {
  //           if (adBannerObj.bannerAd.hashCode == ad.hashCode) {
  //             AdsManager.recordAdClick(
  //               admobType: AdmobType.inlineBanner,
  //               adUnitId: ad.adUnitId,
  //               screenName: adBannerObj.showingInScreen ?? 'un_know',
  //               adSource:
  //                   ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
  //             );
  //             return;
  //           }
  //         }
  //         AdsManager.recordAdClick(
  //           admobType: AdmobType.inlineBanner,
  //           adUnitId: ad.adUnitId,
  //           screenName: 'un_know',
  //           adSource: ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
  //         );
  //       },
  //     ),
  //   );
  //   return (loadingInlineBannerAd!.bannerAd as BannerAd).load();
  // }

//   Future<void> _loadAnchoredBanner({required AdSize adSize}) async {
//     final adUnitId =
//         AdsManager.getAdmobKey(admobType: AdmobType.anchoredAdaptiveBanner);
//     debugPrint('chay vao load qc banner ne: $adUnitId');
//     if (adUnitId == '') {
//       return;
//     }
//     loadingBannerAd = AdsBannerObjectInfo();
//     loadingBannerAd!.bannerAd = BannerAd(
//       adUnitId: adUnitId,
//       size: adSize,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (ad) async {
//           debugPrint('$ad loaded: ${ad.responseInfo}');
//           loadingBannerAd = AdsBannerObjectInfo();
//           loadingBannerAd!.bannerAd = ad as BannerAd;
//           loadingBannerAd!.initTime = DateTime.now();
//           loadingBannerAd!.initLoadAdSize = adSize;
//           final currentAdSize = await ad.getPlatformAdSize();
//           if (currentAdSize?.height == 0) {
//             loadingBannerAd = null;
//             ad.dispose();
//           }
//           loadingBannerAd?.loadedAdSize = currentAdSize;
//           listAnchoredbanner.add(loadingBannerAd!);
//           if (didLoadBannerAdsSuccess != null) {
//             didLoadBannerAdsSuccess!(loadingBannerAd!);
//           }
//           loadingBannerAd = null;
//         },
//         onAdFailedToLoad: (ad, error) {
//           debugPrint('inchored banner failedToLoad: $error');
//           // for (var adBannerObj in listAnchoredbanner) {
//           //   if (adBannerObj.bannerAd.hashCode == ad.hashCode) {
//           //     listAnchoredbanner.remove(adBannerObj);
//           //   }
//           // }
//           // ad.dispose();
//           loadingBannerAd = null;
//           if (didLoadBannerAdsSuccess != null) {
//             didLoadBannerAdsSuccess!(null);
//           }
//           didLoadBannerAdsSuccess = null;
//         },
//         onAdClicked: (ad) {
//           for (var adBannerObj in listAnchoredbanner) {
//             if (adBannerObj.bannerAd.hashCode == ad.hashCode) {
//               AdsManager.recordAdClick(
//                 admobType: AdmobType.anchoredAdaptiveBanner,
//                 adUnitId: ad.adUnitId,
//                 screenName: adBannerObj.showingInScreen ?? 'un_know',
//                 adSource:
//                     ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
//               );
//               return;
//             }
//           }
//           AdsManager.recordAdClick(
//             admobType: AdmobType.anchoredAdaptiveBanner,
//             adUnitId: ad.adUnitId,
//             screenName: 'un_know',
//             adSource: ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
//           );
//         },
//       ),
//     );
//     return (loadingBannerAd!.bannerAd as BannerAd).load();
//   }
}

class AdsBannerObjectInfo {
  String? showingInScreen;
  BannerAd? bannerAd;
  AdSize? initLoadAdSize;
  AdsBannerObjectInfo([this.bannerAd, this.initLoadAdSize]);
  AdSize? loadedAdSize;
  DateTime? initTime;
}

class AdsNativeObjectInfo {
  String? showingInScreen;
  NativeAd? nativeAd;
  AdsNativeObjectInfo();
}
