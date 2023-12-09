import 'dart:collection';

import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/data/datasource/local/key_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimKiemGiaPhaDatasource {
  final ApiHandler _apiHandler;
  final SharedPreferences sharedPreferences;
  const TimKiemGiaPhaDatasource(this._apiHandler, this.sharedPreferences);

  Future<List<GiaPhaModel>> timKiemGiaPhaTheoText(String keySearch) async {
    Map response = HashMap();
    await _apiHandler
        .post(EndPointConstrants.domain + EndPointConstrants.timKiemGiaPha,
            parser: (json) {
      response = json;
    }, body: {"text_search": keySearch});

    List<GiaPhaModel> danhSachGiaPha = [];
    for (var e in response['data']) {
      danhSachGiaPha.add(GiaPhaModel.fromJSON(e));
    }
    return danhSachGiaPha;
  }

  Future<void> saveLocalSearch(String userId, List<String> listTextSearch) {
    return sharedPreferences.setStringList(
        "" + userId, listTextSearch);
  }

  List<String> getLocalSaveSearch(String userId) {
    final List<String>? data =
        sharedPreferences.getStringList("" + userId);
    return data ?? [];
  }
}
