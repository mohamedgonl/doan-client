import 'package:lichviet_flutter_base/domain/entities/active_info_entity.dart';

abstract class ActiveInfoResponseEntity {
  int? get status;
  String? get message;
  List<ActiveInfoEntity>? get activeInfo;
}