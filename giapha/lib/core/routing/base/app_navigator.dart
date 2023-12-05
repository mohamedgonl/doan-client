part of routing.base;

abstract class NavigatorRouteDelegate<PathRoute extends NavRoute>
    extends RouterDelegate<PathRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
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
      child: Navigator(
        key: navigatorKey,
        onPopPage: _onPopPage,
        pages: _getPages(context),
      ),
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
      // if (!UserUtils.checkAllPro(GetIt.I<UserCubit>().state.userInfo)) {
      //   if (AdmobFull.admob == null) {
      //     AdmobFull.getInstance().createInterstitialAd(onClose: () {
      //       GetIt.I<AppCubit>().setTimeShowAdsmobFull(
      //           DateTime.now().millisecondsSinceEpoch ~/ 1000);
      //       pop();
      //       AdmobFull.admob = null;
      //     });
      //   }
      // }
      _setCurrentScreen(_route.last);
      return true;
    }
    return false;
  }

  bool canPop() {
    return _route.length > 1;
  }

  void pushTo(PathRoute path) {
    // GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
    //     {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _route.add(path);
    _setCurrentScreen(path);
    notifyListeners();
  }

  void popAndPush(PathRoute path) {
    if (canPop()) {
      _route.removeLast();
    }
    // GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
    //     {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _route.add(path);
    notifyListeners();
  }

  Future<dynamic> pushAndWaitForResult(PathRoute path) async {
    _resultListCompleter.add(Completer<dynamic>());
    // _resultCompleter = Completer<dynamic>();
    _route.add(path);

    // GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
    //     {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _setCurrentScreen(path);
    notifyListeners();
    return _resultListCompleter.last?.future;
  }

  void popUntil(String pathId) {
    if (_route.any((element) => element.id == pathId)) {
      final path = _route.firstWhere((element) => element.id == pathId);
      final index = _route.indexOf(path);
      if (index != -1) {
        _route.removeRange(index + 1, _route.length);
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
    }
  }

  void pushAndPopTo(PathRoute pushPath, PathRoute popToPath) {
    final index = _route.indexWhere((element) => element.id == popToPath.id);

    if (index >= 0) {
      _route.removeRange(index + 1, _route.length);
    }
    // GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
    //     {'id': -1, 'name': popToPath.id, 'openNativeScreen': 0});
    _route.add(pushPath);
    notifyListeners();
  }

  void replaceLast(PathRoute path) {
    if (_route.isNotEmpty) {
      _route.removeLast();
    }
    // GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
    //     {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    _route.add(path);
    notifyListeners();
  }

  void clearAndPush(PathRoute path) {
    _route
      ..clear()
      ..add(path);
    // GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.openNewScreen,
    //     {'id': -1, 'name': path.id, 'openNativeScreen': 0});
    // FirebaseAnalytics.instance.setCurrentScreen(screenName: null);
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

  Future<void> _setCurrentScreen(PathRoute path) async {
    //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // return analytics.setCurrentScreen(
    //   screenName: path.id,
    //   screenClassOverride: path.id,
    // );
  }
}
