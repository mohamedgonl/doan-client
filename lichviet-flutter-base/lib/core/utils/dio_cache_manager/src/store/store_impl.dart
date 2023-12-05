import 'package:lichviet_flutter_base/core/utils/dio_cache_manager/src/core/obj.dart';

abstract class ICacheStore {
  ICacheStore();

  Future<CacheObj?> getCacheObj(String key, {String? subKey});

  Future<bool> setCacheObj(CacheObj obj);

  Future<bool> delete(String key, {String? subKey});

  Future<bool> clearExpired();

  Future<bool> clearAll();
}
