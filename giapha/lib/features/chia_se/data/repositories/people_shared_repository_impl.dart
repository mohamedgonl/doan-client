import 'package:giapha/core/core_gia_pha.dart';
import 'package:giapha/features/chia_se/data/datasources/chia_se_remote_datastorage.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:dartz/dartz.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';
import 'package:giapha/features/chia_se/domain/usecases/handle_changes.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class PeopleSharedRepositoryImpl implements PeopleSharedRepository {
  final ChiaSeRemoteDataSource chiaSeRemoteDataSource;
  final NetworkInfo networkInfo;
  List<Person> choosedPeopleTemp = [];
  List<Person> sharedPeopleTemp = [];
  PersonRole generalRole = PersonRole.viewer;

  PeopleSharedRepositoryImpl(this.chiaSeRemoteDataSource, this.networkInfo);

  @override
  Future<Either<BaseException, List<Person>>> getPeopleShared(
      String giaPhaId) async {
    if (await networkInfo.isConnected()) {
      try {
        final people = await chiaSeRemoteDataSource.getPeopleShared(giaPhaId);
        sharedPeopleTemp = (people);
        return Right(people);
      } catch (e) {
        return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
      }
    } else {
      return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  @override
  Future<Either<BaseException, Person>> getPersonFromDB() {
    // TODO: implement getPersonFromDB
    throw UnimplementedError();
  }

  @override
  Future<Either<BaseException, List<Person>>> searchPeople(
      String searchString, String idGiaPha) async {
    if (await networkInfo.isConnected()) {
      try {
        final danhsach =
            await chiaSeRemoteDataSource.search(searchString, idGiaPha);
        return Right(danhsach);
      } catch (e) {
        return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
      }
    } else {
      return Left(ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại"));
    }
  }

  @override
  Future<Either<String, String>> saveEveryChanges() async {
    if (await networkInfo.isConnected()) {
      try {
        await chiaSeRemoteDataSource.saveEveryChanges(
            choosedPeopleTemp, sharedPeopleTemp, generalRole);
        return const Right('');
      } catch (e) {
        return const Left("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
      }
    } else {
      return const Left("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<Either<String, String>> createLinkShare(String option) async {
    if (await networkInfo.isConnected()) {
      try {
        final link = await chiaSeRemoteDataSource.createLinkShare(option);
        return Right(link);
      } catch (e) {
        return const Left('Error');
      }
    } else {
      return const Left('Không có kết nối internet');
    }
  }

  @override
  Either<String, List<Person>> handleChanges(ChangesParams params) {
    switch (params.option) {
      case "ADD":
        if (!choosedPeopleTemp.contains(params.person)) {
          if (choosedPeopleTemp.isEmpty) {
            choosedPeopleTemp.add(params.person!);
          } else {
            final Person person = params.person!;
            person.role = choosedPeopleTemp[0].role;
            person.idGiaPha = choosedPeopleTemp[0].idNhanh;
            choosedPeopleTemp.add(person);
          }
          return Right(choosedPeopleTemp);
        } else {
          return const Left('Người dùng này đã được thêm');
        }
      case "REMOVE":
        choosedPeopleTemp.remove(params.person);
        return Right(choosedPeopleTemp);

      case "PICKED_ROLE_CHANGE":
        for (var i = 0; i < choosedPeopleTemp.length; i++) {
          if (params.role == PersonRole.editer) {
            choosedPeopleTemp[i].idGiaPha = params.branch!;
          }
          choosedPeopleTemp[i].role = params.role;
        }
        return Right(choosedPeopleTemp);

      case "DESTROY_SINGLETON":
        sharedPeopleTemp = [];
        choosedPeopleTemp = [];
        return Right(choosedPeopleTemp);
      default:
        return const Left('DEBUG: NO OPTION');
    }
  }

  @override
  List<Person> updateRoleSharedPeople(ChangesParams changesParams) {
    for (var i = 0; i < sharedPeopleTemp.length; i++) {
      if (sharedPeopleTemp[i].maLichViet == changesParams.person!.maLichViet) {
        if (changesParams.option == "EDIT") {
          sharedPeopleTemp[i].role = PersonRole.editer;
        } else if (changesParams.option == "VIEW") {
          sharedPeopleTemp[i].role = PersonRole.viewer;
        } else {
          sharedPeopleTemp[i].role = PersonRole.delete;
        }
      }
    }

    return sharedPeopleTemp;
  }

  @override
  PersonRole setGeneralAccession(PersonRole role) {
    generalRole = role;
    return generalRole;
  }
}
