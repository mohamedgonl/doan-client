import 'package:lichviet_flutter_base/data/datasource/remote/cache_version_datasource.dart';
import 'package:lichviet_flutter_base/domain/repositories/cache_version_repository.dart';


class CacheVersionRepositoryImpl implements CacheVersionRepository {
  final CacheVersionRemoteDataSource _cacheVersionDataSource;

  CacheVersionRepositoryImpl(this._cacheVersionDataSource);

  @override
  Future<Map<String, dynamic>> getCacheVersionData() async {
    return _cacheVersionDataSource.getCacheVersionData();
  }
}
