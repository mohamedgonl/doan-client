import 'package:dartz/dartz.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';
import 'package:giapha/features/them_gia_pha/domain/repositories/them_or_sua_gia_pha_repository.dart';

class ThemOrSuaGiaPha {
  final ThemOrSuaGiaPhaRepository repository;
  ThemOrSuaGiaPha(this.repository);

  Future<Either<String, void>> call(ThemOrSuaGiaPhaEntity params) {
    return repository.themGiaPha(params);
  }
}
