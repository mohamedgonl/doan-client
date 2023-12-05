import 'package:lichviet_flutter_base/domain/repositories/cache_version_repository.dart';

class CacheVersionUseCase {
  final CacheVersionRepository _cacheVersionRepository;

  CacheVersionUseCase(this._cacheVersionRepository);

  Future<Map<String, dynamic>> getVersionCacheData() async{
    return await _cacheVersionRepository.getCacheVersionData();
  }


}
