import 'package:dartz/dartz.dart';
import 'package:giapha/core/core_gia_pha.dart';
import 'package:giapha/features/them_gia_pha/data/datasources/remote_datasource.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';
import 'package:giapha/features/them_gia_pha/domain/repositories/them_or_sua_gia_pha_repository.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class ThemOrSuaGiaPhaRepositoryImpl implements ThemOrSuaGiaPhaRepository {
  final ThemGiaPhaRemoteDataSource remoteDataSourceImpl;
  final NetworkInfo networkInfo;

  ThemOrSuaGiaPhaRepositoryImpl(this.remoteDataSourceImpl, this.networkInfo);
  @override
  Future<Either<String, void>> themGiaPha(
      ThemOrSuaGiaPhaEntity themGiaPhaEntity) async {
    if (await networkInfo.isNotConnected()) {
      return const Left('Không có kết nối mạng');
    } else {
      try {
        final res = await remoteDataSourceImpl.themGiaPha(themGiaPhaEntity);
        return Right(res);
      } catch (e) {
        return Left(e.toString());
      }
    }
  }
}
