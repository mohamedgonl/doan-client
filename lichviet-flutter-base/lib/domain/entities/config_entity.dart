import 'package:lichviet_flutter_base/domain/entities/app_update_entity.dart';

abstract class ConfigEntity {
  //force_update_appversion
  Map<String, dynamic>? get jsonConfig;
}
