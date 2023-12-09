import 'package:dartz/dartz.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:giapha/features/danhsach_giapha/domain/repositories/danhsach_giapha_repository.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class LayDanhSachGiaPha implements UseCase<List<GiaPha>, NoParams> {
  final DanhSachGiaPhaRepository repository;

  LayDanhSachGiaPha(this.repository);

  @override
  Future<Either<BaseException, List<GiaPha>>> call(NoParams params) {
    return repository.layDanhSachGiaPha();
  }
}
