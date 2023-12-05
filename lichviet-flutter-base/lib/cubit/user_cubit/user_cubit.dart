import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/core/exceptions/auth_email_exception.dart';
import 'package:lichviet_flutter_base/core/exceptions/no_network_exception.dart';
import 'package:lichviet_flutter_base/core/exceptions/phone_exist_exception.dart';
import 'package:lichviet_flutter_base/core/exceptions/server_exception.dart';
import 'package:lichviet_flutter_base/core/utils/device_info.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/data/datasource/local/user_local_datasource.dart';
import 'package:lichviet_flutter_base/data/model/premium_model.dart';
import 'package:lichviet_flutter_base/data/model/user_info_native_model.dart';
import 'package:lichviet_flutter_base/data/model/user_model.dart';
import 'package:lichviet_flutter_base/domain/entities/active_info_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/signal_entity.dart';
import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';
import 'package:lichviet_flutter_base/domain/usecases/premium_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/user_usecase.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUsecase _userUsecase;
  final PremiumUsecase _premiumUsecase;

  UserCubit(this._userUsecase, this._premiumUsecase)
      : super(UserState.initial());

  Future<void> getUserInfoLocal() async {
    try {
      // emit(state.copyWith(
      //     status: LoadingStatus.loading,
      //     userInfo: state.userInfo,
      //     secretKey: state.secretKey));
      final result = _userUsecase.getUserInfoLocal();
      emit(state.copyWith(
          status: LoadingStatus.success,
          userInfo: result,
          secretKey: state.secretKey));
      print("emit user detail roi ne");
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.failure, userInfo: null));
    }
  }

  Future<Map?> _getUserFromNative() async {
    try {
      // emit(state.copyWith(
      //     status: LoadingStatus.loading,
      //     userInfo: state.userInfo,
      //     secretKey: state.secretKey));
      final result = await _userUsecase.getUserFromNative();
      final userInfo = UserModel(
        id: result.id?.toString(),
        username: result.userName,
        fullName: result.fullName,
        password: result.password,
        email: result.email,
        about: result.about,
        avatar: result.avatar,
        status: result.status?.toString(),
        address: result.address,
        phone: result.phone,
        birthday: result.birthday,
        roleId: result.roleId?.toString(),
        gender: result.gender,
        isConnect: result.isConnect?.toString(),
        ip: result.ip,
        firstName: result.firstName,
        lastName: result.lastName,
        hasFbId: result.hasFbId,
        hasGgId: result.hasGgId,
        job: result.job,
        birthTime: result.birthTime,
        birthdayChangeTimeLeft: result.birthdayChangeTimeLeft,
        premium: result.premium,
        premiums: result.premiums as List<PremiumModel>,
        needShowSetPassword: result.needShowSetPassword,
      );
      return {userInfoKeyLocal: userInfo, secretKeyLocal: result.secretKey};
      _userUsecase.setSecretKeyLocal(result.secretKey ?? '');
      _userUsecase.setUserInfoLocal(userInfo);
      emit(state.copyWith(
          status: LoadingStatus.success,
          userInfo: userInfo,
          secretKey: result.secretKey));
    } catch (e) {
      return null;
      emit(state.copyWith(status: LoadingStatus.failure, userInfo: null));
    }
  }

  Future<void> getSecretKeyLocal() async {
    try {
      emit(state.copyWith(
          status: LoadingStatus.loading,
          userInfo: state.userInfo,
          secretKey: state.secretKey));
      final secretKey = _userUsecase.getSecretKeyLocal();
      emit(state.copyWith(
          status: LoadingStatus.success,
          userInfo: state.userInfo,
          secretKey: secretKey));
    } catch (e) {
      emit(state.copyWith(
          status: LoadingStatus.failure,
          userInfo: state.userInfo,
          secretKey: state.secretKey));
    }
  }

  Future<void> getVersionApp() async {
    final versionApp = await DeviceInfo().getVersionCode();
    emit(state.copyWith(
        versionApp: versionApp,
        userInfo: state.userInfo,
        secretKey: state.secretKey));
  }

  Future<void> getWeatherTemperatureUnit(MethodChannel platform) async {
    try {
      emit(state.copyWith(
        status: LoadingStatus.loading,
        userInfo: state.userInfo,
        secretKey: state.secretKey,
      ));
      var data = await platform.invokeMethod(ChannelEndpoint.getAppSettings);
      if (data != null) {
        if (data is String) {
          data = jsonDecode(data);
        }
        final itemList = Map<String, dynamic>.from(data);
        final result = itemList['weatherTemperatureUnit'].toString();
        emit(state.copyWith(
            status: LoadingStatus.success,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
            weatherTemp: result.toString()));
      } else {
        emit(state.copyWith(
            status: LoadingStatus.success,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
            weatherTemp: '1'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: LoadingStatus.success,
          userInfo: state.userInfo,
          secretKey: state.secretKey,
          weatherTemp: '1'));
    }
  }

  Future<String> getShowPopSetPassword(MethodChannel platform) async {
    var data = await platform.invokeMethod(ChannelEndpoint.getAppConfig);
    if (data != null) {
      if (data is String) {
        data = jsonDecode(data);
      }
      final itemList = Map<String, dynamic>.from(data);
      return itemList['show_popup_datmatkhau'].toString();
    }
    return '0';
  }

  Future<void> getShow(MethodChannel platform) async {
    try {
      emit(state.copyWith(
          status: LoadingStatus.loading,
          userInfo: state.userInfo,
          secretKey: state.secretKey));
      var data = await platform.invokeMethod(ChannelEndpoint.getAppSettings);
      if (data != null) {
        if (data is String) {
          data = jsonDecode(data);
        }
        final itemList = Map<String, dynamic>.from(data);
        final result = itemList['weatherTemperatureUnit'].toString();
        emit(state.copyWith(
            status: LoadingStatus.success,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
            weatherTemp: result.toString()));
      } else {
        emit(state.copyWith(
            status: LoadingStatus.success,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
            weatherTemp: '1'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: LoadingStatus.success,
          userInfo: state.userInfo,
          secretKey: state.secretKey,
          weatherTemp: '1'));
    }
  }

  Future<void> updateUser(
    String secretKey,
    String userId,
    bool afterLinkPhone, {
    String? name,
    String? birthDateTime,
    String? birthTime,
    String? gender,
    String? address,
    String? email,
    String? job,
    String? avatarUploadFile,
    String? otp,
    String? phone,
    String? contactPhone,
  }) async {
    try {
      emit(state.copyWith(
          status: LoadingStatus.updating,
          userInfo: state.userInfo,
          secretKey: state.secretKey));
      String? avatar;
      if (avatarUploadFile != null && avatarUploadFile.isNotEmpty) {
        avatar = await _userUsecase.uploadFile(
            'jpeg', avatarUploadFile, 'user', 'avatar');
      }
      final result = await _userUsecase.updateUser(
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
      emit(state.copyWith(
          status: LoadingStatus.updateSuccess,
          userInfo: result.user,
          afterLinkPhone: afterLinkPhone,
          secretKey: result.secretKey,
          phoneExist: result.status));
    } catch (e) {
      if (e is NetworkIssueException) {
        emit(state.copyWith(
            status: LoadingStatus.updateFailed,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
            error: 'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
      } else if (e is ServerException) {
        if (e.error is DioError) {
          if ((e.error as DioError).error is AuthEmailException) {
            emit(state.copyWith(
                status: LoadingStatus.updateFailed,
                userInfo: state.userInfo,
                secretKey: state.secretKey,
                error: '2'));
          } else if ((e.error as DioError).error is PhoneExistException) {
            emit(state.copyWith(
                status: LoadingStatus.updateFailed,
                userInfo: state.userInfo,
                secretKey: state.secretKey,
                phoneExist: 'phone_exists',
                afterLinkPhone: afterLinkPhone));
          } else {
            emit(state.copyWith(
                status: LoadingStatus.updateFailed,
                userInfo: state.userInfo,
                secretKey: state.secretKey,
                error: (e.error as DioError)
                    .message
                    .replaceAll('Exception: ', '')));
          }
        } else {
          emit(state.copyWith(
            status: LoadingStatus.updateFailed,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
          ));
        }
      } else {
        emit(state.copyWith(
          status: LoadingStatus.updateFailed,
          userInfo: state.userInfo,
          secretKey: state.secretKey,
        ));
      }
    }
  }

  Future<void> linkWithPhone(String phone, String secretKey, String accessToken,
      bool afterLinkPhone) async {
    try {
      emit(state.copyWith(
        status: LoadingStatus.updating,
        userInfo: state.userInfo,
        secretKey: state.secretKey,
      ));
      final result =
          await _userUsecase.linkWithPhone(phone, secretKey, accessToken);
      if (result) {
        emit(state.copyWith(
            status: LoadingStatus.updateSuccess,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
            afterLinkPhone: afterLinkPhone));
      } else {
        emit(state.copyWith(
          status: LoadingStatus.updateFailed,
          userInfo: state.userInfo,
          secretKey: state.secretKey,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoadingStatus.updateFailed,
        userInfo: state.userInfo,
        secretKey: state.secretKey,
      ));
    }
  }

  Future<void> reloadData(dynamic data) async {
    try {
      if (data != null) {
        emit(state.copyWith(
          status: LoadingStatus.loading,
          userInfo: state.userInfo,
          secretKey: state.secretKey,
        ));
        if (data is String) data = jsonDecode(data);
        final result = UserModel.fromJson(Map<String, dynamic>.from(data));
        emit(state.copyWith(
            status: LoadingStatus.success,
            userInfo: result,
            secretKey: state.secretKey));
      }
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.success, userInfo: null));
    }
  }

  Future<void> clearCacheLogout() async {
    _userUsecase.clearCacheLogout();
    emit(state.copyWith(
        status: LoadingStatus.success, userInfo: null, secretKey: null));
  }

  void setShowPasswordLocal(int dateTime) {
    _userUsecase.setShowPasswordLocal(dateTime);
  }

  int? getShowPasswordLocal() {
    return _userUsecase.getShowPasswordLocal();
  }

  Future<List<SignalEntity>> getSignalList(String userId, String secretKey) {
    return _userUsecase.getSignalList(userId, secretKey);
  }

  Future<int> getSuKienCaNhanCount(MethodChannel platform) async {
    final count =
        await platform.invokeMethod(ChannelEndpoint.personalEventCount);
    return count;
  }

  void updatePassword(MethodChannel platform) async {
    emit(state.copyWith(
      status: LoadingStatus.updating,
      userInfo: state.userInfo,
      secretKey: state.secretKey,
    ));
    await Future.delayed(const Duration(milliseconds: 100));
    final userNative = UserInfoNativeModel(
        id: state.userInfo?.id != null
            ? int.parse(state.userInfo?.id ?? '0')
            : null,
        avatar: state.userInfo?.avatar,
        fullName: state.userInfo?.fullName,
        secretKey: state.secretKey,
        about: state.userInfo?.about,
        address: state.userInfo?.address,
        birthday: state.userInfo?.birthday,
        email: state.userInfo?.email,
        gender: state.userInfo?.gender,
        hasFbId: state.userInfo?.hasFbId,
        hasGgId: state.userInfo?.hasGgId,
        ip: state.userInfo?.ip,
        isConnect: state.userInfo?.isConnect != null
            ? int.parse(state.userInfo?.isConnect ?? '1')
            : null,
        lastName: state.userInfo?.lastName,
        password: true,
        phone: state.userInfo?.phone,
        premium: state.userInfo?.premium,
        roleId: state.userInfo?.roleId != null
            ? int.parse(state.userInfo?.roleId ?? '1')
            : null,
        premiums: state.userInfo?.premiums as List<PremiumModel>,
        status: state.userInfo?.status != null
            ? int.parse(state.userInfo?.status ?? '1')
            : null);
    final user = state.userInfo as UserModel;
    user.password = true;
    _userUsecase.setUserInfoLocal(user);
    platform.invokeMethod(ChannelEndpoint.updateUserSuccess, {
      'data': Platform.isIOS
          ? {"secretKey": state.secretKey, "data": userNative.toJson()}
          : jsonEncode(
              {"secretKey": state.secretKey, "data": userNative.toJson()})
    });
    emit(state.copyWith(
      status: LoadingStatus.success,
      userInfo: user,
      secretKey: state.secretKey,
    ));
  }

  void updateUserToNative(UserEntity? userInfo) {
    final userNative = UserInfoNativeModel(
        id: userInfo?.id != null ? int.parse(userInfo?.id ?? '0') : null,
        avatar: userInfo?.avatar,
        fullName: userInfo?.fullName,
        secretKey: state.secretKey,
        about: userInfo?.about,
        address: userInfo?.address,
        birthday: userInfo?.birthday,
        email: userInfo?.email,
        gender: userInfo?.gender,
        hasFbId: userInfo?.hasFbId,
        hasGgId: userInfo?.hasGgId,
        ip: userInfo?.ip,
        isConnect: userInfo?.isConnect != null
            ? int.parse(userInfo?.isConnect ?? '1')
            : null,
        lastName: userInfo?.lastName,
        password: userInfo?.password,
        phone: userInfo?.phone,
        premium: userInfo?.premium,
        roleId: userInfo?.roleId != null
            ? int.parse(userInfo?.roleId ?? '1')
            : null,
        premiums: userInfo?.premiums as List<PremiumModel>,
        status: userInfo?.status != null
            ? int.parse(userInfo?.status ?? '1')
            : null);
    GetIt.I<MethodChannel>().invokeMethod(ChannelEndpoint.updateUserSuccess, {
      'data': Platform.isIOS
          ? {"secretKey": state.secretKey, "data": userNative.toJson()}
          : jsonEncode(
              {"secretKey": state.secretKey, "data": userNative.toJson()})
    });
  }

  Future<void> getUserDetail({required bool fromNative}) async {
    UserModel? userModel = null;
    String? secretKey = null;
    if (fromNative) {
      // Uu tien lay native truoc, khong co lay flutter
      final mapFromNative = await _getUserFromNative();
      userModel = (mapFromNative?[userInfoKeyLocal] as UserModel?) ??
          (_userUsecase.getUserInfoLocal() as UserModel?);
      secretKey = (mapFromNative?[secretKeyLocal] as String?) ??
          _userUsecase.getSecretKeyLocal();
    } else {
      // uu tien lay flutter truoc, khong co lay native
      userModel = _userUsecase.getUserInfoLocal() as UserModel?;
      secretKey = _userUsecase.getSecretKeyLocal();
      if (secretKey == null || secretKey.length == 0) {
        final mapFromNative = await _getUserFromNative();
        userModel = mapFromNative?[userInfoKeyLocal] as UserModel?;
        secretKey = mapFromNative?[secretKeyLocal] as String?;
      }
    }

    emit(state.copyWith(
        status: LoadingStatus.success,
        userInfo: userModel,
        secretKey: secretKey));
    if ((secretKey ?? '').length > 0) {
      _userUsecase.setSecretKeyLocal(secretKey ?? '');
      if (userModel != null) {
        _userUsecase.setUserInfoLocal(userModel);
        _userUsecase
            .getUserDetail(
                state.secretKey ?? '', state.userInfo?.id?.toString() ?? '')
            .then((value) {
          getUserInfoLocal();
        });
      }
    }
  }

  Future<void> updatePremiumList(List<ActiveInfoEntity>? activeInfoList) async {
    emit(state.copyWith(
      status: LoadingStatus.updating,
      userInfo: state.userInfo,
      secretKey: state.secretKey,
    ));
    final userModel = state.userInfo as UserModel;
    final premiumList = userModel.premiums;
    premiumList?.forEach((premium) {
      activeInfoList?.forEach((activeInfo) {
        if (activeInfo.id == premium.id) {
          premiumList.removeAt(premiumList.indexOf(premium));
          premiumList.add(PremiumModel(
            id: activeInfo.id,
            userId: activeInfo.userId,
            premiumTypeId: activeInfo.premiumTypeId,
            startTime: activeInfo.startTime,
            endTime: activeInfo.endTime,
            renewalDate: activeInfo.renewalDate,
            transactionId: activeInfo.transactionId,
            modifyBy: activeInfo.modifyBy,
            pushRemind: activeInfo.pushRemind,
            premiumGroups: activeInfo.premiumGroups,
            isPro: activeInfo.isPro,
            placeShowAd: activeInfo.placeShowAd,
            thumb: activeInfo.thumb,
          ));
        }
      });
    });
    final list = <ActiveInfoEntity>[];
    activeInfoList?.forEach((activeInfo) {
      if (!(premiumList?.any((premium) => premium.id == activeInfo.id) ??
          true)) {
        list.add(activeInfo);
      }
    });
    premiumList?.addAll(activeInfoList
            ?.map((activeInfo) => PremiumModel(
                  id: activeInfo.id,
                  userId: activeInfo.userId,
                  premiumTypeId: activeInfo.premiumTypeId,
                  startTime: activeInfo.startTime,
                  endTime: activeInfo.endTime,
                  renewalDate: activeInfo.renewalDate,
                  transactionId: activeInfo.transactionId,
                  modifyBy: activeInfo.modifyBy,
                  pushRemind: activeInfo.pushRemind,
                  premiumGroups: activeInfo.premiumGroups,
                  isPro: activeInfo.isPro,
                  placeShowAd: activeInfo.placeShowAd,
                  thumb: activeInfo.thumb,
                ))
            .toList() ??
        []);
    userModel.premiums = premiumList;
    _userUsecase.setUserInfoLocal(userModel);
    Future.delayed(const Duration(milliseconds: 50));
    emit(state.copyWith(
      status: LoadingStatus.success,
      userInfo: state.userInfo,
      secretKey: state.secretKey,
    ));
  }

  Future<void> getPremiumStatus(String userId, String secretKey) async {
    try {
      emit(state.copyWith(
        status: LoadingStatus.updating,
        userInfo: state.userInfo,
        secretKey: state.secretKey,
      ));
      await _premiumUsecase.getPremiumStatus(userId, secretKey);
      final userInfo = _userUsecase.getUserInfoLocal();
      updateUserToNative(userInfo);
      emit(state.copyWith(
        status: LoadingStatus.success,
        userInfo: userInfo,
        secretKey: state.secretKey,
      ));
    } catch (e) {
      if (e is NetworkIssueException) {
        emit(state.copyWith(
            status: LoadingStatus.updateFailed,
            userInfo: state.userInfo,
            secretKey: state.secretKey,
            error: 'Không có kết nối mạng. Vui lòng kiểm tra & thử lại!'));
      } else if (e is ServerException) {
        if (e.error is DioError) {
          if ((e.error as DioError).error is AuthEmailException) {
            emit(state.copyWith(
                status: LoadingStatus.updateFailed,
                userInfo: state.userInfo,
                secretKey: state.secretKey,
                error: '2'));
          } else {
            emit(state.copyWith(
                status: LoadingStatus.updateFailed,
                userInfo: state.userInfo,
                secretKey: state.secretKey,
                error: (e.error as DioError)
                    .message
                    .replaceAll('Exception: ', '')));
          }
        } else {
          emit(state.copyWith(
            status: LoadingStatus.updateFailed,
            secretKey: state.secretKey,
            userInfo: state.userInfo,
          ));
        }
      } else {
        emit(state.copyWith(
          status: LoadingStatus.updateFailed,
          userInfo: state.userInfo,
          secretKey: state.secretKey,
        ));
      }
    }
  }
}
