import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lichviet_flutter_base/core/exceptions/exceptions.dart';

abstract class UseCase<Type, Params> {
  Future<Either<BaseException, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}