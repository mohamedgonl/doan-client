import 'package:equatable/equatable.dart';
import 'package:lichviet_flutter_base/data/model/premium_model.dart';
import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';

class UserModel extends Equatable implements UserEntity {
  @override
  String? id;
  @override
  String? username;
  @override
  String? fullName;
  @override
  bool? password;
  @override
  String? email;
  @override
  String? about;
  @override
  String? avatar;
  @override
  String? status;
  @override
  String? updateTime;
  @override
  String? createTime;
  @override
  String? address;
  @override
  String? rememberToken;
  @override
  String? phone;
  @override
  String? birthday;
  @override
  String? roleId;
  @override
  String? modifyTime;
  @override
  String? modifyBy;
  @override
  String? gender;
  @override
  String? loginType;
  @override
  String? isConnect;
  @override
  String? ip;
  @override
  String? firstName;
  @override
  String? lastName;
  @override
  String? deviceInfo;
  @override
  String? osInfo;
  @override
  String? coins;
  @override
  String? coinsOld;
  @override
  String? countryCode;
  @override
  String? appKey;
  @override
  String? userId;
  @override
  bool? hasFbId;
  @override
  bool? hasGgId;
  @override
  String? job;
  @override
  String? birthdayChangeTimeLeft;
  @override
  String? birthTime;
  @override
  List<PremiumModel>? premiums;
  @override
  int? premium;
  @override
  bool? needShowSetPassword;
  @override
  String? phoneContact;

  UserModel({
    this.id,
    this.username,
    this.fullName,
    this.password,
    this.email,
    this.about,
    this.avatar,
    this.status,
    this.updateTime,
    this.createTime,
    this.address,
    this.rememberToken,
    this.phone,
    this.birthday,
    this.roleId,
    this.modifyTime,
    this.modifyBy,
    this.gender,
    this.loginType,
    this.isConnect,
    this.ip,
    this.firstName,
    this.lastName,
    this.deviceInfo,
    this.osInfo,
    this.coins,
    this.coinsOld,
    this.countryCode,
    this.appKey,
    this.userId,
    this.hasFbId,
    this.hasGgId,
    this.job,
    this.birthdayChangeTimeLeft,
    this.birthTime,
    this.premium,
    this.premiums,
    this.needShowSetPassword,
    this.phoneContact,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    final premiumList = <PremiumModel>[];
    if (json['premiums'] != null && (json['premiums'] as List).isNotEmpty) {
      for (var element in (json['premiums'] as List)) {
        premiumList
            .add(PremiumModel.fromJson(Map<String, dynamic>.from(element)));
      }
    }
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    password = json['password'];
    email = json['email'];
    about = json['about'];
    avatar = json['avatar'];
    status = json['status'];
    updateTime = json['update_time'];
    createTime = json['create_time'];
    address = json['address'];
    rememberToken = json['remember_token'];
    phone = json['phone'];
    birthday = json['birthday'];
    roleId = json['role_id'];
    modifyTime = json['modify_time'];
    modifyBy = json['modify_by'];
    gender = json['gender'];
    loginType = json['login_type'];
    isConnect = json['is_connect'];
    ip = json['ip'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    deviceInfo = json['device_info'];
    osInfo = json['os_info'];
    coins = json['coins'];
    coinsOld = json['coins_old'];
    countryCode = json['country_code'];
    appKey = json['appKey'];
    userId = json['userId'];
    hasFbId = json['hasFbId'];
    hasGgId = json['hasGgId'];
    job = json['job'];
    birthdayChangeTimeLeft = json['birthday_change_time_left'] == null
        ? '2'
        : json['birthday_change_time_left'].toString();
    birthTime = json['birth_time']?.toString();
    premiums = premiumList;
    premium = json['premium'];
    needShowSetPassword = json['need_show_set_password'];
    phoneContact = json['phone_contact']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['full_name'] = fullName;
    data['password'] = password;
    data['email'] = email;
    data['about'] = about;
    data['avatar'] = avatar;
    data['status'] = status;
    data['update_time'] = updateTime;
    data['create_time'] = createTime;
    data['address'] = address;
    data['remember_token'] = rememberToken;
    data['phone'] = phone;
    data['birthday'] = birthday;
    data['role_id'] = roleId;
    data['modify_time'] = modifyTime;
    data['modify_by'] = modifyBy;
    data['gender'] = gender;
    data['login_type'] = loginType;
    data['is_connect'] = isConnect;
    data['ip'] = ip;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['device_info'] = deviceInfo;
    data['os_info'] = osInfo;
    data['coins'] = coins;
    data['coins_old'] = coinsOld;
    data['country_code'] = countryCode;
    data['appKey'] = appKey;
    data['userId'] = userId;
    data['hasFbId'] = hasFbId;
    data['hasGgId'] = hasGgId;
    data['job'] = job;
    data['birthday_change_time_left'] = birthdayChangeTimeLeft;
    data['birth_time'] = birthTime;
    data['premium'] = premium;
    data['premiums'] = premiums?.map((e) => e.toJson()).toList();
    data['need_show_set_password'] = needShowSetPassword;
    data['phone_contact'] = phoneContact;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        username,
        fullName,
        password,
        email,
        about,
        avatar,
        status,
        updateTime,
        createTime,
        address,
        rememberToken,
        phone,
        birthday,
        roleId,
        modifyTime,
        modifyBy,
        gender,
        loginType,
        isConnect,
        ip,
        firstName,
        lastName,
        deviceInfo,
        osInfo,
        coins,
        coinsOld,
        countryCode,
        appKey,
        userId,
        hasFbId,
        hasGgId,
        job,
        birthdayChangeTimeLeft,
        birthTime,
        premium,
        premiums,
        needShowSetPassword,
        phoneContact,
      ];

  @override
  bool? get stringify => true;
}
