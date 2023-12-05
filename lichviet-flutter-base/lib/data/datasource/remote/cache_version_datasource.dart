import 'dart:collection';
import 'dart:convert';

import 'package:lichviet_flutter_base/core/api/api_handler.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheVersionRemoteDataSource {
  Future<Map<String, dynamic>> getCacheVersionData();
}

class CacheVersionDataSourceIplm implements CacheVersionRemoteDataSource {
  final ApiHandler _apiHandler;

  CacheVersionDataSourceIplm(this._apiHandler);

  @override
  Future<Map<String, dynamic>> getCacheVersionData() async {
    Map response = HashMap();
    try {
      await _apiHandler.post(EndPoints.getVersionData,
          parser: (Map<String, dynamic> json) {
        response = json;
      });
      return response['data'];
    } catch (_e) {
      return {};
    }
  }
}
