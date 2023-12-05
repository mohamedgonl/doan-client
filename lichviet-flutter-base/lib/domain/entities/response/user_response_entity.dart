import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';

abstract class UserResponseEntity {
  String? get status;
  UserEntity? get user;
  String? secretKey;
}