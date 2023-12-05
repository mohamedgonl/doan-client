import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_mediate_banner_repo.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/enums.dart';

import 'ads_manager.dart';

class AdmobInlineBannerWidget extends StatefulWidget {
  const AdmobInlineBannerWidget({
    super.key,
    required this.widthWidget,
    required this.onLoadFinishErrIfHas,
    required this.currentScreenName,
    required this.showPlaceholderWhenLoading,
  });
  final int widthWidget;
  final Function(String? loadErr) onLoadFinishErrIfHas;
  final String currentScreenName;
  final bool showPlaceholderWhenLoading;
  @override
  State<AdmobInlineBannerWidget> createState() =>
      _AdmobInlineBannerWidgetState();
}

class _AdmobInlineBannerWidgetState extends State<AdmobInlineBannerWidget> {
  BannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  int heightWidget = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    heightWidget = (widget.widthWidget / 300 * 250).truncate() + 1;
    _loadAd();
  }

  void _loadAd() async {
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });
    // Get an inline adaptive size for the current orientation.
    AdSize? size =
        AdSize.getInlineAdaptiveBannerAdSize(widget.widthWidget, heightWidget);
    final adUnitId = AppConfigManager.share
        .stringValueForKey(AppConfigKey.adid_admob_banner_inline);
    if (adUnitId == '') {
      widget.onLoadFinishErrIfHas('no adunit id');
      return;
    }

    _inlineAdaptiveAd = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) async {
          debugPrint('Inline adaptive banner loaded: ${ad.responseInfo}');

          // After the ad is loaded, get the platform ad size and use it to
          // update the height of the container. This is necessary because the
          // height can change after the ad is loaded.
          BannerAd bannerAd = (ad as BannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            debugPrint(
                'Error: getPlatformAdSize() returned null for $bannerAd');
            widget.onLoadFinishErrIfHas('size bang 0');
            return;
          }

          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Inline adaptive banner failedToLoad: $error');
          widget.onLoadFinishErrIfHas('Khong load duoc ads');
          ad.dispose();
        },
        onAdClicked: (ad) {
          AdsManager.recordAdClick(
            adType: AdmobType.inlineBanner.name,
            adUnitId: ad.adUnitId,
            adNetwork: AdNetwork.admob.name,
            screenName: widget.currentScreenName,
            adSource: ad.responseInfo?.mediationAdapterClassName ?? 'un_know',
          );
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
  }

  /// Gets a widget containing the ad, if one is loaded.
  ///
  /// Returns an empty container if no ad is loaded, or the orientation
  /// has changed. Also loads a new ad if the orientation changes.
  Widget _getAdWidget() {
    if (_inlineAdaptiveAd != null && _isLoaded && _adSize != null) {
      return Column(
        children: [
          Align(
              child: Container(
            width: widget.widthWidget.toDouble(),
            height: _adSize?.height.toDouble() ??
                (widget.showPlaceholderWhenLoading
                    ? heightWidget.toDouble()
                    : 0),
            decoration: BoxDecoration(
              borderRadius: null,
              border: Border.all(
                color: const Color(0xfffcdd23),
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: AdWidget(
              ad: _inlineAdaptiveAd!,
            ),
          )),
          const SizedBox(
            height: 16,
          ),
        ],
      );
    }
    if (widget.showPlaceholderWhenLoading) {
      return Align(
          child: Container(
        width: widget.widthWidget.toDouble(),
        height: _adSize!.height.toDouble(),
        decoration: BoxDecoration(
          borderRadius: null,
          border: Border.all(
            color: const Color(0xfffcdd23),
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: const Text('Đang tải quảng cáo'),
      ));
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getAdWidget();
  }
}
