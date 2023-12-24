import 'package:dartz/dartz.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';

// import 'package:lichviet_flutter_base/core/core.dart';

class QuanLyThanhVienDataSource {
  QuanLyThanhVienDataSource();

  Future<Either<BaseException, Member>> layThanhVien(String memberId) async {
    late bool status;
    late Member member;
    try {
      return Left(ServerException(""));
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  Future<Either<BaseException, UserInfo>> themThanhVien(
      UserInfo memberInfo) async {
    late UserInfo newMemBerInfo;
    try {
      APIResponse response =
          await ApiService.postData(ApiEndpoint.addMember, memberInfo.toJson());

      if (response.status == true) {
        newMemBerInfo = UserInfo.fromJson(response.metadata);
        return Right(newMemBerInfo);
      } else {
        return Left(ServerException(""));
      }
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  Future<Either<BaseException, UserInfo>> suaThanhVien(
      UserInfo memberInfo) async {
    try {
      APIResponse response = await ApiService.postData(
          ApiEndpoint.editMember, memberInfo.toJson());
      if (response.status) {
        return Right(UserInfo.fromJson(response.metadata));
      } else {
        return Left(ServerException(response.message));
      }
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }
}
