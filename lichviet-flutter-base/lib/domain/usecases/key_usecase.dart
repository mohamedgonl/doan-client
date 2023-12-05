import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';
import 'package:lichviet_flutter_base/domain/repositories/key_rsa_triplet_repository.dart';


class KeyUsecases {
  final KeyRsaTripletRepository _keyRsaTripletRepository;

  KeyUsecases(this._keyRsaTripletRepository);

 

  Future<String?> getPublicKey() {
    return _keyRsaTripletRepository.getPublickey();
  }

  int? getIvIdKey() {
    return _keyRsaTripletRepository.getIvIdKey();
  }

  Future<void> saveKey({required TypeRsaKey typeRsaKey, required String key}) {
    return _keyRsaTripletRepository.saveKey(typeRsaKey: typeRsaKey, key: key);
  }

  Future<void> saveIvId({required int ivid}) {
    return _keyRsaTripletRepository.saveIvIdKey(ivid: ivid);
  }

  Future<void> cleanKey() {
    return _keyRsaTripletRepository.clearKey();
  }

  Future<void> genareteNewKey() {
    return _keyRsaTripletRepository.genarateNewKey();
  }
}
