import 'package:dio/dio.dart';

import 'base_exception.dart';

class XemNgayTotException extends BaseException {
  XemNgayTotException(this.error) : super('Xem ngay tot exception');

  final dynamic error;

  bool get hasError => error != null && error is DioError;
}
