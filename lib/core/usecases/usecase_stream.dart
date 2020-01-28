
import 'package:dartz/dartz.dart';
import 'package:PainterTest2/core/errors/failures.dart';

abstract class UseCaseStream<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}
