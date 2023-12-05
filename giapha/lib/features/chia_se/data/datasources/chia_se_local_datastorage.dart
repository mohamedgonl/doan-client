import 'dart:convert';

import 'package:giapha/core/exceptions/cache_exception.dart';
import 'package:giapha/features/chia_se/data/models/person_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChiaSeLocalDataStorage {
  Future<List<PersonModel>> getPeopleShared();
  Future<void> cacheData(List<GiaPhaModel> giaPhaCache);
  Future<List<PersonModel>> getPersonFromDB();
}

const CACHED_GET_PEOPLE_SHARED = 'CACHED_GET_PEOPLE_SHARED';
// const CACHED_DANHSACH_USERS_DUOCCHIASE = 'CACHED_DANHSACH_USERS_DUOCCHIASE';

class ChiaSeLocalDataStorageImpl implements ChiaSeLocalDataStorage {
  final SharedPreferences sharedPreferences;

  ChiaSeLocalDataStorageImpl({required this.sharedPreferences});

  @override
  Future<void> cacheData(List<GiaPhaModel> giaPhaCache) {
    final cacheMap = giaPhaCache.map((e) => e.toJSON()).toList();
    final encodeString = jsonEncode(cacheMap);
    return sharedPreferences.setString(
        CACHED_GET_PEOPLE_SHARED, encodeString);
  }

  @override
  Future<List<PersonModel>> getPeopleShared() async {
    final String? data = sharedPreferences.getString(CACHED_GET_PEOPLE_SHARED);
    if (data != null) {
      return (jsonDecode(data) as List<dynamic>)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } else {
      throw CacheException();
    }
  }
  
  @override
  Future<List<PersonModel>> getPersonFromDB() {
    throw UnimplementedError();
  }

  
}
