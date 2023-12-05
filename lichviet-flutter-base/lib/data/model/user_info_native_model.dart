import 'package:lichviet_flutter_base/core/utils/data_utils.dart';
import 'package:lichviet_flutter_base/data/model/premium_model.dart';
import 'package:lichviet_flutter_base/domain/entities/user_info_native_entity.dart';

class UserInfoNativeModel implements UserInfoNativeEntity {
  @override
  String? avatar;

  @override
  String? fullName;

  @override
  int? id;

  @override
  String? secretKey;

  @override
  String? about;

  @override
  String? address;

  @override
  String? birthday;

  @override
  String? email;

  @override
  String? gender;

  @override
  bool? hasFbId;

  @override
  bool? hasGgId;

  @override
  String? ip;

  @override
  int? isConnect;

  @override
  String? lastName;

  @override
  String? firstName;

  @override
  bool? password;

  @override
  String? phone;

  @override
  int? premium;

  @override
  int? roleId;

  @override
  int? status;

  @override
  String? job;

  @override
  List<PremiumModel>? premiums;

  @override
  String? birthdayChangeTimeLeft;

  @override
  String? birthTime;

  @override
  String? userName;

  @override
  bool? needShowSetPassword;

  UserInfoNativeModel({
    this.id,
    this.avatar,
    this.fullName,
    this.secretKey,
    this.about,
    this.address,
    this.birthday,
    this.email,
    this.gender,
    this.hasFbId,
    this.hasGgId,
    this.ip,
    this.isConnect,
    this.lastName,
    this.firstName,
    this.password,
    this.phone,
    this.premium,
    this.roleId,
    this.status,
    this.job,
    this.premiums,
    this.birthdayChangeTimeLeft,
    this.birthTime,
    this.userName,
    this.needShowSetPassword,
  });

  UserInfoNativeModel.fromJson(Map<String, dynamic> json) {
    final premiumList = <PremiumModel>[];
    id = json['id'] is String
        ? (json['id'] as String).isEmpty
            ? null
            : int.parse(json['id'])
        : json['id'];
    if (json['premiums'] != null && (json['premiums'] as List).isNotEmpty) {
      for (var element in (json['premiums'] as List)) {
        premiumList
            .add(PremiumModel.fromJson(Map<String, dynamic>.from(element)));
      }
    }
    premiums = premiumList;
    avatar = json['avatar'];
    fullName = json['full_name'];
    secretKey = json['secretKey'];
    about = json['about'];
    address = json['address'];
    birthday = json['birthday'];
    email = json['email'];
    gender = json['gender'];
    hasFbId = DataUtils.convertDataBoolean(json['hasFbId']);
    hasGgId = DataUtils.convertDataBoolean(json['hasGgId']);
    ip = json['ip'];
    isConnect = json['is_connect'] is String
        ? int.parse(json['is_connect'])
        : json['is_connect'];
    premium = json['premium'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    password = DataUtils.convertDataBoolean(json['password']);
    phone = json['phone'];
    roleId = json['role_id'] is String
        ? int.tryParse(json['role_id']) ?? 0
        : json['role_id'];
    status =
        json['status'] is String ? int.parse(json['status']) : json['status'];
    job = json['job'];
    birthdayChangeTimeLeft = json['birthday_change_time_left'] == null
        ? '2'
        : json['birthday_change_time_left'].toString();
    birthTime = json['birth_time']?.toString();
    userName = json['username'];
    needShowSetPassword = json['need_show_set_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['full_name'] = fullName;
    data['secretKey'] = secretKey;
    data['about'] = about;
    data['address'] = address;
    data['birthday'] = birthday;
    data['email'] = email;
    data['gender'] = gender;
    data['premiums'] = premiums?.map((e) => e.toJson()).toList();
    data['hasFbId'] = hasFbId;
    data['hasGgId'] = hasGgId;
    data['ip'] = ip;
    data['is_connect'] = isConnect;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['password'] = password;
    data['phone'] = phone;
    data['role_id'] = roleId;
    data['status'] = status;
    data['job'] = job;
    data['birthday_change_time_left'] = birthdayChangeTimeLeft;
    data['birth_time'] = birthTime;
    data['premium'] = premium;
    data['username'] = userName;
    data['need_show_set_password'] = needShowSetPassword;
    return data;
  }
}
