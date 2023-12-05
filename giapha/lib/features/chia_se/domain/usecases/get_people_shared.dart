import 'package:dartz/dartz.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class GetPeopleShared implements UseCase<List<Person>, String> {
  final PeopleSharedRepository repository;

  GetPeopleShared(this.repository);

  @override
  Future<Either<BaseException, List<Person>>> call(String giaPhaId) {
    return repository.getPeopleShared(giaPhaId);
  }
}
