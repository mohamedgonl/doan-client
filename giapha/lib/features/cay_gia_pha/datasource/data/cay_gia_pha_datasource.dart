import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:giapha/core/api/response_model.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/core/values/api_endpoint.dart';

import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/cay_gia_pha/datasource/models/yeu_cau_model.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class CayGiaPhaDatasource {
  CayGiaPhaDatasource();

  Future<Either<BaseException, List<List<Member>>>> getTreeGenealogy(
      String idGiaPha) async {
    try {
      APIResponse response = await ApiService.postData(
          ApiEndpoint.getTree, {"familyId": idGiaPha});

      if (response.status == true) {
        final result = <List<Member>>[];
        for (List value in response.metadata) {
          final item = <Member>[];
          for (var element in value) {
            item.add(Member.fromJson(element));
          }
          result.add(item);
        }
        return Right(result);
      } else {
        return Left(ServerException(response.message));
      }
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  // Future<Either<BaseException, List<MemberInfo>>> getDanhSachNguoiMat(
  //     String idGiaPha,
  //     {String? textSearch}) async {
  //   late ResponseModel response;

  //   Map<String, dynamic> bodyParam = HashMap();
  //   bodyParam.putIfAbsent("genealogy_id", () => idGiaPha);
  //   if (textSearch.isNotNullOrEmpty) {
  //     bodyParam.putIfAbsent("text_search", () => textSearch);
  //   }

  //   await _apiHandler.post(
  //     EndPointConstrants.domain + EndPointConstrants.layDanhSachNguoiMAt,
  //     parser: (json) {
  //       print(json);
  //       response = ResponseModel.fromJson(json);
  //     },
  //     body: bodyParam,
  //   );
  //   final result = <MemberInfo>[];
  //   for (var value in response.data) {
  //     result.add(MemberInfo.fromJson(value));
  //   }
  //   return Right(result);
  // }

  Future<Either<BaseException, void>> xoaThanhVien(
      String memberId, String familyId) async {
    late bool status;
    try {
      APIResponse response = await ApiService.postData(
          ApiEndpoint.deleteMember, {"familyId": familyId, "_id": memberId});
      if (response.status == true) {
        return const Right(null);
      } else {
        return Left(ServerException(
            "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
      }
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  // Future<Either<BaseException, List<YeuCau>>> layYeuCauGhepGiaPha() async {
  //   late ResponseModel response;
  //   try {
  //     await _apiHandler.post(
  //       EndPointConstrants.domain + EndPointConstrants.layYeuCauGhepGiaPha,
  //       parser: (json) {
  //         response = ResponseModel.fromJson(json);
  //       },
  //       options: Options(headers: {
  //         "userid": Authentication.userid,
  //         "secretkey": Authentication.secretkey,
  //       }),
  //     );

  //     if (response.status == true) {
  //       List<YeuCau> danhsach_yeucau = [];
  //       for (var e in response.data) {
  //         danhsach_yeucau.add(YeuCau.fromMap(e));
  //       }
  //       return Right(danhsach_yeucau);
  //     } else {
  //       return Left(ServerException(
  //           "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
  //     }
  //   } catch (e) {
  //     return Left(ServerException(
  //         "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
  //   }
  // }

  // Future<Either<BaseException, List<YeuCau>>> chapNhapYeuCauGhepGiaPha(
  //     String id) async {
  //   late ResponseModel response;
  //   try {
  //     await _apiHandler.post(
  //       EndPointConstrants.domain + EndPointConstrants.layYeuCauGhepGiaPha,
  //       parser: (json) {
  //         response = ResponseModel.fromJson(json);
  //       },
  //       options: Options(headers: {
  //         "userid": Authentication.userid,
  //         "secretkey": Authentication.secretkey,
  //       }),
  //     );

  //     if (response.status == true) {
  //       List<YeuCau> danhsach_yeucau = [];
  //       for (var e in response.data) {
  //         danhsach_yeucau.add(YeuCau.fromMap(e));
  //       }
  //       return Right(danhsach_yeucau);
  //     } else {
  //       return Left(ServerException(
  //           "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
  //     }
  //   } catch (e) {
  //     return Left(ServerException(
  //         "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
  //   }
  // }

  Future<Either<BaseException, bool>> luuNhieuAction(
      List<UserInfo> listCreated,
      List<String> listIdDelete,
      List<UserInfo> listUpdated,
      String familyId) async {
    try {
      Map<String, dynamic> bodyParam = HashMap();
      bodyParam.putIfAbsent(
          "created", () => (listCreated.map((e) => e.toJson()).toList()));

      bodyParam.putIfAbsent("deleted", () => (listIdDelete));

      bodyParam.putIfAbsent(
          "updated", () => (listUpdated.map((e) => e.toJson()).toList()));

      bodyParam.putIfAbsent("familyId", () => familyId);

      APIResponse response =
          await ApiService.postData(ApiEndpoint.handleMutipleAction, bodyParam);
      if (response.status) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(ServerException(e.toString()));
    }
  }
}
