import 'package:dartz/dartz.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/auth_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/access/data/models/user_info.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class AccessRemoteDataSource {
  Future<Either<BaseException, void>> register(UserInfo userInfo) async {
    final APIResponse response =
        await ApiService.postData(ApiEndpoint.register, userInfo.toJson());

    if (response.status == true) {
      AuthService.saveUserInfo(UserInfo.fromJson(response.metadata["user"]));
      AuthService.saveAccessToken(response.metadata["tokens"]["accessToken"]);
      return const Right(null);
    } else {
      return Left(ServerException('Server error'));
    }
  }

  Future<Either<BaseException, void>> login(UserInfo userInfo) async {
    final APIResponse response =
        await ApiService.postData(ApiEndpoint.login, userInfo.toJson());
    if (response.status == true) {
      response.metadata["user"]["password"] = userInfo.password;
      AuthService.saveUserInfo(UserInfo.fromJson(response.metadata["user"]));
      AuthService.saveAccessToken(response.metadata["tokens"]["accessToken"]);
      return const Right(null);
    } else {
      return Left(ServerException("Server error"));
    }
  }
}
