import 'package:lichviet_flutter_base/domain/entities/float_button_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/item_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/response/active_info_response_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/response/user_response_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/signal_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/user_info_native_entity.dart';

abstract class UserRepository {
  Future<UserInfoNativeEntity> getUserFromNative();
  Future<ActiveInfoResponseEntity> activePro(String input, String secretKey);
  Future<FloatButtonEntity> getFloatButtonFromNative();
  Future<List<SignalEntity>> getSignalList(String userId, String secretKey);
  Future<bool> removeSignal(
      String signal, String secretKey, String isLogin, String type);
  Future<bool> deleteAccount(String secretKey);
  Future<UserResponseEntity> updateUser(
    String secretKey,
    String userId,
    String? name,
    String? birthDateTime,
    String? birthTime,
    String? gender,
    String? address,
    String? email,
    String? job,
    String? avatar,
    String? otp,
    String? phone,
    String? contactPhone,
  );
  Future<bool> linkWithPhone(
      String phone, String secretKey, String accessToken);
  Future<String> uploadFile(
      String extension, String data, String table, String column);
  void clearCacheLogout();
  Future<void> setShowPasswordLocal(int dateTime);
  int? getShowPasswordLocal();
  Future<void> setUserInfoLocal(UserEntity userInfo);
  UserEntity? getUserInfoLocal();
  Future<void> setSecretKeyLocal(String secretKey);
  String? getSecretKeyLocal();
  Future<UserEntity> getUserDetail(String secretKey, String userId);
}
