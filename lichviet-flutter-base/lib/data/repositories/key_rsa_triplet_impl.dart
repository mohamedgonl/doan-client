import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';
import 'package:lichviet_flutter_base/domain/repositories/key_rsa_triplet_repository.dart';


class KeyRsaTripletRepositoryImpl implements KeyRsaTripletRepository {
  final KeyRsaTripletProvider _keyRsaTripletProvider;

  KeyRsaTripletRepositoryImpl(this._keyRsaTripletProvider);

 

  @override
  Future<String?> getPublickey() async {
    return _keyRsaTripletProvider.publicKey;
  }

  @override
  Future<void> saveKey(
      {required TypeRsaKey typeRsaKey, required String key}) async {
    await _keyRsaTripletProvider.setKey(type: typeRsaKey, key: key);
  }

  @override
  Future<void> clearKey() async {
    await _keyRsaTripletProvider.clearKey();
  }

  @override
  Future<void> genarateNewKey() async {
    await _keyRsaTripletProvider.genarateNewKey();
  }

  @override
  int? getIvIdKey() {
    return _keyRsaTripletProvider.idiv;
  }

  @override
  Future<void> saveIvIdKey({required int ivid}) async {
    return _keyRsaTripletProvider.setIdiv(ivid: ivid);
  }
}
