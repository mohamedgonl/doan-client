import 'package:lichviet_flutter_base/data/model/config_model.dart';
import 'package:lichviet_flutter_base/domain/repositories/api_config_repository.dart';

class ApiConfigUsecases {
  final ApiConfigRepository _apiConfigRepository;

  ApiConfigUsecases(this._apiConfigRepository);

  Future<Map<String, dynamic>> getPublicKeyV2() async {
    // return 1650259801690;
    return await  _apiConfigRepository.getPublicKey();
  }

  Future<ConfigModel> getConfigList() async {
    return _apiConfigRepository.getConfigList();
  }
}
