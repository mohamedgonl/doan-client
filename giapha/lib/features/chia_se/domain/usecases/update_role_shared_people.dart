



import 'package:dartz/dartz.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';
import 'package:giapha/features/chia_se/domain/usecases/handle_changes.dart';

class UpdateRoleSharedPeople {
  final PeopleSharedRepository repository;

  UpdateRoleSharedPeople(this.repository);
  @override
 List<Person>call(ChangesParams params) {
    return repository.updateRoleSharedPeople(params);
  }
}
