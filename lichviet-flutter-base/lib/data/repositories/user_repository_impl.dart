import 'package:lichviet_flutter_base/data/datasource/local/user_local_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/native/user_native_datasource.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/user_remote_datasource.dart';
import 'package:lichviet_flutter_base/data/model/response/active_info_response_model.dart';
import 'package:lichviet_flutter_base/data/model/response/user_response_model.dart';
import 'package:lichviet_flutter_base/data/model/signal_model.dart';
import 'package:lichviet_flutter_base/data/model/user_info_native_model.dart';
import 'package:lichviet_flutter_base/data/model/user_model.dart';
import 'package:lichviet_flutter_base/domain/entities/float_button_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/item_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';
import 'package:lichviet_flutter_base/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserNativeDatasource userNativeDatasource;
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDatasource userLocalDatasource;

  UserRepositoryImpl(this.userNativeDatasource, this.userRemoteDataSource,
      this.userLocalDatasource);
  @override
  Future<UserInfoNativeModel> getUserFromNative() {
    return userNativeDatasource.getUserFromNative();
  }

  @override
  Future<ActiveInfoResponseModel> activePro(String input, String secretKey) {
    return userRemoteDataSource.activePro(input, secretKey);
  }

  @override
  Future<FloatButtonEntity> getFloatButtonFromNative() {
    return userNativeDatasource.getFloatButtonFromNative();
  }

  @override
  Future<List<SignalModel>> getSignalList(String userId, String secretKey) {
    return userRemoteDataSource.getSignalList(userId, secretKey);
  }

  @override
  Future<bool> removeSignal(
      String signal, String secretKey, String isLogin, String type) {
    return userRemoteDataSource.removeSignal(signal, secretKey, isLogin, type);
  }

  @override
  Future<bool> deleteAccount(String secretKey) {
    return userRemoteDataSource.deleteAccount(secretKey);
  }

  @override
  Future<UserResponseModel> updateUser(
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
  ) {
    return userRemoteDataSource.updateUser(
      secretKey,
      userId,
      name,
      birthDateTime,
      birthTime,
      gender,
      address,
      email,
      job,
      avatar,
      otp,
      phone,
      contactPhone,
    );
  }

  @override
  Future<bool> linkWithPhone(
      String phone, String secretKey, String accessToken) {
    return userRemoteDataSource.linkWithPhone(phone, secretKey, accessToken);
  }

  @override
  Future<String> uploadFile(
      String extension, String data, String table, String column) {
    return userRemoteDataSource.uploadFile(extension, data, table, column);
  }

  @override
  void clearCacheLogout() {
    userLocalDatasource.clearCacheLogout();
  }

  @override
  int? getShowPasswordLocal() {
    return userLocalDatasource.getShowPasswordLocal;
  }

  @override
  Future<void> setShowPasswordLocal(int dateTime) {
    return userLocalDatasource.setShowPasswordLocal(dateTime);
  }

  @override
  UserEntity? getUserInfoLocal() {
    return userLocalDatasource.getUserInfoLocal();
  }

  @override
  Future<void> setUserInfoLocal(UserEntity userInfo) {
    return userLocalDatasource.setUserInfoLocal(userInfo as UserModel);
  }

  @override
  String? getSecretKeyLocal() {
    return userLocalDatasource.getSecretKeyLocal();
  }

  @override
  Future<void> setSecretKeyLocal(String secretKey) {
    return userLocalDatasource.setSecretKeyLocal(secretKey);
  }

  @override
  Future<UserModel> getUserDetail(String secretKey, String userId) {
    return userRemoteDataSource.getUserDetail(secretKey, userId);
  }
}
