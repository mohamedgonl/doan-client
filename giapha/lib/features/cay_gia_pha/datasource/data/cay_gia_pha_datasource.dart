import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:giapha/core/api/response_model.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/core/exceptions/exceptions.dart';

import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/cay_gia_pha/datasource/models/yeu_cau_model.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class CayGiaPhaDatasource {
  CayGiaPhaDatasource();

  Future<Either<BaseException, List<List<Member>>>> getTreeGenealogy(
      String idGiaPha) async {
    late ResponseModel response;

    try {
      // await _apiHandler.post(
      //   EndPointConstrants.domain + EndPointConstrants.getTreeGenealogy,
      //   parser: (json) {
      //     response = ResponseModel.fromJson(json);
      //   },
      //   body: {
      //     "genealogy_id": idGiaPha,
      //   },
      // );
      response = ResponseModel.fromJson({
        "status": true,
        "data": [
          [
            {
              "ancestor_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "descendant_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "depth": 0,
              "member_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "user_id": null,
              "gia_pha_id": "8183cb71-3b91-41ca-8b32-2240074d423c",
              "mid": null,
              "fid": null,
              "ten": "Nguyen Van A",
              "avatar": null,
              "ten_khac": "nh3",
              "gioi_tinh": "male",
              "ngay_sinh": "2001-11-07T17:00:00.000Z",
              "gio_sinh": "20:11:11",
              "so_dien_thoai": "0121312312312",
              "email": null,
              "trinh_do": null,
              "nguyen_quan": null,
              "dia_chi_hien_tai": null,
              "trang_thai_mat": "1",
              "tieu_su": null,
              "ngay_mat": null,
              "noi_tho_cung": null,
              "nguoi_phu_trach_cung": null,
              "nghe_nghiep": null,
              "mo_tang": null,
              "truc_xuat": "1",
              "ly_do_truc_xuat": null,
              "chuc_vu": null,
              "thoi_gian_tao": "2022-12-14T03:01:40.000Z",
              "id": null,
              "genealogy_id": null,
              "ten_chuc_vu": null,
              "pid": [
                {
                  "ancestor_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
                  "descendant_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
                  "depth": 0,
                  "member_id": "985cdf89-eade-4e6e-83f1-d3a3416c4455",
                  "user_id": null,
                  "gia_pha_id": "8183cb71-3b91-41ca-8b32-2240074d423c",
                  "mid": null,
                  "fid": null,
                  "ten": "Vợ Nguyen Van A",
                  "avatar": null,
                  "ten_khac": "nh3",
                  "gioi_tinh": "male",
                  "ngay_sinh": "2001-11-07T17:00:00.000Z",
                  "gio_sinh": "20:11:11",
                  "so_dien_thoai": "0121312312312",
                  "email": null,
                  "trinh_do": null,
                  "nguyen_quan": null,
                  "dia_chi_hien_tai": null,
                  "trang_thai_mat": "1",
                  "tieu_su": null,
                  "ngay_mat": null,
                  "noi_tho_cung": null,
                  "nguoi_phu_trach_cung": null,
                  "nghe_nghiep": null,
                  "mo_tang": null,
                  "truc_xuat": "1",
                  "ly_do_truc_xuat": null,
                  "chuc_vu": null,
                  "thoi_gian_tao": "2022-12-14T03:01:40.000Z",
                  "id": null,
                  "genealogy_id": null,
                  "ten_chuc_vu": null,
                }
              ]
            }
          ],
          [
            {
              "ancestor_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "descendant_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "depth": 1,
              "member_id": "985cdf89-eade-4e6e-83f1-d3a3416c44fe",
              "user_id": null,
              "gia_pha_id": "8183cb71-3b91-41ca-8b32-2240074d423c",
              "mid": "985cdf89-eade-4e6e-83f1-d3a3416c4455",
              "fid": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "ten": "Nguyen Van B",
              "avatar": null,
              "ten_khac": "nh3",
              "gioi_tinh": "male",
              "ngay_sinh": "2001-11-07T17:00:00.000Z",
              "gio_sinh": "20:11:11",
              "so_dien_thoai": "0121312312312",
              "email": null,
              "trinh_do": null,
              "nguyen_quan": null,
              "dia_chi_hien_tai": null,
              "trang_thai_mat": "1",
              "tieu_su": null,
              "ngay_mat": null,
              "noi_tho_cung": null,
              "nguoi_phu_trach_cung": null,
              "nghe_nghiep": null,
              "mo_tang": null,
              "truc_xuat": "1",
              "ly_do_truc_xuat": null,
              "chuc_vu": null,
              "thoi_gian_tao": "2022-12-14T03:01:40.000Z",
              "id": null,
              "genealogy_id": null,
              "ten_chuc_vu": null,
              "pid": []
            },
            {
              "ancestor_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "descendant_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "depth": 1,
              "member_id": "985cdf89-eade-4e6e-83f1-d3a3416c44fc",
              "user_id": null,
              "gia_pha_id": "8183cb71-3b91-41ca-8b32-2240074d423c",
              "mid": null,
              "fid": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "ten": "Nguyen Van C",
              "avatar": null,
              "ten_khac": "nh3",
              "gioi_tinh": "male",
              "ngay_sinh": "2001-11-07T17:00:00.000Z",
              "gio_sinh": "20:11:11",
              "so_dien_thoai": "0121312312312",
              "email": null,
              "trinh_do": null,
              "nguyen_quan": null,
              "dia_chi_hien_tai": null,
              "trang_thai_mat": "1",
              "tieu_su": null,
              "ngay_mat": null,
              "noi_tho_cung": null,
              "nguoi_phu_trach_cung": null,
              "nghe_nghiep": null,
              "mo_tang": null,
              "truc_xuat": "1",
              "ly_do_truc_xuat": null,
              "chuc_vu": null,
              "thoi_gian_tao": "2022-12-14T03:01:40.000Z",
              "id": null,
              "genealogy_id": null,
              "ten_chuc_vu": null,
              "pid": []
            }
          ],
          [
            {
              "ancestor_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "descendant_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "depth": 1,
              "member_id": "985cdf89-eade-4e6e-83f1-d3a3416c4423",
              "user_id": null,
              "gia_pha_id": "8183cb71-3b91-41ca-8b32-2240074d423c",
              "mid": null,
              "fid": "985cdf89-eade-4e6e-83f1-d3a3416c44fc",
              "ten": "Cháu đời 3 A",
              "avatar": null,
              "ten_khac": "nh3",
              "gioi_tinh": "male",
              "ngay_sinh": "2001-11-07T17:00:00.000Z",
              "gio_sinh": "20:11:11",
              "so_dien_thoai": "0121312312312",
              "email": null,
              "trinh_do": null,
              "nguyen_quan": null,
              "dia_chi_hien_tai": null,
              "trang_thai_mat": "1",
              "tieu_su": null,
              "ngay_mat": null,
              "noi_tho_cung": null,
              "nguoi_phu_trach_cung": null,
              "nghe_nghiep": null,
              "mo_tang": null,
              "truc_xuat": "1",
              "ly_do_truc_xuat": null,
              "chuc_vu": null,
              "thoi_gian_tao": "2022-12-14T03:01:40.000Z",
              "id": null,
              "genealogy_id": null,
              "ten_chuc_vu": null,
              "pid": []
            },
            {
              "ancestor_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "descendant_id": "985cdf89-eade-4e6e-83f1-d3a3416c44ff",
              "depth": 1,
              "member_id": "985cdf89-eade-4e6e-83f1-d3a3416c4444",
              "user_id": null,
              "gia_pha_id": "8183cb71-3b91-41ca-8b32-2240074d423c",
              "mid": null,
              "fid": "985cdf89-eade-4e6e-83f1-d3a3416c44fc",
              "ten": "Cháu đời 3 B",
              "avatar": null,
              "ten_khac": "nh3",
              "gioi_tinh": "male",
              "ngay_sinh": "2001-11-07T17:00:00.000Z",
              "gio_sinh": "20:11:11",
              "so_dien_thoai": "0121312312312",
              "email": null,
              "trinh_do": null,
              "nguyen_quan": null,
              "dia_chi_hien_tai": null,
              "trang_thai_mat": "1",
              "tieu_su": null,
              "ngay_mat": null,
              "noi_tho_cung": null,
              "nguoi_phu_trach_cung": null,
              "nghe_nghiep": null,
              "mo_tang": null,
              "truc_xuat": "1",
              "ly_do_truc_xuat": null,
              "chuc_vu": null,
              "thoi_gian_tao": "2022-12-14T03:01:40.000Z",
              "id": null,
              "genealogy_id": null,
              "ten_chuc_vu": null,
              "pid": []
            }
          ]
        ]
      });
      final result = <List<Member>>[];
      // for (List value in response.data) {
      //   final item = <Member>[];
      //   for (var element in value) {
      //     item.add(Member.fromJson(element));
      //   }
      //   result.add(item);
      // }
      return Right(result);
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

  // Future<Either<BaseException, void>> xoaThanhVien(String memberId) async {
  //   late bool status;
  //   try {
  //     await _apiHandler.post(
  //       EndPointConstrants.domain + EndPointConstrants.xoaThanhVien,
  //       parser: (json) {
  //         status = json['status'];
  //       },
  //       body: {"id": memberId},
  //       options: Options(headers: {
  //         "userid": Authentication.userid,
  //         "secretkey": Authentication.secretkey,
  //       }),
  //     );

  //     if (status == true) {
  //       return const Right(null);
  //     } else {
  //       return Left(ServerException(
  //           "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
  //     }
  //   } catch (e) {
  //     return Left(ServerException(
  //         "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
  //   }
  // }

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
    List<MemberInfo> listCreated,
    List<String> listIdDelete,
    List<MemberInfo> listUpdated,
  ) async {
    late bool result;

    Map<String, dynamic> bodyParam = HashMap();
    bodyParam.putIfAbsent("created",
        () => json.encode(listCreated.map((e) => e.toJson()).toList()));

    bodyParam.putIfAbsent("deleted", () => json.encode(listIdDelete));

    bodyParam.putIfAbsent("updated",
        () => json.encode(listUpdated.map((e) => e.toJson()).toList()));

    // await _apiHandler.post(
    //   EndPointConstrants.domain + EndPointConstrants.suaNhieuAction,
    //   parser: (json) {
    //     result = json['status'];
    //   },
    //   body: bodyParam,
    // );
    // if (result) {
    //   return Right(result);
    // } else {
    return Left(ServerException("Lưu cây phả hệ thất bại"));
    // }
  }
}
