// // import 'package:lichviet_flutter_base/data/model/premium_model.dart';
// // import 'package:lichviet_flutter_base/data/model/user_model.dart';
// // import 'package:lichviet_flutter_base/domain/entities/float_button_entity.dart';
// // import 'package:lichviet_flutter_base/domain/entities/response/active_info_response_entity.dart';
// // import 'package:lichviet_flutter_base/domain/entities/response/user_response_entity.dart';
// // import 'package:lichviet_flutter_base/domain/entities/signal_entity.dart';
// // import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';
// // import 'package:lichviet_flutter_base/domain/entities/user_info_native_entity.dart';
// // import 'package:lichviet_flutter_base/domain/repositories/user_repository.dart';

// class UserUsecase {
//   final UserRepository userRepository;

//   UserUsecase(this.userRepository);

//   Future<UserInfoNativeEntity> getUserFromNative() {
//     return userRepository.getUserFromNative();
//   }

//   Future<ActiveInfoResponseEntity> activePro(String input, String secretKey) {
//     return userRepository.activePro(input, secretKey);
//   }

//   Future<FloatButtonEntity> getFloatButtonFromNative() {
//     return userRepository.getFloatButtonFromNative();
//   }

//   Future<List<SignalEntity>> getSignalList(
//       String userId, String secretKey) async {
//     return userRepository.getSignalList(userId, secretKey);
//   }

//   Future<bool> removeSignal(
//       String signal, String secretKey, String isLogin, String type) async {
//     return userRepository.removeSignal(signal, secretKey, isLogin, type);
//   }

//   Future<bool> deleteAccount(String secretKey) async {
//     return userRepository.deleteAccount(secretKey);
//   }

//   Future<UserResponseEntity> updateUser(
//       String secretKey,
//       String userId,
//       String? name,
//       String? birthDateTime,
//       String? birthTime,
//       String? gender,
//       String? address,
//       String? email,
//       String? job,
//       String? avatar,
//       String? otp,
//       String? phone,
//       String? contactPhone,) async {
//     final result = await userRepository.updateUser(
//       secretKey,
//       userId,
//       name,
//       birthDateTime,
//       birthTime,
//       gender,
//       address,
//       email,
//       job,
//       avatar,
//       otp,
//       phone,
//       contactPhone,
//     );
//     final userModel = result.user as UserModel;
//     final userLocal = userRepository.getUserInfoLocal();
//     userModel.premium = userLocal?.premium;
//     userModel.premiums = userLocal?.premiums as List<PremiumModel>;
//     if (result.user != null) {
//       userRepository.setUserInfoLocal(userModel);
//     }
//     if (result.secretKey != null && result.secretKey!.isNotEmpty) {
//       userRepository.setSecretKeyLocal(secretKey);
//     }
//     return result;
//   }

//   Future<bool> linkWithPhone(
//       String phone, String secretKey, String accessToken) async {
//     return userRepository.linkWithPhone(phone, secretKey, accessToken);
//   }

//   Future<String> uploadFile(
//       String extension, String data, String table, String column) async {
//     return userRepository.uploadFile(extension, data, table, column);
//   }

//   void clearCacheLogout() async {
//     return userRepository.clearCacheLogout();
//   }

//   Future<void> setShowPasswordLocal(int dateTime) {
//     return userRepository.setShowPasswordLocal(dateTime);
//   }

//   int? getShowPasswordLocal() {
//     return userRepository.getShowPasswordLocal();
//   }

//   Future<void> setUserInfoLocal(UserEntity userInfo) {
//     return userRepository.setUserInfoLocal(userInfo);
//   }

//   UserEntity? getUserInfoLocal() {
//     return userRepository.getUserInfoLocal();
//   }

//   Future<void> setSecretKeyLocal(String secretKey) async {
//     await userRepository.setSecretKeyLocal(secretKey);
//   }

//   String? getSecretKeyLocal() {
//     return userRepository.getSecretKeyLocal();
//   }

//   Future<UserEntity> getUserDetail(String secretKey, String userId) async {
//     final userInfo = await userRepository.getUserDetail(secretKey, userId);
//     userRepository.setUserInfoLocal(userInfo);
//     return userInfo;
//   }
// }
