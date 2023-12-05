
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/end_points.dart';
import 'package:lichviet_flutter_base/data/model/response/premium_response_model.dart';

abstract class PremiumRemoteDataSource {
  Future<PremiumResponseModel> getPremiumStatus(
      String userId, String secretKey);
}

class PremiumRemoteDataSourceImpl implements PremiumRemoteDataSource {
  final ApiHandler _apiHandlerNative;

  PremiumRemoteDataSourceImpl(this._apiHandlerNative);

  @override
  Future<PremiumResponseModel> getPremiumStatus(
      String userId, String secretKey) async {
    final response = await _apiHandlerNative.post(EndPoints.premiumStatus,
        body: {'user_id': userId, 'secretKey': secretKey},
        parser: (json) => json);
    return PremiumResponseModel.fromJson(response['data']);
  }
}
