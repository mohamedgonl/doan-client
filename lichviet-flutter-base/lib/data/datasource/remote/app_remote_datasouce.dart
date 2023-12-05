
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/data/datasource/remote/end_points.dart';
import 'package:lichviet_flutter_base/data/model/error_model.dart';

abstract class AppRemoteDataSource {
  Future<List<ErrorModel>> getErrorList();
}

class AppRemoteDataSourceImpl implements AppRemoteDataSource {
  final ApiHandler _apiHandlerNative;

  AppRemoteDataSourceImpl(this._apiHandlerNative);

  @override
  Future<List<ErrorModel>> getErrorList() async {
    final errorList = <ErrorModel>[];
    
    final result = await _apiHandlerNative.post(EndPoints.errorList,
        parser: (json) => json);
    for (var element in (result['data'] as List)) {
      errorList.add(ErrorModel.fromJson(element));
    }
    return errorList;
  }
}