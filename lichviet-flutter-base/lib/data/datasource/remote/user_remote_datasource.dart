import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/core/constants/firebase_log_base_event.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/end_points.dart';
import 'package:lichviet_flutter_base/data/model/active_info_model.dart';
import 'package:lichviet_flutter_base/data/model/response/active_info_response_model.dart';
import 'package:lichviet_flutter_base/data/model/response/user_response_model.dart';
import 'package:lichviet_flutter_base/data/model/signal_model.dart';
import 'package:lichviet_flutter_base/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<ActiveInfoResponseModel> activePro(String code, String secretKey);
  Future<bool> removeSignal(
      String signal, String secretKey, String isLogin, String type);
  Future<List<SignalModel>> getSignalList(String userId, String secretKey);
  Future<bool> deleteAccount(String secretKey);
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
  );
  Future<bool> linkWithPhone(
      String phone, String secretKey, String accessToken);
  Future<String> uploadFile(
      String extension, String data, String table, String column);
  Future<UserModel> getUserDetail(String secretKey, String userId);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiHandler _apiHandlerNative;
  final MethodChannel _platform;

  UserRemoteDataSourceImpl(this._apiHandlerNative, this._platform);

  @override
  Future<ActiveInfoResponseModel> activePro(
      String code, String secretKey) async {
    Map response = HashMap();
    await _apiHandlerNative.post(EndPoints.activePro,
        body: {'license': code, 'secretKey': secretKey}, parser: (json) {
      response = json;
    });

    final result = <ActiveInfoModel>[];
    for (var element in (response['new_data'] as List)) {
      result.add(ActiveInfoModel.fromJson(element));
    }

    return ActiveInfoResponseModel(
        message: response['message'],
        status: response['status'],
        activeInfo: result);
  }

  // 1: email 2: facebook 3: phone number
  @override
  Future<bool> removeSignal(
      String signal, String secretKey, String isLogin, String type) async {
    final result = await _apiHandlerNative.post(EndPoints.removeSignal,
        body: {
          'secretKey': secretKey,
          'signal': signal,
          'is_login': isLogin,
          'type': type
        },
        parser: (json) => json);
    return result['status'] == 1;
  }

  @override
  Future<List<SignalModel>> getSignalList(
      String userId, String secretKey) async {
    final result = await _apiHandlerNative.post(EndPoints.signalList,
        body: {'secretKey': secretKey, 'user_id': userId},
        parser: (json) => json);
    final signalList = <SignalModel>[];
    for (var element in (result['data'] as List)) {
      signalList.add(SignalModel.fromJson(element));
    }
    return signalList;
  }

  @override
  Future<bool> deleteAccount(String secretKey) async {
    final result = await _apiHandlerNative.post(EndPoints.deleteAccount,
        body: {'secretKey': secretKey}, parser: (json) => json);
    return result['status'] == 1;
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
      String? phone, String? contactPhone,) async {
    Map<String, dynamic> param = HashMap();
    param.putIfAbsent("secretKey", () => secretKey);
    param.putIfAbsent("userId", () => userId);
    if (name != null && name.isNotEmpty) {
      param.putIfAbsent("full_name", () => name);
    }
    if (birthDateTime != null && birthDateTime.isNotEmpty) {
      FireBaseLogBaseEvent().birthDayChange();
      param.putIfAbsent('birthday', () => birthDateTime);
    }
    if (gender != null && gender.isNotEmpty) {
      param.putIfAbsent('gender', () => gender);
    }
    if (address != null && address.isNotEmpty) {
      param.putIfAbsent('address', () => address);
    }
    if (email != null && email.isNotEmpty) {
      param.putIfAbsent('email', () => email);
    }
    if (job != null && job.isNotEmpty) {
      param.putIfAbsent('job', () => job);
    }
    if (avatar != null && avatar.isNotEmpty) {
      param.putIfAbsent('avatar', () => avatar);
    }
    if (otp != null && otp.isNotEmpty) {
      param.putIfAbsent('otp_email', () => otp);
    }
    if (phone != null && phone.isNotEmpty) {
      param.putIfAbsent('phone', () => phone);
    }
    if (birthTime != null && birthTime.isNotEmpty) {
      FireBaseLogBaseEvent().birthTimeChange();
      param.putIfAbsent('birth_time', () => birthTime);
    }
    if (contactPhone != null && contactPhone.isNotEmpty) {
      param.putIfAbsent('phone_contact', () => contactPhone);
    }
    final result = await _apiHandlerNative.post(EndPoints.updateUser,
        body: param, parser: (json) => json);
    _platform.invokeMethod(ChannelEndpoint.updateUserSuccess,
        {'data': Platform.isIOS ? result : jsonEncode(result)});
    return UserResponseModel.fromJson(result);
  }

  @override
  Future<bool> linkWithPhone(
      String phone, String secretKey, String accessToken) async {
    final result = await _apiHandlerNative.post(EndPoints.linkWithPhone,
        body: {
          'secretKey': secretKey,
          'phone': phone,
          'accessTokenGGFirebase': accessToken
        },
        parser: (json) => json);
    return result['status'] == 1;
  }

  @override
  Future<String> uploadFile(
      String extension, String data, String table, String column) async {
    final result = await _apiHandlerNative.post(EndPoints.fileUpload,
        body: {
          'extension': extension,
          'data': data,
          'table': table,
          'column': column
        },
        parser: (json) => json);
    return result['data'];
  }

  @override
  Future<UserModel> getUserDetail(String secretKey, String userId) async {
    final result = await _apiHandlerNative.post(EndPoints.userDetail,
        body: {'secretKey': secretKey, 'userId': userId},
        parser: (json) => json);
    result['secretKey'] = secretKey;
    _platform.invokeMethod(ChannelEndpoint.updateUserSuccess,
        {'data': Platform.isIOS ? result : jsonEncode(result)});
    return UserModel.fromJson(result['data']);
  }
}
