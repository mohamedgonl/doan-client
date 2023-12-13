import 'package:dio/dio.dart';

import 'base_exception.dart';

class ServerException extends BaseException {
  ServerException(this.error) : super('Server exception');

  final dynamic error;

  bool get hasError => error != null && error is DioError;
}
