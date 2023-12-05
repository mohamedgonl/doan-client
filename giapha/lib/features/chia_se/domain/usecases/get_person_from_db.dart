import 'package:dartz/dartz.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class GetPersonFromDB implements UseCase<Person, NoParams>{
  final PeopleSharedRepository repository;

  GetPersonFromDB(this.repository);

    @override
  Future<Either<BaseException, Person>> call(NoParams params) {
    return repository.getPersonFromDB();
  }

}
