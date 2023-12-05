import 'package:lichviet_flutter_base/domain/entities/app_update_entity.dart';

class AppUpdateModel extends AppUpdateEntity {
  @override
  String? message;

  @override
  int? updateStatus;

  AppUpdateModel(this.updateStatus, this.message);

  AppUpdateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updateStatus = int.tryParse(json['updateStatus']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['updateStatus'] = updateStatus;
    return data;
  }
}
