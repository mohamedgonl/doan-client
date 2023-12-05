import 'package:lichviet_flutter_base/domain/entities/premium_entity.dart';

abstract class UserInfoNativeEntity {
  String? get avatar;
  String? get fullName;
  String? get userName;
  int? get id;
  String? get secretKey;
  String? get about;
  String? get address;
  String? get birthday;
  String? get email;
  String? get gender;
  bool? get hasFbId;
  bool? get hasGgId;
  String? get ip;
  int? get isConnect;
  int? get premium;
  String? get firstName;
  String? get lastName;
  bool? get password;
  String? get phone;
  int? get roleId;
  int? get status;
  String? get job;
  String? get birthdayChangeTimeLeft;
  List<PremiumEntity>? get premiums;
  String? get birthTime;
  bool? get needShowSetPassword;

}