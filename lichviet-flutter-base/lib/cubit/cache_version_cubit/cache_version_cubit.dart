import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';

import 'package:lichviet_flutter_base/domain/usecases/cache_version_usecase.dart';
import 'package:lichviet_flutter_base/lichviet_flutter_base.dart';

import 'package:shared_preferences/shared_preferences.dart';
part 'cache_version_state.dart';

class CacheVersionCubit extends Cubit<CacheVersionState> {
  final CacheVersionUseCase _cacheVersionUseCase;
  CacheVersionCubit(this._cacheVersionUseCase)
      : super(CacheVersionState.initial());

  Future<void> getVersionApi() async {
    emit(state.copyWith(status: LoadingStatus.refreshing));
    _cacheVersionUseCase.getVersionCacheData().then((value) async {
      if (value.isEmpty) {
          emit(state.copyWith(status: LoadingStatus.failure));
        return;
      }
      String keyCacheLocalData = 'VERSION_APP_DATA';
      SharedPreferences localData = await SharedPreferences.getInstance();
      bool checkDelete = false;
      if (!localData.containsKey(keyCacheLocalData)) {
        localData.setString(keyCacheLocalData, jsonEncode(value));
        state.copyWith(versionData: value);
        return;
      } else {
        Map<String, dynamic> localCache =
            jsonDecode(localData.getString(keyCacheLocalData)!);
        for (var element in value.keys) {
          if (localCache.containsKey(element)) {
            if (value[element] != localCache[element]) {
              await LichVietFlutterBase.getInstance().managerCache?.deleteByPrimaryKeyAndSubKeyWithUri(
                  Uri.parse('${LichVietFlutterBase.configProduct.baseUrl}/$element'));

               await LichVietFlutterBase.getInstance().managerCache?.deleteByPrimaryKeyWithUri(
                  Uri.parse('${LichVietFlutterBase.configProduct.baseUrl}/$element'));
              checkDelete = true;
            }
          }
        }

        localData.setString(keyCacheLocalData, jsonEncode(value));
      }
      if (checkDelete == true) {
        emit(state.copyWith(status: LoadingStatus.success, versionData: value));
      } else {
        state.copyWith(versionData: value);
      }
    });
  }
}
