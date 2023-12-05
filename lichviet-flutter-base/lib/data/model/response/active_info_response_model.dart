

import 'package:lichviet_flutter_base/data/model/active_info_model.dart';
import 'package:lichviet_flutter_base/domain/entities/response/active_info_response_entity.dart';

class ActiveInfoResponseModel implements ActiveInfoResponseEntity {
  @override
  String? message;
  @override
  int? status;
  @override
  List<ActiveInfoModel>? activeInfo;

  ActiveInfoResponseModel({this.message, this.status, this.activeInfo});

  ActiveInfoResponseModel.fromJson(Map<String, dynamic> json) {
    final result = <ActiveInfoModel>[];
    for (var element in (json['new_data'] as List)) {
      result.add(element);
    }
    message = json['message'];
    status = json['status'];
    activeInfo = result;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    // data['data'] = activeInfo!.toJson();
    return data;
  }
}
