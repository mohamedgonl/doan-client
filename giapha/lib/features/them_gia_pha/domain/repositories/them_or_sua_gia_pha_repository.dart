import 'package:dartz/dartz.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';
import 'package:giapha/features/them_gia_pha/presentation/bloc/them_gia_pha_bloc.dart';

abstract class ThemOrSuaGiaPhaRepository {
  Future<Either<String, void>> themGiaPha(
      ThemOrSuaGiaPhaEntity themGiaPhaEntity);
}
