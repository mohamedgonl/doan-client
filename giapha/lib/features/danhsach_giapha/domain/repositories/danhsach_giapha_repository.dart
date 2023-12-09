

import 'package:dartz/dartz.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:lichviet_flutter_base/core/core.dart';

abstract class DanhSachGiaPhaRepository {
  Future<Either<BaseException, List<GiaPha>>> layDanhSachGiaPha();
  Future<Either<BaseException, bool>> xoaGiaPha(String id);
}
