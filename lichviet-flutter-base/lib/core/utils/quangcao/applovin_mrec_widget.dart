import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/widgets.dart';
import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_mediate_banner_repo.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/enums.dart';
import 'package:lifecycle/lifecycle.dart';

import 'ads_manager.dart';

class AppLovinMrecWidget extends StatefulWidget {
  final double widthWidget;
  const AppLovinMrecWidget(
      {super.key,
      required this.widthWidget,
      required this.onLoadFinishErrIfHas,
      required this.currentScreenName,
      required this.showPlaceholderWhenLoading});
  final Function(String? loadErr) onLoadFinishErrIfHas;
  final bool showPlaceholderWhenLoading;
  final String currentScreenName;
  @override
  State<AppLovinMrecWidget> createState() => _AppLovinMrecWidgetState();
}

class _AppLovinMrecWidgetState extends State<AppLovinMrecWidget>
    with LifecycleAware, LifecycleMixin {
  bool mrecLoadSuccess = false;
  bool isAutoRefresh = true;
  @override
  Widget build(BuildContext context) {
    final adUnitId = AppConfigManager.share
        .stringValueForKey(AppConfigKey.adid_applovin_mrec);
    if (adUnitId == '') {
      widget.onLoadFinishErrIfHas('no adUnitId');
      return const SizedBox();
    }
    final double heightAdsWhenLoading = widget.showPlaceholderWhenLoading
        ? widget.widthWidget / 300 * 250 + 1
        : 0;
    return Container(
      height: mrecLoadSuccess
          ? widget.widthWidget / 300 * 250 + 1
          : heightAdsWhenLoading,
      width: widget.widthWidget,
      decoration: BoxDecoration(
        borderRadius: null, // isBanner ? null : BorderRadius.circular(8.r),
        border: mrecLoadSuccess
            ? Border.all(
                color: const Color(0xfffcdd23),
                width: 1,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
            : null,
      ),
      child: MaxAdView(
          adUnitId: adUnitId,
          adFormat: AdFormat.mrec,
          customData: 'customData',
          placement: widget.currentScreenName,
          isAutoRefreshEnabled: isAutoRefresh,
          listener: AdViewAdListener(
              onAdLoadedCallback: (ad) {
                debugPrint('Mrec load success');
                setState(() {
                  mrecLoadSuccess = true;
                });
                widget.onLoadFinishErrIfHas(null);
              },
              onAdLoadFailedCallback: (adUnitId, error) {
                debugPrint('Mrec load failed');
                setState(() {
                  mrecLoadSuccess = false;
                });
                widget.onLoadFinishErrIfHas(error.toString());
              },
              onAdClickedCallback: (ad) {
                AdsManager.recordAdClick(
                  adType: AppLovinType.mRec.name,
                  adUnitId: ad.adUnitId,
                  screenName: widget.currentScreenName,
                  adSource: ad.networkName,
                  adNetwork: AdNetwork.appLovin.name,
                );
              },
              onAdExpandedCallback: (ad) {},
              onAdCollapsedCallback: (ad) {})),
    );
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    debugPrint('Mrec Event $event');
    if (event == LifecycleEvent.inactive) {
      debugPrint('Mrec invisible');
      if (mounted) {
        setState(() {
          isAutoRefresh = false;
        });
      }
    } else if (event == LifecycleEvent.active) {
      debugPrint('Mrec visible');
      if (mounted) {
        setState(() {
          isAutoRefresh = true;
        });
      }
    }
  }
}
