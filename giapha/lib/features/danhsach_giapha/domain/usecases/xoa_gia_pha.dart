import 'package:dartz/dartz.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/danhsach_giapha/domain/repositories/danhsach_giapha_repository.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class XoaGiaPha implements UseCase<bool, String> {
  final DanhSachGiaPhaRepository repository;

  XoaGiaPha(this.repository);

  @override
  Future<Either<BaseException, bool>> call(String id) {
    return repository.xoaGiaPha(id);
  }
}
