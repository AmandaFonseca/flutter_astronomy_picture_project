import 'package:dartz/dartz.dart';
import 'package:flutter_astronomy_picture_project/core/failure.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P parameters);
}

class NoParameter {}
