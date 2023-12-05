import 'package:lichviet_flutter_base/core/routing/base/route_path.dart';

class AppPageRouteBase extends NavRoute {
  AppPageRouteBase(
    String id, {
    required NavPageBuilder builder,
    dynamic data,
  }) : super(id, builder: builder, data: data);

}