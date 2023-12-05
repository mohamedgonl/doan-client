import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:lichviet_flutter_base/data/datasource/local/key_constants.dart';
import 'package:lichviet_flutter_base/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const showSetPassword = 'showSetPassword';
const secretKeyLocal = 'secret_key';
const userInfoBoxKey = 'userInfoBoxKey';
const userInfoKeyLocal = 'user_info_key';

class UserLocalDatasource {
  final SharedPreferences _preferences;

  UserLocalDatasource(this._preferences);

  void clearCacheLogout() {
    _preferences.remove(familyKey);
    _preferences.remove(purchaseKey);
    _preferences.remove(showSetPassword);
    _preferences.remove(caseXemNgayTot);
    _preferences.remove(inputBirthdayFlowTimestamp);
    _preferences.remove(notificationsKey);
    _preferences.remove(userInfoKeyLocal);
    _preferences.remove(secretKeyLocal);
    _preferences.remove(xemPhongThuy);
    _preferences.remove(keyWife);
    _preferences.remove(keyHusband);
    _preferences.remove(userIdDidShowFlowBirthday);
    _preferences.remove(BoyName);
    _preferences.remove(BoyBirthday);

    _preferences.remove(GirlName);
    _preferences.remove(GirlBirthday);
    _preferences.remove(keyTimeAnHienGMNS);
    _preferences.remove(keyTimKiemThanhVien);
    _preferences.remove(keyTimKiemGiaPha);
    _preferences.remove(keyTimKiemTuDuong);

    Hive.box(userInfoBoxKey).clear();
  }

  Future<void> setShowPasswordLocal(int dateTime) async {
    await _preferences.setInt(showSetPassword, dateTime);
  }

  int? get getShowPasswordLocal {
    final data = _preferences.getInt(showSetPassword);
    return data;
  }

  Future<void> setSecretKeyLocal(String secretKey) async {
    var userInfoBox = Hive.box(userInfoBoxKey);
    userInfoBox.put(secretKeyLocal, secretKey);
    await _preferences.setString(secretKeyLocal, secretKey);
  }

  String? getSecretKeyLocal() {
    var userInfoBox = Hive.box(userInfoBoxKey);
    final secretKey = (userInfoBox.get(secretKeyLocal) as String?) ?? '';
    if (secretKey.length > 0) {
      return secretKey;
    }
    return _preferences.getString(secretKeyLocal);
  }

  Future<void> setUserInfoLocal(UserModel userInfo) async {
    final value = jsonEncode(userInfo.toJson());
    var userInfoBox = Hive.box(userInfoBoxKey);
    userInfoBox.put(userInfoKeyLocal, value);
    await _preferences.setString(userInfoKeyLocal, value);
  }

  UserModel? getUserInfoLocal() {
    var userInfoBox = Hive.box(userInfoBoxKey);
    final dataString = (userInfoBox.get(userInfoKeyLocal) as String?) ??
        _preferences.getString(userInfoKeyLocal);
    if (dataString != null) {
      return UserModel.fromJson(jsonDecode(dataString));
    }
    return null;
  }
}
