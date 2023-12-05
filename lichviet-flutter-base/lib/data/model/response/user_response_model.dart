import 'package:lichviet_flutter_base/data/model/user_model.dart';
import 'package:lichviet_flutter_base/domain/entities/response/user_response_entity.dart';

class UserResponseModel implements UserResponseEntity {
  @override
  String? status;

  @override
  UserModel? user;

  @override
  String? secretKey;

  UserResponseModel(this.status, this.user, this.secretKey);

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      json['status'].toString(),
      UserModel.fromJson(json['data']),
      json['secretKey'],
    );
  }
}
