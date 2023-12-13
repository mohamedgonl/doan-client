import 'package:giapha/core/exceptions/cache_exception.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/features/danhsach_giapha/data/datasources/danhsach_giapha_local_data_source.dart';
import 'package:giapha/features/danhsach_giapha/data/datasources/danhsach_giapha_remote_data_source.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:giapha/features/danhsach_giapha/domain/repositories/danhsach_giapha_repository.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class DanhSachGiaPhaRepositoryImpl implements DanhSachGiaPhaRepository {
  final DanhSachGiaPhaRemoteDataSource remoteDataSource;
  final DanhSachGiaPhaLocalDataSource localDataSource;
  // final NetworkInfo networkInfo;

  DanhSachGiaPhaRepositoryImpl(
      this.remoteDataSource, this.localDataSource);
  @override
  Future<Either<BaseException, List<GiaPha>>> layDanhSachGiaPha() async {
    // if (await networkInfo.isConnected()) {
      try {
        final remoteData = await remoteDataSource.layDanhSachGiaPha();
        localDataSource.cacheDanhSachGiaPha(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerException(
            "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
      }
        catch (e) {
      return Left(ServerException(
          "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));

    }
  }

  @override
  Future<Either<BaseException, bool>> xoaGiaPha(String id) async {
    // if (await networkInfo.isConnected()) {
      final remoteData = await remoteDataSource.xoaGiaPha(id);
      if (remoteData == true) {
        return Right(remoteData);
      } else {
        return Left(ServerException(
            "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
      }
    
  }
}
