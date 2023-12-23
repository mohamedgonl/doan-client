import 'dart:collection';

import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimKiemGiaPhaDatasource {
  final SharedPreferences sharedPreferences;
  const TimKiemGiaPhaDatasource(this.sharedPreferences);

  Future<List<GiaPhaModel>> timKiemGiaPhaTheoText(String keySearch) async {
    APIResponse apiResponse = await ApiService.postData(
        ApiEndpoint.searchFamilyByText, {"text": keySearch});

    List<GiaPhaModel> danhSachGiaPha = [];
    if (apiResponse.status) {
      for (var e in apiResponse.metadata) {
        danhSachGiaPha.add(GiaPhaModel.fromJSON(e));
      }
    }
    return danhSachGiaPha;
  }

  Future<void> saveLocalSearch(String userId, List<String> listTextSearch) {
    return sharedPreferences.setStringList(userId, listTextSearch);
  }

  List<String> getLocalSaveSearch(String userId) {
    final List<String>? data = sharedPreferences.getStringList(userId);
    return data ?? [];
  }
}
