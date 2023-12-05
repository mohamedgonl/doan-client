import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:giapha/core/api/response_model.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/quanly_thanhvien/data/models/chucvu_model.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class QuanLyChucVuDataSource {
  final ApiHandler _apiHandler;
  QuanLyChucVuDataSource(this._apiHandler);

  Future<Either<BaseException, ChucVuModel>> themChucVu(
      String giaPhaId, String newChucVu) async {
    late bool status;
    late Map<String, dynamic> data;
    try {
      await _apiHandler
          .post(EndPointConstrants.domain + EndPointConstrants.themChucVu,
              parser: (json) {
        status = json['status'];
        data = json['data'];
      },
              body: {"genealogy_id": giaPhaId, "ten_chuc_vu": newChucVu},
              options: Options(headers: {
                "userId": Authentication.userid,
                "secretkey": Authentication.secretkey,
              }));
      if (status) {
        return Right(ChucVuModel.fromJSON(data));
      } else {
        return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
      }
    } catch (e) {
      return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  Future<Either<BaseException, String>> xoaChucVu(String id) async {
    late ResponseModel response;
    late bool status;
    try {
      await _apiHandler
          .post(EndPointConstrants.domain + EndPointConstrants.xoaChucVu,
              parser: (json) {
        status = json['status'];
      },
              body: {"id": id},
              options: Options(headers: {
                "userId": Authentication.userid,
                "secretkey": Authentication.secretkey,
              }));
      if (status) {
        return Right(id);
      } else
        return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    } catch (e) {
      return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  Future<Either<BaseException, List<ChucVuModel>>> layChucVu(
      String giaPhaId) async {
    late ResponseModel response;
    try {
      print(giaPhaId);
      await _apiHandler
          .post(EndPointConstrants.domain + EndPointConstrants.layChucVu,
              parser: (json) {
        print(json);
        response = ResponseModel.fromJson(json);
      }, body: {"genealogy": giaPhaId});

      if (response.status) {
        List<ChucVuModel> chucvuModel = [];
        for (var e in response.data) {
          ChucVuModel chucVu = ChucVuModel.fromJSON(e);
          chucvuModel.add(chucVu);
        }
        return Right(chucvuModel);
      } else {
        return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
      }
    } catch (e) {
      return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  Future<Either<BaseException, List>> capNhapChucVu(
      String id, String newChucVu) async {
    late bool status;
    try {
      await _apiHandler
          .post(EndPointConstrants.domain + EndPointConstrants.capNhapChucVu,
              parser: (json) {
        status = json['status'];
      },
              body: {"id": id, "ten_chuc_vu": newChucVu},
              options: Options(headers: {
                "userId": Authentication.userid,
                "secretkey": Authentication.secretkey,
              }));
      if (status) {
        return Right(<String>[id, newChucVu]);
      } else
        return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    } catch (e) {
      return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }
}
