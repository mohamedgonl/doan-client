import 'package:lichviet_flutter_base/data/model/premium_model.dart';
import 'package:lichviet_flutter_base/data/model/user_model.dart';
import 'package:lichviet_flutter_base/domain/entities/response/premium_response_entity.dart';
import 'package:lichviet_flutter_base/domain/repositories/premium_repository.dart';
import 'package:lichviet_flutter_base/domain/repositories/user_repository.dart';

class PremiumUsecase {
  final PremiumRepository _premiumRepository;
  final UserRepository _userRepository;

  PremiumUsecase(this._premiumRepository, this._userRepository);
  Future<PremiumResponseEntity> getPremiumStatus(String userId, String secretKey) async {
    final premiumData = await _premiumRepository.getPremiumStatus(userId, secretKey);
    UserModel? userLocal = _userRepository.getUserInfoLocal() as UserModel;
    userLocal.premium = premiumData.premium;
    userLocal.premiums = premiumData.premiums as List<PremiumModel>;
    _userRepository.setUserInfoLocal(userLocal);
    return premiumData;
  }
}
