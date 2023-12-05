import 'dart:collection';

import 'package:giapha/core/api/response_model.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/data/datasource/local/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimKiemThanhVienDatasource {
  final ApiHandler _apiHandler;
  final SharedPreferences sharedPreferences;
  const TimKiemThanhVienDatasource(this._apiHandler, this.sharedPreferences);

  Future<List<MemberInfo>> timKiemThanhVienTheoText(
    String keySearch, {
    String? idGiaPha,
    String? idChucVu,
    String? gioiTinh,
    int? year,
    String? die,
  }) async {
    late ResponseModel response;
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
    if(die.isNotNullOrEmpty){
       param.putIfAbsent("die", () => die);
    }

    await _apiHandler
        .post(EndPointConstrants.domain + EndPointConstrants.timKiemThanhVien,
            parser: (json) {
      response = ResponseModel.fromJson(json);
    }, body: param);

    List<MemberInfo> danhSachThanhVien = [];
    for (var e in response.data) {
      danhSachThanhVien.add(MemberInfo.fromJson(e));
    }
    return danhSachThanhVien;
  }

  Future<void> saveLocalSearch(String userId, List<String> listTextSearch) {
    return sharedPreferences.setStringList("" + userId, listTextSearch);
  }

  List<String> getLocalSaveSearch(String userId) {
    final List<String>? data =
        sharedPreferences.getStringList("" + userId);
    return data ?? [];
  }
}
