import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/api/response_model.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/access/data/models/user_info.dart';
import 'package:giapha/features/cay_gia_pha/datasource/models/yeu_cau_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class GhepGiaPhaRemoteDataSourceImpl {
  GhepGiaPhaRemoteDataSourceImpl();

  Future<Either<BaseException, void>> taoYeuCau(YeuCau yeuCau) async {
    late ResponseModel response;

    if (1 == true) {
      return Right(null);
    } else {
      return Left(ServerException('Server error'));
    }
  }

  @override
  Future<Either<BaseException, List<GiaPhaModel>>>
      layDanhSachGiaPhaDaTao() async {
    APIResponse response =
        await ApiService.fetchData(ApiEndpoint.getAllFamilies);

    if (response.status == true) {
      final danhsach = <GiaPhaModel>[];
      for (var e in response.metadata as List<dynamic>) {
        danhsach.add(GiaPhaModel.fromJSON(e));
      }
      danhsach.sort(((a, b) => a.thoiGianTao.compareTo(b.thoiGianTao)));
      return Right(danhsach);
    } else {
      throw ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<Either<BaseException, List<UserInfo>>> layDanhSachNhanh(String rootId, String familyId) async {
    APIResponse response = await ApiService.postData(
      ApiEndpoint.getAllBranch, {
        "rootId": rootId,
        "familyId" : familyId
      }
    );

    if (response.status == true) {
      final danhsach = <UserInfo>[];
      for (var e in response.metadata) {
        danhsach.add(UserInfo.fromJson(e));
      }
      return Right(danhsach);
    } else {
      return Left(ServerException(response.message));
    }
  }
}
