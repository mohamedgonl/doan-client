import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lichviet_flutter_base/cubit/cache_version_cubit/cache_version_cubit.dart';
import 'package:lichviet_flutter_base/cubit/global_cubit/app_cubit/app_cubit.dart';

import 'app_open_ad_manager.dart';

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges(Function() checkUpgrade) {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state, checkUpgrade));
  }

  void _onAppStateChanged(AppState appState, Function() checkUpgrade) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
      checkUpgrade();
      GetIt.I<CacheVersionCubit>().getVersionApi();
      GetIt.I<AppCubit>().getConfigListRemote();
    }
  }
}
