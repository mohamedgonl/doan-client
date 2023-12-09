import 'package:dio/dio.dart';
import 'package:giapha/core/api/response_model.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
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
    // await _apiHandler
    //     .post(EndPointConstrants.domain + EndPointConstrants.layDanhSachGiaPha,
    //         parser: (json) {
      var _json = {
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
              "full_name": "Nông Văn Dền",
              "email": "letonnang@gmail.com",
              "phone": "0439586939",
              "so_doi": "1",
              "so_thanh_vien": "1"
            }
          ],
          "shared": []
        }
      };
      response = DanhSachGiaPhaResponseModel.fromJson(_json);
    //   print(response);
    // },
    //         options: Options(headers: {
    //           "userid": Authentication.userid,
    //           "secretkey": Authentication.secretkey,
    //         }));

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
      throw ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<bool> xoaGiaPha(String id) async {
    late ResponseModel response;
    await _apiHandler.post(EndPointConstrants.domain + EndPointConstrants.xoaGiaPha,
            parser: (json) {
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
