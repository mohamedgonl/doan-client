import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
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

  Future<Either<BaseException, MemberInfo>> themThanhVien(
      MemberInfo memberInfo) async {
    late MemberInfo newMemBerInfo;
    try {
      APIResponse response =
          await ApiService.postData(ApiEndpoint.addMember, memberInfo.toJson());

      if (response.status == true) {
        newMemBerInfo = MemberInfo.fromJson(response.metadata);
        return Right(newMemBerInfo);
      } else {
        return Left(ServerException(""));
      }
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  Future<Either<BaseException, MemberInfo>> suaThanhVien(
      MemberInfo memberInfo) async {
    late bool status;
    late MemberInfo info;
    try {
      
     
        return Left(ServerException(""));
      
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }
}
