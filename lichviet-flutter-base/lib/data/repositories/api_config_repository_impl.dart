import 'package:lichviet_flutter_base/data/datasource/remote/api_config_remote_datasource.dart';
import 'package:lichviet_flutter_base/data/model/config_model.dart';
import 'package:lichviet_flutter_base/domain/repositories/api_config_repository.dart';

class ApiConfigRepositoryImpl implements ApiConfigRepository {
  final ApiConfigRemoteDataSource _apiConfigRemoteDataSource;

  ApiConfigRepositoryImpl(this._apiConfigRemoteDataSource);



  @override
  Future<ConfigModel> getConfigList() {
    return _apiConfigRemoteDataSource.getConfigList();
  }
  
  @override
  Future<Map<String, dynamic>> getPublicKey() async{
  return _apiConfigRemoteDataSource.getPublicKeyV2();
  }
}
