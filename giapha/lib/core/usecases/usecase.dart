import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/core/exceptions/base_exception.dart';


abstract class UseCase<Type, Params> {
  Future<Either<BaseException, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}