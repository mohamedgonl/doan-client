part of 'access_bloc.dart';

abstract class AccessState extends Equatable {
  const AccessState();  

  @override
  List<Object> get props => [];
}
class AccessInitial extends AccessState {}
