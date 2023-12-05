import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/cubit/cubit.dart';

class AdmobBanner {
  static AdmobBanner? _admob;
  static AdmobBanner getInstance() {
    if (_admob != null) return _admob!;
    _admob = AdmobBanner();
    return _admob!;
  }

  bool isLoading = false;
  BannerAd? bannerAd;
  final adUnitId =
      AppConfigManager.share.stringValueForKey(AppConfigKey.adid_admob_banner);
  AdmobBanner();
  void loadBannerAdmob({required Function() onClose}) {
    if (UserUtils.checkLogin(GetIt.I<UserCubit>().state.userInfo) &&
            UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo) ||
        adUnitId == '') {
      return;
    }
    // Create the ad objects and load ads.
    // debugPrint(widget.adUnitId);
    bannerAd = BannerAd(
      size: AdSize.banner,
      request: const AdRequest(),
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => debugPrint('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => debugPrint('$BannerAd onAdClosed.'),
      ),
    )..load();
  }
}
