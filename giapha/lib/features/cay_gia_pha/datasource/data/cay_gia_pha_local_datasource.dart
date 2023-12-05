import 'dart:convert';

import 'package:giapha/core/exceptions/cache_exception.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:lichviet_flutter_base/data/datasource/local/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CayGiaPhaLocalDataSource {
  Future<List<List<Member>>> layCacheCayGiaPha(int indexStep);
  Future<void> cacheCayGiaPha(List<List<Member>> giaPhaCache,
      {required int indexStep});
  Future<void> clearCacheGiaPha();
  Future<void> saveLocalSearch(String userId, List<String> listTextSearch);
  List<String> getLocalSaveSearch(String userId);
}

class CayGiaPhaLocalDataSourceImpl implements CayGiaPhaLocalDataSource {
  final SharedPreferences sharedPreferences;

  CayGiaPhaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheCayGiaPha(List<List<Member>> cayGiaPhaCache,
      {required int indexStep}) {
    final cacheMap = cayGiaPhaCache
        .map((list) => jsonEncode(list.map((item) => item.toJson()).toList()))
        .toList();

    return sharedPreferences.setStringList(
        keyCayGiaPha + indexStep.toString(), cacheMap);
  }

  @override
  Future<List<List<Member>>> layCacheCayGiaPha(int indexStep) async {
    final List<String>? data =
        sharedPreferences.getStringList(keyCayGiaPha + indexStep.toString());
    if (data != null) {
      final list = data
          .map((list) => (jsonDecode(list) as List)
              .map((item) => Member.fromJson(item, saveCidPid: true))
              .toList())
          .toList();
      return list;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> clearCacheGiaPha() async {
    Set<String> keyCache = sharedPreferences.getKeys();
    for (var e in keyCache) {
      if (e.contains(keyCayGiaPha)) {
        await sharedPreferences.remove(e);
      }
    }
  }

  @override
  Future<void> saveLocalSearch(String userId, List<String> listTextSearch) {
    return sharedPreferences.setStringList(
        keyTimKiemTuDuong + userId, listTextSearch);
  }

  @override
  List<String> getLocalSaveSearch(String userId) {
    final List<String>? data =
        sharedPreferences.getStringList(keyTimKiemTuDuong + userId);
    return data ?? [];
  }
}
