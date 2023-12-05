import 'package:lichviet_flutter_base/domain/entities/premium_entity.dart';

class PremiumModel implements PremiumEntity {
  @override
  String? id;
  @override
  String? userId;
  @override
  String? premiumTypeId;
  @override
  String? startTime;
  @override
  String? endTime;
  @override
  String? renewalDate;
  @override
  String? transactionId;
  @override
  String? modifyBy;
  @override
  String? pushRemind;
  @override
  String? premiumGroups;
  @override
  String? isPro;
  @override
  String? placeShowAd;
  @override
  String? thumb;

  PremiumModel({
    this.id,
    this.userId,
    this.premiumTypeId,
    this.startTime,
    this.endTime,
    this.renewalDate,
    this.transactionId,
    this.modifyBy,
    this.pushRemind,
    this.premiumGroups,
    this.isPro,
    this.placeShowAd,
    this.thumb,
  });

  PremiumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    premiumTypeId = json['premium_type_id'].toString();
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
    renewalDate = json['renewal_date'].toString();
    transactionId = json['transaction_id'].toString();
    modifyBy = json['modify_by'].toString();
    pushRemind = json['push_remind'].toString();
    premiumGroups = json['premium_groups'].toString();
    isPro = json['is_pro'].toString();
    placeShowAd =
        json['place_show_ad'] != null ? json['place_show_ad'].toString() : '1';
    thumb = json['thumb'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['premium_type_id'] = premiumTypeId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['renewal_date'] = renewalDate;
    data['transaction_id'] = transactionId;
    data['modify_by'] = modifyBy;
    data['push_remind'] = pushRemind;
    data['premium_groups'] = premiumGroups;
    data['is_pro'] = isPro;
    data['place_show_ad'] = placeShowAd;
    data['thumb'] = thumb;
    return data;
  }
}
