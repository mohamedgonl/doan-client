import 'dart:collection';

import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/shared/utils/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimKiemThanhVienDatasource {
  final SharedPreferences sharedPreferences;
  const TimKiemThanhVienDatasource(this.sharedPreferences);

  Future<List<UserInfo>> timKiemThanhVienTheoText(
    String keySearch, {
    String? idGiaPha,
    String? idChucVu,
    String? gioiTinh,
    int? year,
    String? die,
  }) async {
    Map<String, dynamic> param = HashMap();
    param.putIfAbsent("text_search", () => keySearch);
    if (idGiaPha.isNotNullOrEmpty) {
      param.putIfAbsent("genealogy", () => idGiaPha);
    }
    if (idChucVu.isNotNullOrEmpty) {
      param.putIfAbsent("chuc_vu", () => idChucVu);
    }
    if (gioiTinh.isNotNullOrEmpty) {
      param.putIfAbsent("gioi_tinh", () => gioiTinh);
    }
    if (year != null) {
      param.putIfAbsent("year", () => year);
    }
    if (die.isNotNullOrEmpty) {
      param.putIfAbsent("die", () => die);
    }

    APIResponse response = await ApiService.postData(
        ApiEndpoint.searchMember, {"text": keySearch});

    List<UserInfo> danhSachThanhVien = [];
    if (response.status) {
      for (var e in response.metadata) {
        danhSachThanhVien.add(UserInfo.fromJson(e));
      }
    }
    return danhSachThanhVien;
  }

  Future<void> saveLocalSearch(String userId, List<String> listTextSearch) {
    return sharedPreferences.setStringList(userId, listTextSearch);
  }

  List<String> getLocalSaveSearch(String userId) {
    final List<String>? data = sharedPreferences.getStringList(userId);
    return data ?? [];
  }
}
