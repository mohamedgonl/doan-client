import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';

import 'package:lichviet_flutter_base/core/core.dart';

class QuanLyThanhVienDataSource {
  final ApiHandler _apiHandler;

  QuanLyThanhVienDataSource(this._apiHandler);

  Future<Either<BaseException, Member>> layThanhVien(String memberId) async {
    late bool status;
    late Member member;
    try {
      await _apiHandler.post(
        EndPointConstrants.domain + EndPointConstrants.layThanhVien,
        parser: (json) {
          status = json['status'];
          member = Member.fromJson(json['data']);
        },
        body: {'id': memberId},
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }),
      );

      if (status == true) {
        return Right(member);
      } else {
        return Left(ServerException(""));
      }
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  Future<Either<BaseException, MemberInfo>> themThanhVien(
      MemberInfo memberInfo) async {
    late bool status;
    late MemberInfo newMemBerInfo;
    try {
      await _apiHandler.post(
        EndPointConstrants.domain + EndPointConstrants.themThanhVien,
        parser: (json) {
          status = json['status'];
          newMemBerInfo = MemberInfo.fromJson(json['data']);
        },
        body: memberInfo.toJson(),
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }),
      );

      if (status == true) {
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
      await _apiHandler.post(
        EndPointConstrants.domain + EndPointConstrants.suaThanhVien,
        parser: (json) {
          status = json['status'];
          info = MemberInfo.fromJson(json['data']);
        },
        body: memberInfo.toJson(),
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }),
      );

      if (status == true) {
        return Right(info);
      } else {
        return Left(ServerException(""));
      }
    } catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }
}
