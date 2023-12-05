import 'package:lichviet_flutter_base/domain/entities/error_entity.dart';

class ErrorModel implements ErrorEntity {
  @override
  String? id;
  @override
  String? code;
  @override
  String? lang;
  @override
  String? content;
  @override
  String? modifyTime;

  ErrorModel({this.id, this.code, this.lang, this.content, this.modifyTime});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    lang = json['lang'];
    content = json['content'];
    modifyTime = json['modify_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['lang'] = lang;
    data['content'] = content;
    data['modify_time'] = modifyTime;
    return data;
  }
}
