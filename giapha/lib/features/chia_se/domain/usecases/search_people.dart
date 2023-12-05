import 'package:dartz/dartz.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:lichviet_flutter_base/core/core.dart';

import '../repositories/people_shared_repository.dart';

class SearchPeople   {
   final PeopleSharedRepository repository;

  SearchPeople(this.repository);


  Future<Either<BaseException, List<Person>>> call(String searchString, String idGiaPha) {
    return repository.searchPeople(searchString,idGiaPha);
  }
}