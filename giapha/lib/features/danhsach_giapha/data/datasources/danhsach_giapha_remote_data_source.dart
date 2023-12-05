import 'package:dio/dio.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/chia_se/data/models/response_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/danh_sach_gia_pha_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:lichviet_flutter_base/core/core.dart';

abstract class DanhSachGiaPhaRemoteDataSource {
  Future<List<GiaPhaModel>> layDanhSachGiaPha();
  Future<bool> xoaGiaPha(String id);
}

class DanhSachGiaPhaRemoteDataSourceImpl
    implements DanhSachGiaPhaRemoteDataSource {
  final ApiHandler _apiHandler;

  DanhSachGiaPhaRemoteDataSourceImpl(this._apiHandler);

  @override
  Future<List<GiaPhaModel>> layDanhSachGiaPha() async {
    late DanhSachGiaPhaResponseModel response;
    await _apiHandler
        .post( EndPointConstrants.domain + EndPointConstrants.layDanhSachGiaPha,
            parser: (json) {
      response = DanhSachGiaPhaResponseModel.fromJson(json);
    },
            options: Options(headers: {
              "userid": Authentication.userid,
              "secretkey": Authentication.secretkey,
            }));

    if (response.status == true) {
      final danhsach = <GiaPhaModel>[];
      for (var e in response.created) {
        danhsach.add(GiaPhaModel.fromJSON(e));
      }
      for (var e in response.shared) {
        danhsach.add(GiaPhaModel.fromJSON(e));
      }
      danhsach.sort(((a, b) => a.thoiGianTao.compareTo(b.thoiGianTao)));
      return danhsach;
    } else {
      throw ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<bool> xoaGiaPha(String id) async {
    late ResponseModel response;
    await _apiHandler.post( EndPointConstrants.domain +EndPointConstrants.xoaGiaPha, parser: (json) {
      response = ResponseModel.fromJson(json);
    },
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }),
        body: {"genealogy_id": id});
    return response.status;
  }
}
