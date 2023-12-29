import 'package:dartz/dartz.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:giapha/shared/utils/tree_utils.dart';

class GhepGiaPhaRemoteDataSourceImpl {
  GhepGiaPhaRemoteDataSourceImpl();

  Future<Either<BaseException, void>> ghepGiaPha(
      String srcId, String desId, String familyId) async {
    APIResponse response = await ApiService.postData(ApiEndpoint.mergeFamily,
        {"srcId": srcId, "desId": desId, "familyId": familyId});
    if (response.status) {
      return const Right(null);
    } else {
      return Left(ServerException(response.message));
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

  // @override
  // Future<Either<BaseException, List<UserInfo>>> layDanhSachNhanh(String rootId, String familyId) async {
  //   APIResponse response = await ApiService.postData(
  //     ApiEndpoint.getAllBranch, {
  //       "rootId": rootId,
  //       "familyId" : familyId
  //     }
  //   );

  //   if (response.status == true) {
  //     final danhsach = <UserInfo>[];
  //     for (var e in response.metadata) {
  //       danhsach.add(UserInfo.fromJson(e));
  //     }
  //     return Right(danhsach);
  //   } else {
  //     return Left(ServerException(response.message));
  //   }
  // }

  @override
  Future<Either<BaseException, List<List<Member>>>> ghepPreview(
      String srcId, String desId, String familyId) async {
    APIResponse response = await ApiService.postData(
        ApiEndpoint.ghepPreview, {"srcId": srcId, "desId": desId});

    if (response.status == true) {
      List<List<Member>> giaPhaSrc = [];
      for (var x1 in response.metadata['src']) {
        List<Member> gen = [];
        for (var x2 in x1) {
          Member member = Member.fromJson(x2);
          member.info?.isMerge = true;
          if (member.pids != null) {
            for (var spouse in member.pids!) {
              spouse.isMerge = true;
            }
          }
          gen.add(member);
        }
        giaPhaSrc.add(gen);
      }
      List<List<Member>> giaPhaDes = [];
      for (var x1 in response.metadata['des']) {
        List<Member> gen = [];
        for (var x2 in x1) {
          gen.add(Member.fromJson(x2));
        }
        giaPhaDes.add(gen);
      }

      return Right(TreeUtils.merge2Tree(giaPhaSrc, giaPhaDes, desId));
    } else {
      return Left(ServerException(response.message));
    }
  }
}
