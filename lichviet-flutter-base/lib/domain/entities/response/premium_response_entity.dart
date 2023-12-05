import 'package:lichviet_flutter_base/domain/entities/premium_entity.dart';

abstract class PremiumResponseEntity {
  List<PremiumEntity>? get premiums;
  int? get premium;
}