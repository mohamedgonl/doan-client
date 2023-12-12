import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:lichviet_flutter_base/core/core.dart';

abstract class DanhSachGiaPhaRemoteDataSource {
  Future<List<GiaPhaModel>> layDanhSachGiaPha();
  Future<bool> xoaGiaPha(String id);
}

class DanhSachGiaPhaRemoteDataSourceImpl
    implements DanhSachGiaPhaRemoteDataSource {
  DanhSachGiaPhaRemoteDataSourceImpl();

  @override
  Future<List<GiaPhaModel>> layDanhSachGiaPha() async {
    APIResponse response =
        await ApiService.fetchData(ApiEndpoint.getAllFamilies);

    if (response.status == true) {
      final danhsach = <GiaPhaModel>[];
      for (var e in response.metadata as List<dynamic>) {
        danhsach.add(GiaPhaModel.fromJSON(e));
      }
      danhsach.sort(((a, b) => a.thoiGianTao.compareTo(b.thoiGianTao)));
      return danhsach;
    } else {
      throw ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<bool> xoaGiaPha(String id) async {
    APIResponse response =
        await ApiService.fetchData("${ApiEndpoint.deleteFamily}/$id");
    return response.status;
  }
}
