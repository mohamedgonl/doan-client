import 'package:flutter/material.dart';

import 'app_routing.dart';

/// Converts browser location strings to [PageConfiguration], and vice-versa.
/// This leans on [PageConfiguration] to the actual parsing, so this is largely boilerplate.
///
class AppRouterInformationParser extends RouteInformationParser<AppPageRoute> {
  // @override
  // Future<AppPageRoute> parseRouteInformation(
  //     RouteInformation routeInformation) async {
  //   debugPrint('routeInformation ${routeInformation.runtimeType}');
  //   return AppPageRoute.accountInfoScreen();
  // }
}
