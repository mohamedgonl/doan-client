import 'package:dartz/dartz.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/domain/usecases/handle_changes.dart';
import 'package:lichviet_flutter_base/core/core.dart';

abstract class PeopleSharedRepository {
  Future<Either<BaseException, Person>> getPersonFromDB();
  Future<Either<BaseException, List<Person>>> getPeopleShared(String giaPhaId);
  Future<Either<String, void>> saveEveryChanges();
  Future<Either<BaseException, List<Person>>> searchPeople(String searchString, String idGiaPha);
  Future<Either<String, String>> createLinkShare(String option);
  Either<String, List<Person>> handleChanges(ChangesParams changesParams);
  List<Person> updateRoleSharedPeople(ChangesParams changesParams);
  PersonRole setGeneralAccession(PersonRole role);
}
