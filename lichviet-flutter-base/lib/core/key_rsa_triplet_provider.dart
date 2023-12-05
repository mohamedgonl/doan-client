import 'package:shared_preferences/shared_preferences.dart';

import "package:pointycastle/export.dart";

import 'generate_key.dart';



const String _publicRsaKey = "public_rsa_key";
const String _privateRsaKey = "private_rsa_key";
const String _identifier = 'identifier';

enum TypeRsaKey { publicKeyRsa, privateKeyRsa, idiv }

class KeyRsaTripletProvider {
  KeyRsaTripletProvider(this._preferences);

  final SharedPreferences _preferences;


  String? get publicKey {
    final String? data = _preferences.getString(_publicRsaKey);
    return data;
  }

  int? get idiv {
    int? data;
    try {
      data = _preferences.getInt(_identifier);
    } catch (_e) {
      data = _preferences.getInt(_identifier)!.toInt();
    }

    return data;
  }

  Future<void> setKey({required TypeRsaKey type, required String key}) async {
    if (type == TypeRsaKey.publicKeyRsa) {
      await _preferences.setString(_publicRsaKey, key);
    } else if (type == TypeRsaKey.privateKeyRsa) {
      await _preferences.setString(_privateRsaKey, key);
    }
  }

  Future<void> setIdiv({required int ivid}) async {
    await _preferences.setInt(_identifier, ivid);
  }

  Future<void> clearKey() async {
    await _preferences.remove(_privateRsaKey);
    await _preferences.remove(_publicRsaKey);
  }

  Future<void> genarateNewKey() async {
    await clearKey();

    AsymmetricKeyPair<PublicKey, PrivateKey> newKey =
        RsaKeyHelper().generateKeyPair();
    await setKey(
        key: RsaKeyHelper()
            .encodePublicKeyToPem(newKey.publicKey as RSAPublicKey),
        type: TypeRsaKey.publicKeyRsa);

    await setKey(
        key: RsaKeyHelper()
            .encodePrivateKeyToPem(newKey.privateKey as RSAPrivateKey),
        type: TypeRsaKey.privateKeyRsa);
  }
}
