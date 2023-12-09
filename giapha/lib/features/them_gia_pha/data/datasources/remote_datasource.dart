import 'package:dio/dio.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/them_gia_pha/data/models/them_gia_pha_model.dart';
import 'package:giapha/features/them_gia_pha/data/models/them_gia_pha_response.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';
import 'package:lichviet_flutter_base/core/core.dart';

abstract class ThemGiaPhaRemoteDataSource {
  Future<String> themGiaPha(ThemOrSuaGiaPhaEntity themGiaPhaModel);
}

class ThemGiaPhaRemoteDataSourceImpl implements ThemGiaPhaRemoteDataSource {
  final ApiHandler _apiHandler;

  ThemGiaPhaRemoteDataSourceImpl(this._apiHandler);

  @override
  Future<String> themGiaPha(ThemOrSuaGiaPhaEntity themGiaPhaEntity) async {
    late ThemGiaPhaResponse response;
    await _apiHandler.post(
      EndPointConstrants.domain +
          (themGiaPhaEntity.giaPhaId.isNullOrEmpty
              ? EndPointConstrants.taoGiaPha
              : EndPointConstrants.suaGiaPha),
      parser: (json) {
        response = ThemGiaPhaResponse.fromJson(json);
      },
      body: ThemGiaPhaModel(
              giaPhaId: themGiaPhaEntity.giaPhaId,
              tenGiaPha: themGiaPhaEntity.tenGiaPha,
              tenNhanh: themGiaPhaEntity.tenNhanh,
              diaChi: themGiaPhaEntity.diaChi,
              moTa: themGiaPhaEntity.moTa)
          .toJSON(),
    );
    if (response.status == true) {
      return "OK";
    } else {
      return "Error";
    }
  }
}
