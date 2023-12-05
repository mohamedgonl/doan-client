import 'package:equatable/equatable.dart';
import 'package:lichviet_flutter_base/domain/entities/premium_entity.dart';

abstract class UserEntity extends Equatable {
  String? get id;
  String? get username;
  String? get fullName;
  bool? get password;
  String? get email;
  String? get about;
  String? get avatar;
  String? get status;
  String? get updateTime;
  String? get createTime;
  String? get address;
  String? get rememberToken;
  String? get phone;
  String? get birthday;
  String? get roleId;
  String? get modifyTime;
  String? get modifyBy;
  String? get gender;
  String? get loginType;
  String? get isConnect;
  String? get ip;
  String? get firstName;
  String? get lastName;
  String? get deviceInfo;
  String? get osInfo;
  String? get coins;
  String? get coinsOld;
  String? get countryCode;
  String? get appKey;
  String? get userId;
  bool? get hasFbId;
  bool? get hasGgId;
  String? get job;
  String? get birthdayChangeTimeLeft;
  String? get birthTime;
  int? get premium;
  bool? get needShowSetPassword;
  List<PremiumEntity>? get premiums;
  String? phoneContact;

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
}
