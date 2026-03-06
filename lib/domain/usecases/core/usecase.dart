import 'package:astronomy_picture/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P parameters);
}

class NoParameter {}
