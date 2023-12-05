import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/domain/usecases/api_config_usecase.dart';
import 'package:lichviet_flutter_base/domain/usecases/key_usecase.dart';
import 'package:lichviet_flutter_base/lichviet_flutter_base.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  final KeyUsecases _keyUsecases;
  final ApiConfigUsecases _apiConfigUsecases;

  InitCubit(this._keyUsecases, this._apiConfigUsecases)
      : super(InitState.initial());

  Future<void> getPublicKey() async {
    try {
      emit(
          state.copyWith(status: LoadingStatus.loading, update: !state.update));

      String publicKey = '';
      int? ivId = _keyUsecases.getIvIdKey();

      if (ivId == null) {
        Map<String, dynamic> getPublicKey =
            await _apiConfigUsecases.getPublicKeyV2();

        publicKey = getPublicKey['data']['key'];

        await _keyUsecases.saveKey(
            typeRsaKey: TypeRsaKey.publicKeyRsa, key: publicKey);
        await _keyUsecases.saveIvId(ivid: getPublicKey['data']['identifier']);
        LichVietFlutterBase.getInstance().managerCache?.clearAll();
        emit(state.copyWith(
            status: LoadingStatus.success, update: !state.update));
      } else {
        emit(state.copyWith(
            status: LoadingStatus.success, update: !state.update));
      }
    } catch (e) {
      emit(
          state.copyWith(status: LoadingStatus.failure, update: !state.update));
    }
  }
}
