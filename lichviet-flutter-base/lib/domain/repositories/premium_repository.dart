
import 'package:lichviet_flutter_base/domain/entities/response/premium_response_entity.dart';

abstract class PremiumRepository {
  Future<PremiumResponseEntity> getPremiumStatus(String userId, String secretKey);
}