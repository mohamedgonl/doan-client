import 'package:lichviet_flutter_base/core/api/api_handler.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/end_points.dart';
import 'package:lichviet_flutter_base/data/model/config_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class ApiConfigRemoteDataSource {
  Future<Map<String, dynamic>> getPublicKeyV2();
  Future<ConfigModel> getConfigList();
}

class ApiConfigRemoteDataSourceImpl implements ApiConfigRemoteDataSource {
  final ApiHandler _apiHandler;
  

  ApiConfigRemoteDataSourceImpl(this._apiHandler,);



  @override
  Future<ConfigModel> getConfigList() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final result = await _apiHandler.post(EndPoints.configList,
        body: {
          'app_id': packageInfo.packageName,
          'app_info': packageInfo.version
        },
        parser: (map) => map);
    return ConfigModel.fromJson(result['data']);
  }

  @override
  Future<Map<String, dynamic>> getPublicKeyV2() async {
    try {
      final result =
          await _apiHandler.post(EndPoints.configV2, parser: (map) => map);
      return result;
    } catch (_e) {
      return {};
    }
  }
}
