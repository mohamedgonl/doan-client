import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:giapha/core/api/response_model.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/models/yeu_cau_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class GhepGiaPhaRemoteDataSourceImpl {
  final ApiHandler _apiHandler;

  GhepGiaPhaRemoteDataSourceImpl(this._apiHandler);

  Future<Either<BaseException, void>> taoYeuCau(YeuCau yeuCau) async {
    late ResponseModel response;
    await _apiHandler.post( EndPointConstrants.domain +EndPointConstrants.layDanhSachGiaPha,
        parser: (json) {
      response = ResponseModel.fromJson(json);
    },
        body: yeuCau.toMap(),
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }));

    if (response.status == true) {
      return Right(null);
    } else {
      return Left(ServerException('Server error'));
    }
  }

  @override
  Future<Either<BaseException, List<GiaPhaModel>>>
      layDanhSachGiaPhaDaTao() async {
    await _apiHandler.post( EndPointConstrants.domain +EndPointConstrants.layDanhSachGiaPha,
        parser: (json) {
    },
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }));

    if (1== true) {
      final danhsach = <GiaPhaModel>[];
      // for (var e in response.created) {
      //   danhsach.add(GiaPhaModel.fromJSON(e));
      // }
      return Right(danhsach);
    } else {
      return Left(ServerException('Server error'));
    }
  }

  //   @override
  // Future<Either<BaseException, List<MemberInfo>>>
  //     layDanhSachNhanh() async {
  //   late ResponseModel response;
  //   await _apiHandler.post(EndPointConstrants.getTreeGenealogy,
  //       parser: (json) {
  //     response = ResponseModel.fromJson(json);
  //   },
  //       options: Options(headers: {
  //         "userid": Authentication.userid,
  //         "secretkey": Authentication.secretkey,
  //       }));

  //   if (response.status == true) {
  //     final danhsach = <MemberInfo>[];
  //     for (var e in response.data) {
  //       fo
  //     }
     
  //     return Right(danhsach);
  //   } else {
  //     return Left(ServerException('Server error'));
  //   }
  // }
}
