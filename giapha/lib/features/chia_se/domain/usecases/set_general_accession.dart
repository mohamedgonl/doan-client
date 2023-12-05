import 'package:dartz/dartz.dart';
import 'package:giapha/core/core_gia_pha.dart';
import 'package:giapha/core/usecases/usecase.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';

import '../repositories/people_shared_repository.dart';

class SetGeneralAccession {
   final PeopleSharedRepository repository;

  SetGeneralAccession(this.repository);


   @override
  PersonRole call(PersonRole role) {
    return repository.setGeneralAccession(role);
  }
}