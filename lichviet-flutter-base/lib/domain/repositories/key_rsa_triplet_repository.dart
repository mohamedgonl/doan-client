import 'package:lichviet_flutter_base/core/key_rsa_triplet_provider.dart';


abstract class KeyRsaTripletRepository {
  Future<String?> getPublickey();



  int? getIvIdKey();

  Future<void> saveIvIdKey({required int ivid});

  Future<void> saveKey({required TypeRsaKey typeRsaKey, required String key});

  Future<void> genarateNewKey();
  Future<void> clearKey();
}
