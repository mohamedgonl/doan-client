import 'dart:convert';

import 'package:lichviet_flutter_base/core/utils/app_config_manager/app_config_manager.dart';
import 'package:lichviet_flutter_base/data/datasource/local/key_constants.dart';
import 'package:lichviet_flutter_base/data/model/config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigLocalDatasource {
  ConfigLocalDatasource(this._preferences);

  final SharedPreferences _preferences;

  ConfigModel? get getConfigLocal {
    if (_preferences.containsKey(config)) {
      final result = ConfigModel.fromJson(
          jsonDecode(_preferences.getString(config) ?? ''));
      return result;
    } else {
      return null;
    }
  }

  Future<void> setConfigLocal(ConfigModel configModel) async {
    AppConfigManager.share.serverConfig =
        configModel.jsonConfig ?? configModel.toJson();
    await _preferences.setString(config, jsonEncode(configModel.toJson()));
  }
}
