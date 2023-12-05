
import 'package:lichviet_flutter_base/data/model/config_model.dart';

abstract class ApiConfigRepository {
  Future<Map<String, dynamic> > getPublicKey();
  Future<ConfigModel> getConfigList();
}
