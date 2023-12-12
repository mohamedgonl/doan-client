import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';

abstract class ThemGiaPhaRemoteDataSource {
  Future<String> themGiaPha(ThemOrSuaGiaPhaEntity themGiaPhaModel);
}

class ThemGiaPhaRemoteDataSourceImpl implements ThemGiaPhaRemoteDataSource {
  ThemGiaPhaRemoteDataSourceImpl();

  @override
  Future<String> themGiaPha(ThemOrSuaGiaPhaEntity themGiaPhaEntity) async {
    APIResponse response = await ApiService.postData(
        ApiEndpoint.editFamilyInfo, themGiaPhaEntity.toJSON());
    if (response.status == true) {
      return "OK";
    } else {
      return "Error";
    }
  }
}
