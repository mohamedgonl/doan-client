import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/core/routing/app_routing_base.dart';
import 'package:lichviet_flutter_base/core/routing/base/app_navigator.dart';
import 'package:provider/provider.dart';

class AppNavigator extends NavigatorRouteDelegate<AppPageRouteBase>  {
  AppNavigator(AppPageRouteBase initialPath) : super(initialPath);

  factory AppNavigator.of(BuildContext context) =>
      Provider.of<AppNavigator>(context, listen: false);

  
}

extension AppNavigatorExtension  on BuildContext  {
  AppNavigator get navigator => AppNavigator.of(this);

  bool pop() => navigator.pop();

  void pushTo(AppPageRouteBase path) {
    debugPrint(path.id);
    navigator.pushTo(path);
  }

  void pushAndPopTo(AppPageRouteBase pushPath, AppPageRouteBase popToPath) =>
      navigator.pushAndPopTo(pushPath, popToPath);

  void replaceLast(AppPageRouteBase path) => navigator.replaceLast(path);
}
