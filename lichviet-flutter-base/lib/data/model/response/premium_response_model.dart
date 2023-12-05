import 'package:lichviet_flutter_base/data/model/premium_model.dart';
import 'package:lichviet_flutter_base/domain/entities/response/premium_response_entity.dart';

class PremiumResponseModel implements PremiumResponseEntity {
  @override
  int? premium;

  @override
  List<PremiumModel>? premiums;

  PremiumResponseModel({
    this.premium,
    this.premiums,
  });

  PremiumResponseModel.fromJson(Map<String, dynamic> json) {
    premium = json['premium'];
    final result = <PremiumModel>[];
    if (json['premiums'] != null && (json['premiums'] as List).isNotEmpty) {
      for (var element in (json['premiums'] as List)) {
        result.add(PremiumModel.fromJson(element));
      }
    }
    premiums = result;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['premium'] = premium;
    data['premiums'] = premiums?.map((e) => e.toJson()).toList();
    return data;
  }
}
