import 'package:dartz/dartz.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';

class SaveEveryChanges  {
  final PeopleSharedRepository repository;

  SaveEveryChanges(this.repository);

  Future<Either<String, void>> call(NoParams params) {
    return repository.saveEveryChanges();
  }
}
