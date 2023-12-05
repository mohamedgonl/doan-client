import 'package:dartz/dartz.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';

class CreateLinkShare {
  final PeopleSharedRepository repository;

  CreateLinkShare(this.repository);

  Future<Either<String, String>> call(String option) {
    return repository.createLinkShare(option);
  }
}
