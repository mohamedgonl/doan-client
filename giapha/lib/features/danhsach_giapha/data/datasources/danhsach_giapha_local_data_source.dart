import 'dart:convert';

import 'package:giapha/core/exceptions/cache_exception.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DanhSachGiaPhaLocalDataSource {
  Future<List<GiaPhaModel>> layDanhSachGiaPha();
  Future<void> cacheDanhSachGiaPha(List<GiaPhaModel> giaPhaCache);
}

// ignore: constant_identifier_names
const CACHED_DANHSACH_GIAPHA = 'CACHED_DS_GIAPHA_RESPONSE';

class DanhSachGiaPhaLocalDataSourceImpl
    implements DanhSachGiaPhaLocalDataSource {
  final SharedPreferences sharedPreferences;

  DanhSachGiaPhaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheDanhSachGiaPha(List<GiaPhaModel> giaPhaCache) {
    final cacheMap = giaPhaCache.map((e) => e.toJSON()).toList();
    final encodeString = jsonEncode(cacheMap);
    return sharedPreferences.setString(CACHED_DANHSACH_GIAPHA, encodeString);
  }

  @override
  Future<List<GiaPhaModel>> layDanhSachGiaPha() async {
    final String? data = sharedPreferences.getString(CACHED_DANHSACH_GIAPHA);
    if (data != null) {
      return (jsonDecode(dataTest) as List<dynamic>)
          .map((e) => GiaPhaModel.fromJSON(e))
          .toList();
    } else {
      throw CacheException();
    }
  }

  String dataTest = """
{
    "status": true,
    "data": {
        "created": [
            {
                "id": "990ce1a7-283a-46a5-9b14-291bff863a51",
                "ten_gia_pha": "Gia pha A",
                "ten_nhanh": "Nhanh B",
                "dia_chi": "Ab, Cd",
                "mo_ta": "Test",
                "id_nguoi_tao": "003783f0-6400-4d67-adf0-5d0d7e1ea213",
                "thoi_gian_tao": "2023-02-02T02:04:48.000Z",
                "deleted_at": null,
                "username": "Nang",
                "full_name": "Le Ton Nang",
                "email": "letonnang@gmail.com",
                "phone": "0439586939",
                "so_doi": "1",
                "so_thanh_vien": "1"
            }
        ],
        "shared": []
    }
}""";
}
