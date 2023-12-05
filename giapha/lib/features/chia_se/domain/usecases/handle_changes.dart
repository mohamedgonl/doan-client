// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/domain/repositories/people_shared_repository.dart';

class HandleChanges {
  final PeopleSharedRepository repository;

  HandleChanges(this.repository);
  @override
  Either<String, List<Person>> call(ChangesParams params) {
    return repository.handleChanges(params);
  }
}

class ChangesParams {
  Person? person;
  String option;
  PersonRole role;
  String? branch;
  ChangesParams(
      {this.person, required this.option, this.role = PersonRole.viewer, this.branch});
}
