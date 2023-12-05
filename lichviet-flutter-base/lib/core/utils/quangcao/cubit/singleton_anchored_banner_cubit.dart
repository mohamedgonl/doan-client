import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/core/utils/user_utils.dart';
import 'package:lichviet_flutter_base/cubit/cubit.dart';

part 'singleton_anchored_banner_state.dart';

class SingletonAnchoredBannerCubit extends Cubit<SingletonAnchoredBannerState> {
  SingletonAnchoredBannerCubit()
      : super(SingletonAnchoredBannerState.initial());
  int numberScreenImplementBanner = 0;
  void showBanner({bool forceShow = false, String? showInScreenName}) {
    LogEventAndScreen.share.lastBannerShowingInScreen =
        showInScreenName ?? LogEventAndScreen.share.lastLogScreen;
    numberScreenImplementBanner += 1;
    _checkShowHideBanner();
  }

  void hideBanner({bool forceHide = false}) {
    numberScreenImplementBanner -= 1;
    if (forceHide) {
      numberScreenImplementBanner = 0;
    }
    if (numberScreenImplementBanner < 0) {
      numberScreenImplementBanner = 0;
    }
    _checkShowHideBanner();
  }

  void _checkShowHideBanner() {
    final isPro = UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo);
    final showIfAvaiable = numberScreenImplementBanner > 0 && !isPro;
    emit(state.stateChanged(showIfAvaiable: showIfAvaiable));
  }

  void bannerLoad(bool isSuccess, [double? newWidth, double? newHeight]) {
    emit(state.stateChanged(
      isAdAvaiable: isSuccess,
      height: newHeight,
      width: newWidth,
    ));
  }
}
