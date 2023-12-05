import 'package:lichviet_flutter_base/domain/entities/active_info_entity.dart';

class ActiveInfoModel extends ActiveInfoEntity {
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
  String? isPro;
  @override
  String? premiumGroups;
  @override
  String? placeShowAd;
  @override
  String? thumb;

  ActiveInfoModel({
    this.id,
    this.userId,
    this.premiumTypeId,
    this.startTime,
    this.endTime,
    this.renewalDate,
    this.transactionId,
    this.modifyBy,
    this.pushRemind,
    this.isPro,
    this.premiumGroups,
    this.placeShowAd,
    this.thumb,
  });
  ActiveInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    premiumTypeId = json['premium_type_id'].toString();
    startTime = json['start_time'];
    endTime = json['end_time'];
    renewalDate = json['renewal_date'];
    transactionId = json['transaction_id'];
    modifyBy = json['modify_by'];
    pushRemind = json['push_remind'];
    isPro = json['is_pro'].toString();
    premiumGroups = json['premium_groups'];
    placeShowAd = json['place_show_ad'];
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
    data['is_pro'] = isPro;
    data['premium_groups'] = premiumGroups;
    data['place_show_ad'] = placeShowAd;
    data['thumb'] = thumb;
    return data;
  }
}
