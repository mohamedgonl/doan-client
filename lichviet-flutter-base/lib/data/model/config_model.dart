import 'dart:convert';

import 'package:lichviet_flutter_base/data/model/app_update_model.dart';
import 'package:lichviet_flutter_base/domain/entities/config_entity.dart';

class ConfigModel implements ConfigEntity {
  @override
  Map<String, dynamic>? jsonConfig;

  ConfigModel({
    this.jsonConfig,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    final jsonConfigStr = json['jsonConfig'];
    if (jsonConfigStr is String) {
      jsonConfig = jsonDecode(jsonConfigStr);
    } else {
      jsonConfig = json;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonConfig'] = jsonEncode(jsonConfig);
    return data;
  }
}
