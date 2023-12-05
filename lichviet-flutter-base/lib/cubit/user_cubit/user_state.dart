import 'package:hive/hive.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/data/datasource/local/user_local_datasource.dart';
import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final LoadingStatus? status;
  final UserEntity? userInfo;
  final double bottomBarHeight;
  final double? safeAreaSpace;
  final dynamic error;
  final String? versionApp;
  final String? phoneExist;
  final bool? afterLinkPhone;
  final String? weatherTemp;
  final String? secretKey;

  const UserState({
    this.status,
    this.userInfo,
    this.error,
    required this.bottomBarHeight,
    this.safeAreaSpace,
    this.phoneExist,
    this.afterLinkPhone,
    this.versionApp,
    this.weatherTemp,
    this.secretKey,
  });

  factory UserState.initial() {
    return const UserState(
      status: LoadingStatus.initial,
      bottomBarHeight: 0,
    );
  }

  UserState copyWith({
    LoadingStatus? status,
    UserEntity? userInfo,
    double? bottomBarHeight,
    LoadingStatus? heLichStatus,
    double? safeAreaSapce,
    String? versionApp,
    dynamic error,
    String? phoneExist,
    bool? afterLinkPhone,
    String? weatherTemp,
    String? secretKey,
  }) {
    return UserState(
      status: status ?? LoadingStatus.initial,
      userInfo: userInfo,
      versionApp: versionApp ?? this.versionApp,
      bottomBarHeight: bottomBarHeight ?? this.bottomBarHeight,
      safeAreaSpace: safeAreaSapce,
      error: error,
      afterLinkPhone: afterLinkPhone,
      phoneExist: phoneExist,
      weatherTemp: weatherTemp ?? this.weatherTemp,
      secretKey: secretKey,
    );
  }

  @override
  List<Object?> get props => [
        error,
        status,
        userInfo,
        bottomBarHeight,
        versionApp,
        safeAreaSpace,
        phoneExist,
        afterLinkPhone,
        weatherTemp,
        secretKey,
      ];
}
