// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';

abstract class SharedEvent extends Equatable {
  const SharedEvent();

  @override
  List<Object> get props => [];
}

class GetPeopleSharedEvent extends SharedEvent {
  String giaPhaId;
  GetPeopleSharedEvent(
     this.giaPhaId,
  );
}

class UpdateRoleSharedPeopleEvent extends SharedEvent {
  final Person person;
  final String option;

  UpdateRoleSharedPeopleEvent(this.person, this.option);
}

class DeleteRoleSharedPeopleEvent extends SharedEvent {
  final Person person;

  DeleteRoleSharedPeopleEvent(this.person);
}
