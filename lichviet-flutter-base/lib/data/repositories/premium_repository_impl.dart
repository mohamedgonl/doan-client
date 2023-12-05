

import 'package:lichviet_flutter_base/data/datasource/remote/premium_remote_datasource.dart';
import 'package:lichviet_flutter_base/data/model/response/premium_response_model.dart';
import 'package:lichviet_flutter_base/domain/repositories/premium_repository.dart';

class PremiumRepositoryImpl implements PremiumRepository {
  final PremiumRemoteDataSource _premiumRemoteDataSource;

  PremiumRepositoryImpl(this._premiumRemoteDataSource);
  @override
  Future<PremiumResponseModel> getPremiumStatus(String userId, String secretKey) {
    return _premiumRemoteDataSource.getPremiumStatus(userId, secretKey);
  }
}
