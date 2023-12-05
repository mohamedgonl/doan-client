import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/utils/analytics/log_event_and_screen.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/ads_mediate_banner_repo.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/core/routing/base/route_path.dart';
import 'package:lichviet_flutter_base/widgets/admob_full.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/src/dropdown_alert.dart';
import 'package:lifecycle/lifecycle.dart';

abstract class NavigatorRouteDelegate<PathRoute extends NavRoute>
    extends RouterDelegate<PathRoute>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin,
        WidgetsBindingObserver {
  NavigatorRouteDelegate(PathRoute initialPath) {
    _route.add(initialPath);
  }

  @override
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey();

  final List<PathRoute> _route = [];
  // Completer<dynamic>? _resultCompleter;
  final List<Completer<dynamic>?> _resultListCompleter = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(pop()),
      child: Stack(children: [
        Navigator(
          key: navigatorKey,
          observers: [defaultLifecycleObserver],
          onPopPage: _onPopPage,
          pages: _getPages(context),
        ),
        const Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: BannerAnchored(),
        ),
        const DropdownAlert(),
      ]),
    );
  }

  List<Page> _getPages(BuildContext context) {
    return _route.map((route) => route.builder(context)).toList();
  }

  List<Page> getPages(BuildContext context) {
    return _route.map((route) => route.builder(context)).toList();
  }

  @override
  Future<void> setNewRoutePath(PathRoute configuration) async {}

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    return pop();
  }

  bool pop() {
    if (canPop()) {
      _route.removeLast();
      notifyListeners();
      debugPrint('on pop dinh show ads');
      // if (!UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo) &&
      //     AdmobFull.adsFull == null) {
      //   AdmobFull.admob = null;
      //   AdmobFull.getInstance().loadInterstitialAd(onClose: () {
      //     GetIt.I<AppCubit>().setTimeShowAdsmobFull(
      //         DateTime.now().millisecondsSinceEpoch ~/ 1000);
      //     GetIt.I<MethodChannel>()
      //         .invokeMethod(ChannelEndpoint.didShowAdsMobFull);
      //     pop();
      //     AdmobFull.admob = null;
      //   });
      // }
      _setCurrentScreen(_route.last);
      return true;
    }
    return false;
  }

  void removeScreen(String screenId, {dynamic value}) {
    if (_resultListCompleter.isNotEmpty && value != null) {
      _resultListCompleter.last?.complete(value);
      _resultListCompleter.removeLast();
    }
    _route.removeWhere((element) => element.id == screenId);
    notifyListeners();
  }

  bool canPop() {
    return _route.length > 1;
  }

  void pushTo(PathRoute path) {
    GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
        {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _route.add(path);
    _setCurrentScreen(path);
    notifyListeners();
    if (_route.length > 1) {
      AdmobFull.getInstance()
          .loadInterstitialAd(delay: const Duration(milliseconds: 300));
    }
  }

  void popAndPush(PathRoute path) {
    // if (canPop()) {
    //   _route.removeLast();
    // }
    GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
        {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _route.add(path);
    _route.removeAt(_route.length - 2);
    _setCurrentScreen(path);
    notifyListeners();
  }

  Future<dynamic> pushAndWaitForResult(PathRoute path) async {
    _resultListCompleter.add(Completer<dynamic>());
    // _resultCompleter = Completer<dynamic>();
    _route.add(path);

    GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
        {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _setCurrentScreen(path);
    notifyListeners();
    if (_route.length > 1) {
      AdmobFull.getInstance()
          .loadInterstitialAd(delay: const Duration(milliseconds: 300));
    }
    return _resultListCompleter.last?.future;
  }

  void popUntil(String pathId) {
    if (_route.any((element) => element.id == pathId)) {
      final path = _route.firstWhere((element) => element.id == pathId);
      final index = _route.indexOf(path);
      if (index != -1) {
        _route.removeRange(index + 1, _route.length);
        _setCurrentScreen(path);
        notifyListeners();
      }
    }
  }

  void popWithResult(dynamic value) {
    if (_resultListCompleter.isNotEmpty) {
      _resultListCompleter.last?.complete(value);
      _resultListCompleter.removeLast();
      _route.removeLast();
      _setCurrentScreen(_route.last);
      notifyListeners();
    } else {
      pop();
    }
  }

  void pushAndPopTo(PathRoute pushPath, PathRoute popToPath) {
    final index = _route.indexWhere((element) => element.id == popToPath.id);

    if (index >= 0) {
      _route.removeRange(index + 1, _route.length);
    }
    GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
        {'id': -1, 'name': popToPath.id, 'openNativeScreen': 0});
    _route.add(pushPath);
    notifyListeners();
  }

  void replaceLast(PathRoute path) {
    if (_route.isNotEmpty) {
      _route.removeLast();
    }
    GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
        {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _route.add(path);
    notifyListeners();
  }

  void clearAndPush(PathRoute path) {
    _route
      ..clear()
      ..add(path);
    GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
        {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _setCurrentScreen(path);
    notifyListeners();
  }

  void clearAndPushMulti(List<PathRoute> paths) {
    _route
      ..clear()
      ..addAll(paths);

    notifyListeners();
  }

  void pushToMulti(List<PathRoute> paths) {
    _route.addAll(paths);
    notifyListeners();
  }

  Future<void> _setCurrentScreen(PathRoute path) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    return LogEventAndScreen.share.setCurrentScreen(
      screenName: path.id,
      screenClassOverride: path.id,
    );
  }
}
