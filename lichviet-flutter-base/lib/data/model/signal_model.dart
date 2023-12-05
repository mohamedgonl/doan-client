import 'package:lichviet_flutter_base/domain/entities/signal_entity.dart';

class SignalModel implements SignalEntity {
  @override
  String? id;
  @override
  String? signal;
  @override
  String? type;
  @override
  String? userId;
  @override
  String? acessToken;
  @override
  String? syncEvents;
  @override
  String? isLogin;

  SignalModel(
      {this.id,
      this.signal,
      this.type,
      this.userId,
      this.acessToken,
      this.syncEvents,
      this.isLogin});

  SignalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    signal = json['signal'];
    type = json['type'];
    userId = json['user_id'];
    acessToken = json['acess_token'];
    syncEvents = json['sync_events'];
    isLogin = json['is_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['signal'] = signal;
    data['type'] = type;
    data['user_id'] = userId;
    data['acess_token'] = acessToken;
    data['sync_events'] = syncEvents;
    data['is_login'] = isLogin;
    return data;
  }
}
