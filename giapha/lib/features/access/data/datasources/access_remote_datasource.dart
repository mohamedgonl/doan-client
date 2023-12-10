import 'package:dartz/dartz.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/access/data/models/User.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class AccessRemoteDataSource {
  Future<Either<BaseException, void>> register(UserInfo userInfo) async {
    final APIResponse response =
        await ApiService.postData(ApiEndpoint.register, userInfo.toJson());

    if (response.status == 200) {
      return const Right(null);
    } else {
      return Left(ServerException('Server error'));
    }
  }

  Future<Either<BaseException, void>> login(UserInfo userInfo) async {
    return Right(null);
  }
}
